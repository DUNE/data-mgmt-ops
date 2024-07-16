''' tester for one file from each dataset '''
#
##
# @mainpage FileChecker
#
# @section description_main
#
#  
# @file FileChecker.py

# pylint: disable=C0303
# pylint: disable=C0321 
# pylint: disable=C0301  
# pylint: disable=C0209
# pylint: disable=C0103 
# pylint: disable=C0325 
# pylint: disable=C0123
# pyline: disable=W1514


# need to implement this
#from argparse import ArgumentParser as ap

import sys
import os
import json
import csv
import datetime

from TypeChecker import TypeChecker

from metacat.webapi import MetaCatClient

DEBUG=False

if __name__ == '__main__':

    if len(sys.argv) != 3:
        print ("arguments are workflowmin and workflowmax")
        sys.exit(1)
    workflowmin = int(sys.argv[1])
    workflowmax = int(sys.argv[2])
    
    mc_client = MetaCatClient(os.getenv("METACAT_SERVER_URL"))
    #if len(sys.argv) < 2:
    #    print ("need a namespace:name as input")
    #else:
    #    thedid = sys.argv[1]

    workflows = range(workflowmin,workflowmax+1)
    data = {}
    for workflow in workflows:
        errfilename="workflow%d.err"%(workflow)
        errfile = open(errfilename,'w')
        
        data[workflow]={}

        query = "files where dune.workflow['workflow_id'] in (%d) and core.run_type=hd-protodune and core.file_type=detector"%(workflow)
        print (query)
        try:
            result = mc_client.query(query,summary="count")
        except:
            print("query failed")
            continue
        if result["count"]<1:
            continue
        if DEBUG: print (result)
        query = "files where dune.workflow['workflow_id'] in (%d) and core.run_type=hd-protodune and core.file_type=detector limit 1"%(workflow)
        try:
            result = list(mc_client.query(query))
        except:
            print("query failed")
            continue
        fid = result[0]["fid"]

        try:
            result = mc_client.get_file(fid=fid,with_metadata=True)
        except:
            print("query failed")
            continue
        if "metadata" not in result:
            continue
        stream = result["metadata"]["core.data_stream"]
        for data_stream in [stream]:
            data[workflow][data_stream] = {}

            for data_tier in ["raw","trigprim","full-reconstructed","root-tuple","root-tuple-virtual"]:
        
                query = "files where dune.workflow['workflow_id'] in (%d) and core.run_type=hd-protodune and core.file_type=detector and core.data_tier=%s and core.data_stream=%s "%(workflow,data_tier,data_stream)
                
                if DEBUG: print (data_stream,query)
                try:
                    result = mc_client.query(query,summary="count")
                except:
                    print("query failed")
                    continue
                #print (workflow,data_tier,result)
                if result["count"] == 0: continue
                gb = int(result["total_size"]/1000./1000.)/1000.
                result["total_size_gb"]=gb
                result.pop("total_size")
                result["size_per_file_gb"] = gb/result["count"]
                if result["size_per_file_gb"] < 0.001:
                    print ("\n WARNING VERY SMALL FILES:",workflow,data_stream,data_tier,result["size_per_file_gb"]*1000,"MB\n" )
                data[workflow][data_stream][data_tier]=result
                print (workflow,data_stream,data_tier,result)
                newquery = query+" limit 1"
                
                try:
                    result = list(mc_client.query(newquery))
                    if DEBUG: print (result)
                    thefile = result[0]["fid"]
                    if DEBUG: print(thefile,newquery)
                    filemd = mc_client.get_file(fid=thefile,with_metadata=True,with_provenance=True)

                except:
                    print("single file query failed")
                    
                print (filemd["namespace"]+":"+filemd["name"])
                status,fixes = TypeChecker(filemd=filemd,errfile=errfile,verbose=False)
                print ("one file check",status,fixes)

        print(workflow, data[workflow])
    final = json.dumps(data,indent=4)   
    fname = "audit-workflow-%d-%d.json"%(workflowmin,workflowmax)
    f = open(fname,'w')
    f.write(final)
    f.close()

    summary = []
    fieldnames = ["workflow","data_stream"]
    for workflow in data:
        record = {}
        record["workflow"]=workflow
        thestream = None
        for stream in data[workflow]:
            print (workflow, stream, data[workflow][stream])
            thestream = stream
            record["data_stream"]=thestream
            #print (workflow, thestream, data[workflow][thestream])
            for tier in data[workflow][thestream]:
                #print (workflow, thestream, tier, data[workflow][thestream][tier])
                #record["data_tier"]=tier
                for field in data[workflow][thestream][tier]:
                    name = "%s:%s"%(tier,field)
                    value = data[workflow][thestream][tier][field]
                    record[name]=value
                    print (record)
                    if name not in fieldnames:
                        fieldnames.append(name)
                    #print (name,value)
            
            summary.append(record)
            print(workflow,thestream,record)
                    
    newfile = fname.replace("json","csv")
    with open(newfile, 'w', newline='') as csvfile:
        
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)

        writer.writeheader()
        for workflow in summary:
            writer.writerow(workflow)

