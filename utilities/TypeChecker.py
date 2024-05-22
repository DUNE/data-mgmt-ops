"""Check metadata against a template"""
import os,sys,json
 

def TypeChecker(filemd=None, errfile="Types.err", verbose=False):
    " check for type and missing required fields in metadata"
    STRING = type("")
    FLOAT = type(1.0)
    INT = type(1)
    LIST = type([])
    DICT = type({})
    basetypes = {
        "name": STRING,
        "namespace": STRING,
        "checksums": DICT,
        "size":INT,
        "metadata":{
            "core.application.family": STRING,
            "core.application.name": STRING,
            "core.application.version": STRING,
            "core.data_stream":STRING,
            "core.data_tier": STRING,
            "core.end_time": FLOAT,
            "core.event_count": INT,
            "core.events": LIST,
            "core.file_content_status": STRING,
            "core.file_format": STRING,
            "core.file_type": STRING,
            "core.first_event_number": INT,
            "core.last_event_number": INT,
            "core.run_type": STRING,
            "core.runs": LIST,
            "core.runs_subruns": LIST,
            "core.start_time": FLOAT,
            "dune.daq_test": STRING,
            "retention.status": STRING,
            "retention.class": STRING
        }
    }
    fixDefaults = {
        "core.file_content_status":"good",
        "retention.status":"active",
        "retention.class":"unknown"
    }
    
    did = filemd["namespace"]+":"+filemd["name"]
    # do this as file may not have an fid yet
    if "fid" in filemd:
        fid = filemd["fid"]
    else:
        fid = did
    optional = { "all":["core.events","dune.daq_test"],"root-tuple":["core.first_event_number","core.last_event_number","core.data_stream"]}
    valid = True

    fixes = {}

    for x, xtype in basetypes.items():
        if verbose: print (x,xtype)
        if x in optional["all"]: continue
        if x not in filemd.keys():
            error = x+" is missing from "+ fid + "\n"
            print (error)
            errfile.write(error)
            valid *= False
                
        if xtype != type(filemd[x]) and x != "metadata":
            error = "%s has wrong type in %s \n"%(x,fid)
            print (error)
            errfile.write(error)
            valid *= False

    # now do the metadata
    md = filemd["metadata"]
    for x, xtype in basetypes["metadata"].items():
        if verbose: print (x,xtype)
        if x in optional["all"]: continue # skip optional items
        
        if x not in md.keys():
            if "core.data_tier" in md and x in optional[md["core.data_tier"]]:  # skip optional items by data_tier
                print ("skipping optional field for data_tier",md["core.data_tier"],x)
                continue
            error = x+ " is missing from "+ fid + "\n"
            print (error)
            errfile.write(error)
            valid *= False
            if x in fixDefaults:
                fixes[x]=fixDefaults[x]
            continue
        if xtype != type(md[x]):
            if xtype == FLOAT and type(md[x]) == INT: continue
            error =  "%s has wrong type in %s\n "%(x,fid)
            print (error)
            errfile.write(error+"\n")
            valid *= False
    if not valid:
        print (did, " fails basic metadata tests")
        if len(fixes) !=0:
            print ("you could fix this by applying this fix")
            print (json.dumps(fixes,indent=4))
        
    return valid, fixes


if __name__ == '__main__':

    if len(sys.argv) < 2:
        print ("please provide a json file to check")
        sys.exit(1)
    jsonname = sys.argv[1]
    jsonfile = open(jsonname,'r')
    filemd = json.load(jsonfile)
    errfile = open(jsonname+".err",'w')
    status,fixes = TypeChecker(filemd=filemd,errfile=errfile,verbose=False)
    errfile.close()