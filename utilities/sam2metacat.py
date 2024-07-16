import os, sys
import json
import TimeUtil
import TypeChecker

from metacat.webapi import MetaCatClient
import samweb_client

newones = {"retired":False, "retired_by":None, "retired_timestamp":None}
newonesdot = {"retention.status":"active","retention.class":"other"}

complicated = ["create_date","checksum","application","runs","update_date","update_user","start_time","end_time","children","parents","file_id","DUNE_data.detector_config"]

times = ["create_date","start_time","end_time"]

easy = {
"file_name": "name",
# "create_date": "created_timestamp", # needs conversion
"user": "creator",
"file_size": "size",
# "checksum": "checksums", # needs conversion 
"content_status": "core.file_content_status",
"file_type": "core.file_type",
"file_format": "core.file_format",
"group": "core.group",
"data_tier": "core.data_tier",
#   "application": { # needs conversion
#    "family": "art",
#    "name": "reco2",
#    "version": "v09_81_00d02"
#   },
"event_count": "core.event_count",
"first_event": "core.first_event_number",
"last_event": "core.last_event_number",
#"start_time": "core.start_time",
#"end_time": "core.end_time",
"data_stream": "core.data_stream",
"art.file_format_era": "art.file_format_era",
"art.file_format_version": "art.file_format_version",
"art.first_event": "art.first_event",
"art.last_event": "art.last_event",
"art.process_name": "art.process_name",
"DUNE.campaign": "dune.campaign",
"DUNE.fcl_name": "dune.config_file",
"DUNE.requestid": "dune.requestid",
"DUNE_MC.detector_type": "dune_mc.detector_type",
"DUNE_MC.gen_fcl_filename": "dune_mc.gen_fcl_filename",
"process_id":"core.process_id",
"update_user":"updated_by",
"update_date":"updated_timestamp",
"DUNE_data.detector_config.object":"dune_data.detector_config.object"

#   "runs": [ #needs conversion 
#    [
#     1109,
#     1,
#     "fardet-hd"
#    ]
#   ],
#   "parents": [
#    {
#     "file_name": "nu_dune10kt_1x2x6_1109_910_20230827T004050Z_gen_g4_detsim_hitreco.root",
#     "file_id": 80257774
#    }
#   ]
}

DEBUG = False

def convert(md,namespace=None):
    meta = {}
    meta["metadata"] = {}
    meta["namespace"] = namespace
    

# patch in new fields 
    for k,v in newones.items():
        if k not in md:
            if DEBUG: print ("add in missing",k,v)
            meta[k] = v
    for k,v in newonesdot.items():
        if k not in md:
            if DEBUG: print ("add in missing",k,v)
            meta["metadata"][k] = v

    for k,v in md.items(): 
        if DEBUG: print ("\n try",k,v)      
         
        if k in complicated:
            if DEBUG: print("it's complicated")
            if k == "application":
                for z,vz in v.items():
                    newk = "core.application.%s"%z
                    meta["metadata"][newk] = vz
                    if DEBUG:
                        print ("application",newk,vz)
                continue
            if k == "checksum":
                meta["checksums"]={}
                for z in v:
                    parts = z.split(":")                   
                    meta["checksums"][parts[0]]=parts[1]
                if DEBUG: 
                    print ("checksums",k,meta["checksums"])
                continue
            if k == "runs":
                runlist = []
                subrunlist = []
                detector = None
                for z in v:
                    runlist.append(z[0])
                    subrunlist.append(z[0]*100000+z[1])
                    detector = z[2]
                meta["metadata"]["core.runs"] = runlist
                meta["metadata"]["core.runs_subruns"] = subrunlist
                meta["metadata"]["core.run_type"] = detector
                if DEBUG:
                    print ("runs",meta["metadata"]["core.runs"])
                    print ("subruns",meta["metadata"]["core.runs_subruns"])
                    print ("runtype",meta["metadata"]["core.run_type"])
                continue
            if k == "create_date":
                meta["created_timestamp"] = TimeUtil.sam_to_unix(v)
                if DEBUG: print("timestamp",k,meta["created_timestamp"]  )
                continue
            if k in times:
                if "." not in k:
                    newkey = 'core.'+k
                    newv = TimeUtil.sam_to_unix(v)
                    meta["metadata"][newkey]=newv
                else:
                    meta["metadata"][k] = TimeUtil.sam_to_unix(v)
                continue

            if "update" in k:
                newkey = easy[k]
                if DEBUG: print ("update",v)
                if "timestamp" in newkey:
                    
                    meta[newkey]=TimeUtil.sam_to_unix(v)
                else:
                    meta[newkey]=v

                if DEBUG: print("update",newkey,v,meta[newkey])
                continue

            if k == "children" or k == "parents":
                meta[k] = []
                for z in v:
                    meta[k].append({"fid":"%s"%(z["file_id"])})
                if DEBUG:
                    print ("Parentage",k, meta[k])
                continue

            if k == "file_id":
                meta["fid"] = "%d"%v
                if DEBUG:
                    print ("fid",k,meta["fid"] )
                continue
            
            if k == "DUNE_data.detector_config":
                meta["metadata"][k.lower()] = v
                continue

            print ("got to end of complicated without finding a solution",k)

        if k in easy:
            if "." in easy[k]:
                newkey = easy[k].lower()
                meta["metadata"][newkey] = v
            else:
                newkey = easy[k].lower()
                meta[easy[k]] = v
            if DEBUG:
                print ("easy",k,v,newkey)
            if "event" in easy[k]:
                meta["metadata"][easy[k]] = int(v)
            continue

        else:
            if DEBUG: print ("got to the bottom")
            if "." in k:
                newkey = k.lower()
                meta["metadata"][newkey] = v
            else:
                newkey = "core."+k.lower()
                meta["metadata"][newkey] = v
            if DEBUG:print ("passthrough:",newkey,meta["metadata"][newkey])
            continue
    return meta

