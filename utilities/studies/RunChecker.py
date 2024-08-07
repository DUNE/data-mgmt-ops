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

from TimeUtil import unix_to_timestamp

if __name__ == '__main__':

    if len(sys.argv) < 3:
        print ("arguments are runmin and runmax + optional version ")
        sys.exit(1)
    runmin = int(sys.argv[1])
    runmax = int(sys.argv[2])
    if len(sys.argv) > 3:
        version = sys.argv[3]
    else:
        version = None
    
    mc_client = MetaCatClient(os.getenv("METACAT_SERVER_URL"))
    #if len(sys.argv) < 2:
    #    print ("need a namespace:name as input")
    #else:
    #    thedid = sys.argv[1]

    runs = range(runmin,runmax+1)
    data = {}
    for run in runs:
        
        data[run]={}

        query = "files where core.runs[any]=%d and core.run_type=hd-protodune and core.file_type=detector"%(run)
        
        try:
            result = mc_client.query(query,summary="count")
        except:
            print("query failed")
            continue
        if result["count"]<1:
            continue
        query = "files where core.runs[any]=%d and core.run_type=hd-protodune and core.file_type=detector limit 1"%(run)
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
            data[run][data_stream] = {}

            for data_tier in ["raw","trigprim","full-reconstructed","root-tuple-virtual"]:
        
                query = "files where core.runs[any]=%d and core.run_type=hd-protodune and core.file_type=detector and core.data_tier=%s and core.data_stream=%s "%(run,data_tier,data_stream)

                if version is not None and data_tier not in ["raw","trigprim"]:
                    query += "and core.application.version=%s"%(version)
                
                #print (query)
                try:
                    result = mc_client.query(query,summary="count")
                except:
                    print("query failed")
                    continue
                #print (run,data_tier,result)
                if result["count"] == 0: continue
                gb = int(result["total_size"]/1000./1000.)/1000.
                result["total_size_gb"]=float(gb)
                result.pop("total_size")
                result["size_per_file_gb"] = int(gb/float(result["count"])*1000.*1000.)/1000./1000.
                if result["size_per_file_gb"] < 0.001:
                    print ("\n WARNING VERY SMALL FILES:",run,data_stream,data_tier,result["size_per_file_gb"]*1000,"MB\n" )
                data[run][data_stream][data_tier]=result

                # look at some details
                if data_tier in ["raw","trigprim"]:
                    query = "files where core.runs[any]=%d and core.run_type=hd-protodune and core.file_type=detector and core.data_tier=%s and core.data_stream=%s limit 1"%(run,data_tier,data_stream)
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
                    if data_tier in ["raw","trigprim"]:
                        data[run][data_stream][data_tier]["timestamp"] = unix_to_timestamp(result["metadata"]["core.start_time"])
                        print ("set timestamp",run,data_stream,data_tier)
                else:
                    if version is not None:
                        data[run][data_stream][data_tier]["check"] = 0
                        data[run][data_stream][data_tier]["version"] = version
                    diff = (data[run][data_stream][data_tier]["count"] - data[run][data_stream]["raw"]["count"])
                    if diff > 0 :
                        print( "WARNING more",data_tier,"(",data[run][data_stream][data_tier]["count"],")than raw (",data[run][data_stream]["raw"]["count"],") in run ",run,data_stream)
                        
                    if diff < 0 :
                        print( "WARNING less",data_tier,"(",data[run][data_stream][data_tier]["count"],")than raw (",data[run][data_stream]["raw"]["count"],") in run ",run,data_stream)
                        
                    data[run][data_stream][data_tier]["check"] = diff


        print(run, data[run])
    final = json.dumps(data,indent=4)   
    fname = "audits/audit-%s-%d-%d.json"%(version,runmin,runmax)
    f = open(fname,'w')
    f.write(final)
    f.close()

    summary = []
    fieldnames = ["run","data_stream","timestamp","version","check"]
    for run in data:
        record = {}
        record["run"]=run
        thestream = None
        for stream in data[run]:
            #print (run, stream, data[run][stream])
            if "raw" in data[run][stream].keys() or "trigprim" in data[run][stream].keys():
                thestream = stream
                record["data_stream"]=thestream
                #print (run, thestream, data[run][thestream])
                for tier in data[run][thestream]:
                     
                    #print (run, thestream, tier, data[run][thestream][tier])
                    for field in data[run][thestream][tier]:
                        if field == "timestamp":
                            record["timestamp"] = data[run][thestream][tier][field]
                            continue
                        if field == "version":
                            record["version"] = data[run][thestream][tier][field]
                            continue
                        name = "%s:%s"%(tier,field)
                        value = data[run][thestream][tier][field]
                        record[name]=value
                        if name not in fieldnames:
                            fieldnames.append(name)
                        #print (name,value)
                
                summary.append(record)
                #print(run,record)
                    
    newfile = fname.replace("json","csv")
    with open(newfile, 'w', newline='') as csvfile:
        
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)

        writer.writeheader()
        for run in summary:
            writer.writerow(run)

