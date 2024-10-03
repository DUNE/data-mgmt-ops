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

import argparse

if __name__ == '__main__':

    if len(sys.argv) < 3:
        print ("arguments are --workflow or --run, --min, --max, optional --version")
        sys.exit(1)

    fieldnames = ["run", "data_stream", "timestamp", "version", "check", 
                  "raw:count", "raw:total_size_gb", "raw:size_per_file_gb", 
                  "trigprim:count", "trigprim:total_size_gb", "trigprim:size_per_file_gb", 
                  "full-reconstructed:count", "full-reconstructed:total_size_gb", "full-reconstructed:size_per_file_gb", "full-reconstructed:check",
                  "root-tuple-virtual:count", "root-tuple-virtual:total_size_gb", "root-tuple-virtual:size_per_file_gb", "root-tuple-virtual:check"]

    parser = argparse.ArgumentParser(description='check by run or workflow')

    parser.add_argument("--workflow",help='key is workflow',default=False,action='store_true')
    parser.add_argument("--run",help='key is run',default=False,action='store_true')
    parser.add_argument('--debug',help='make very verbose',default=False,action='store_true')
    parser.add_argument('--min',help='minimum key',type=int,default=None)
    parser.add_argument('--max',help='maximum key',type=int,default=None)
    parser.add_argument('--version',help='code version',type=str,default=None)

    now = datetime.datetime.now().timestamp()
    timestamp = unix_to_timestamp(now)
    
    args = parser.parse_args()

    if args.workflow is None and args.run is None:
        print ("need to define either --workflow or --run")
        sys.exit(1)

    if args.min is None:
        print ("need to specifiy min")
    
    if args.max is None:
        args.max = args.min


    keymin = args.min
    keymax = args.max

    audit_type = "run"
     
    if args.workflow:
        audit_type = "workflow"
        
    version = args.version 

    if version is None:
        version = "ALL"

    mc_client = MetaCatClient(os.getenv("METACAT_SERVER_URL"))
    
    keys = range(keymin,keymax+1)
    data = {}
    if not os.path.exists("./audits"):
        os.mkdir("audits")
    fname = "audits/audit-%s-%s-%d-%d-%s.json"%(audit_type,version,keymin,keymax,timestamp[0:8])

    logname = fname.replace(".json",".log")
    logfile = open(logname,'w')


  
    
    mergecommandfilename = "submitMerge_%d_%d_%s.sub"%(keymin,keymax,version)
    mergesubfile = open(mergecommandfilename,'w')
    for key in keys:
        
        data[key]={}

        snippet = "core.runs[any]=%d"%key
        if args.workflow:
            snippet = "dune.workflow['workflow_id'] in (%d)" %key
        query = "files where "+snippet+" and core.run_type=hd-protodune and core.file_type=detector " 
        
        try:
            result = mc_client.query(query,summary="count")
        except:
            print("query failed")
            continue
        if result["count"]<1:
            continue
        query = "files where "+snippet+" and core.run_type=hd-protodune and core.file_type=detector limit 1"
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
            data[key][data_stream] = {}

            for data_tier in ["raw","trigprim","full-reconstructed","root-tuple-virtual"]:
        
                query = "files where "+snippet+" and core.run_type=hd-protodune and core.file_type=detector and core.data_tier=%s and core.data_stream=%s "%(data_tier,data_stream)

                if version != "ALL" and data_tier not in ["raw","trigprim"]:
                    query += "and core.application.version=%s"%(version)
                
                if data_tier not in ["raw","trigprim"]:
                    query += " and dune.output_status=confirmed"
                
                #print (query)
                try:
                    result = mc_client.query(query,summary="count")
                except:
                    print("query failed",query)
                    continue
                #print (run,data_tier,result)
                if result["count"] == 0: 
                    if data_tier == "full-reconstructed" and args.run:
                        msg = "run %d not reconstructed yet with version %s"%(key,version)
                        print (msg)
                        logfile.write(msg+"\n")
                    continue
                gb = int(result["total_size"]/1000./1000.)/1000.
                result["total_size_gb"]=float(gb)
                result.pop("total_size")
                result["size_per_file_gb"] = int(gb/float(result["count"])*1000.*1000.)/1000./1000.
                if result["size_per_file_gb"] < 0.001:
                    msg = "WARNING VERY SMALL FILES: %d %s %s %f MB"%(key,data_stream,data_tier,result["size_per_file_gb"]*1000)
                    print (msg)
                    logfile.write(msg+"\n")
                data[key][data_stream][data_tier]=result

                # look at some details
                if (audit_type == "run" and (data_tier in ["raw","trigprim"]) )\
                    or (audit_type == "workflow" and data_tier == "full-reconstructed") :
                    query = "files where "+snippet+" and core.run_type=hd-protodune and core.file_type=detector and core.data_tier=%s and core.data_stream=%s limit 1"%(data_tier,data_stream)
                    try:
                        result = list(mc_client.query(query))
                    except:
                        print("query failed")
                        continue
                    fid = result[0]["fid"]

                    try:
                        md = mc_client.get_file(fid=fid,with_metadata=True)
                    except:
                        print("query failed")
                        continue
                    if "metadata" not in md:
                        continue
                    if data_tier in ["raw","trigprim","full-reconstructed"]:
                        data[key][data_stream][data_tier]["timestamp"] = unix_to_timestamp(md["metadata"]["core.start_time"])
                        #print ("set timestamp",key,data_stream,data_tier)
                        if "core.application.version" in md["metadata"]:
                            data[key][data_stream][data_tier]["version"] = md["metadata"]["core.application.version"]
                        else:
                            data[key][data_stream][data_tier]["version"] = "unknown"
                else:

                    if version != "ALL":
                        data[key][data_stream][data_tier]["check"] = 0
                        data[key][data_stream][data_tier]["version"] = version
        
                    reference = 0
                    if audit_type == "workflow":
                        #print ("not seeing raw data here",key,data_stream,data[key][data_stream].keys())
                        reference = data[key][data_stream]["full-reconstructed"]["count"]
                    else:
                        if "raw" in data[key][data_stream].keys():
                            reference = data[key][data_stream]["raw"]["count"]
                        else:
                            reference = 0
                    diff = data[key][data_stream][data_tier]["count"] - reference
                    if reference > 0:
                        fraction = diff/reference
                    else:
                        fraction = 0
                    print ("fraction",fraction)
                    donotmerge = True
                    if diff == 0:
                        #print( "No Problem!!",data_tier,"(",data[key][data_stream][data_tier]["count"],") == raw (",data[key][data_stream]["raw"]["count"],") in ",audit_type,key,data_stream)
                        msg = "No Problem!! %s (%d) == (%d) in %s %d %s %s"%(
                        data_tier,data[key][data_stream][data_tier]["count"],reference,audit_type,key,data_stream,version)
                        print (msg)
                        logfile.write(msg+"\n")
                        donotmerge *=0

                    if (fraction < 0 and fraction > -0.01):
                        #print( "No Problem!!",data_tier,"(",data[key][data_stream][data_tier]["count"],") == raw (",data[key][data_stream]["raw"]["count"],") in ",audit_type,key,data_stream)
                        msg = "Almost OK %s (%d) ~ (%d) in %s %d %s %s"%(
                        data_tier,data[key][data_stream][data_tier]["count"],reference,audit_type,key,data_stream,version)
                        print (msg)
                        logfile.write(msg+"\n")
                        donotmerge *=0

                    if diff > 0 :
                        #print( "WARNING more",data_tier,"(",data[key][data_stream][data_tier]["count"],")than raw (",data[key][data_stream]["raw"]["count"],") in ",audit_type, key,data_stream)
                        msg = "WARNING more %s (%d) than reference (%d) in %s %d %s %s"%(
                        data_tier,data[key][data_stream][data_tier]["count"],reference,audit_type,key,data_stream,version)
                        print (msg)
                        logfile.write(msg+"\n")
                        donotmerge *=1
                        
                    if (fraction < 0 and fraction <= -0.01):
                        #print( "WARNING less",data_tier,"(",data[key][data_stream][data_tier]["count"],")than raw (",data[key][data_stream]["raw"]["count"],") in ",audit_type, key,data_stream)

                        msg = "WARNING less %s (%d) than reference (%d) in %s %d %s %s"%(
                        data_tier,data[key][data_stream][data_tier]["count"],reference,audit_type,key,data_stream,version)
                        print (msg)
                        logfile.write(msg+"\n")
                        donotmerge *=1
                    
                        
                    data[key][data_stream][data_tier]["check"] = diff
                    if "tuple" in data_tier and args.run:
                        if donotmerge:
                            mergesubfile.write("#"+msg+"\n")
                        mergecommand = "python submitMerge.py --run %s --version %s --skip=0 --chunk=100 --nfiles=100000\
 --file_type=detector --detector=hd-protodune --data_tier=root-tuple-virtual\
      --merge_stage=final --usetar=$TARFILE # %s %s \n"%(key,args.version,data_stream,data[key][data_stream][data_tier]["count"])
                        mergesubfile.write(mergecommand)
                    
   



        #print(run, data[key])
    final = json.dumps(data,indent=4)   

    
    f = open(fname,'w')
    f.write(final)
    f.close()

    summary = []
    #fieldnames = [audit_type,"data_stream","timestamp","version","check"]
    for key in data:
        #print (key)
        record = {}
        record[audit_type]=key
        thestream = None
        for stream in data[key]:
            #print (key, stream, data[key][stream], audit_type)
            if (audit_type == "run" and ("raw" in data[key][stream].keys() or "trigprim" in data[key][stream].keys()))\
                  or (audit_type == "workflow" and ("full-reconstructed" in data[key][stream].keys() )):
                thestream = stream
                record["data_stream"]=thestream
                #print (key, thestream, data[key][thestream])
                for tier in data[key][thestream]:
                     
                    #print (run, thestream, tier, data[key][thestream][tier])
                    for field in data[key][thestream][tier]:
                        if field == "timestamp":
                            record["timestamp"] = data[key][thestream][tier][field]
                            continue
                        if field == "version":
                            record["version"] = data[key][thestream][tier][field]
                            continue
                        name = "%s:%s"%(tier,field)
                        value = data[key][thestream][tier][field]
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