def compare(md1,md2):
    ''' compare 2 metadata files field by field '''
    # fields we probably don't care about

    ignore = ["DUNE_data.detector_config.object","core.end_time_utc_text","core.start_time_utc_text","art.first_event","art.last_event","core.application"]

    recent = ["core.file_content_status",
    "retention.status",
    "retention.class"] # things that may not be in old metadata
    diffs = 0
    print ("\n ----- compare -------\n")


    for field,value in md1.items():
        f = field
        v = value
        if field == "metadata":
            for f,v in md1["metadata"].items():
                if f in ignore: continue
                if f in md2["metadata"]:
                    if "timestamp" in f:
                        v = int(v)
                        md2["metadata"][f] = int(md2["metadata"][f])
                    if v != md2["metadata"][f]:
                        print ("different ",f,v,md2["metadata"][f])
                else:
                    if f in recent: continue
                    print ("novel metadata",f,v)
                    diff += 1
            continue
                 
        if f in md2:
            if v != md2[f]: print ("different",f,v,md2[f])
        else:
            print ("novel",f,v)
    for field,value in md2.items():
        f = field
        v = value
        if field == "metadata":
            for f,v in md2["metadata"].items():
                if f in ignore: continue
                if f.lower() in md1["metadata"]:
                    if v != md1["metadata"][f]: print ("different",f,v,md1["metadata"][f])
                else:
                    print ("missing",f,v)
                    diff += 1
            continue
                 
        if f in md1:
            if v != md1[f]: print ("different ",f,v,md1[f])
        else:
            print ("missing",f,v)
            diff += 1

    return diff
   

def check(did=None):
    errors = 0
    mc_client = MetaCatClient(os.environ["METACAT_SERVER_URL"])
    samweb = samweb_client.SAMWebClient(experiment='dune')
    comparisonfile = did
    md2 = mc_client.get_file(did=comparisonfile,with_metadata=True,with_provenance=True)
    samfile =  md2["name"]
    try:
        md1 = samweb.getMetadata(samfile)
    except:
        print ("no corresponding file in sam")
        return None
    #print ("check the comparison file")
    #status2,fixes2 = TypeChecker.TypeChecker(md2)
    #print ("comparison file status",status2,fixes2)
    #md2 = md2|fixes2
    meta  = convert(md1,md2["namespace"])
    print ("check the result")
    status1,fixes1 = TypeChecker.TypeChecker(meta)
    print ("converted file status",status1,fixes1)
    meta = meta | fixes1
    print ("do the comparison field by field")
    diffs = compare(meta,md2)
    if diffs == 0:
        print ("no problem")
        return diffs
    sfile = open(samfile+"_sam.json",'w')
    json.dump(md1,sfile,indent=4)
    sfile.close()
    ofile = open(samfile+"_convert.json",'w')
    json.dump(meta,ofile,indent=4)
    ofile.close()
    mfile = open(samfile+"_metacat.json",'w')
    json.dump(md2,mfile,indent=4)
    mfile.close()
    return diffs

if __name__ == '__main__':

    if len(sys.argv) < 2:
        print ("need to give me a did for a file in metacat")
    check(sys.argv[1])




