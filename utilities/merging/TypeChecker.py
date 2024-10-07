"""Check metadata against a template"""
import os,sys,json

from CheckConfiguration import known_fields
 

def TypeChecker(filemd=None, errfile=None, verbose=False):
    " check for type and missing required fields in metadata"
    DEBUG=False
    # define types
    STRING = type("")
    FLOAT = type(1.0)
    INT = type(1)
    LIST = type([])
    DICT = type({})

    # list defaults for metadata fields
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
            "dune.config_file": STRING,
            "dune_mc.gen_fcl_filename": STRING,
            "dune_mc.geometry_version":STRING,
            "retention.status": STRING,
            "retention.class": STRING
        }
    }

    # set default values for fields that are often missing but needed
    fixDefaults = {
        "core.file_content_status":"good",
        "retention.status":"active",
        "retention.class":"unknown"
    }
    
    # place to put optional fields: all is optional for all, otherwise you need to tell it data_tier

    optional = { 
        "all":["core.events","dune.daq_test"],
        "root-tuple":["core.event_count","core.first_event_number","core.last_event_number"],
        "raw":["dune.config_file", "dune_mc.gen_fcl_filename","dune_mc.geometry_version","core.application.family","core.application.name","core.application.version"],
        "binary-raw":["dune.config_file", "dune_mc.gen_fcl_filename","dune_mc.geometry_version","core.application.family","core.application.name","core.application.version"],
        "trigprim":["dune.config_file", "dune_mc.gen_fcl_filename","dune_mc.geometry_version","core.application.family","core.application.name","core.application.version"],
        "root-tuple-virtual":["core.event_count","core.first_event_number","core.last_event_number"]
        }

    valid = True
    fixes = {}
    if "name" in filemd:
        did = filemd["namespace"]+":"+filemd["name"]
    else:
        print ("ERROR: name not in metadata, continuing but this is invalid and I cannot fix it from metadata only")
        tempname = "UNKNOWN"
        did = "UNKNOWN:UNKNOWN"
        valid = False

    # do this as file may not have an fid yet, but fid makes shorter error messages. 
    if "fid" in filemd:
        fid = filemd["fid"]
    else:
        fid = did

    # start out with valid and no fixes needed    
    

    # loop over default md keys

    for x, xtype in basetypes.items():
        if verbose: print (x,xtype)
        if x in optional["all"]: continue
        # check required
        if x not in filemd.keys():
            error = x+" is missing from "+ fid + "\n"
            print (error)
            if errfile is not None: errfile.write(error)
            valid *= False
            print (filemd.keys())
            continue
            
                
        # check type
        if xtype != type(filemd[x]) and x != "metadata":
            if xtype == FLOAT and type(filemd[x]) == INT: continue
            error = "%s has wrong type in %s \n"%(x,fid)
            print (error)
            if errfile is not None: errfile.write(error)
            valid *= False

    # now do the metadata
    md = filemd["metadata"]
    for x, xtype in basetypes["metadata"].items():
        if verbose: print (x,xtype)
        if x in optional["all"]: continue # skip optional items
        if "core.run_type" in md and md["core.run_type"] != "mc" and "mc" in x: 
            if DEBUG: print ("skipping mc only",x)
            continue
         
        
        # check required keys
        if x not in md.keys():
            if "core.data_tier" in md and md["core.data_tier"] in optional and x in optional[md["core.data_tier"]]:  # skip optional items by data_tier
                 
                if DEBUG: print ("skipping optional missing field for data_tier",md["core.data_tier"],x)
                continue
            error = x+ " is missing from " + fid + "\n"
            print (error)
            if errfile is not None: errfile.write(error)
            valid *= False
            if x in fixDefaults:
                fixes[x]=fixDefaults[x]
            continue
        # check for type
        if xtype != type(md[x]):
            if xtype == FLOAT and type(md[x]) == INT: continue
            error =  "%s has wrong type in %s\n "%(x,fid)
            print (error)
            if errfile is not None: errfile.write(error+"\n")
            valid *= False
    for x,core in known_fields().items():
        if x not in md: 
            print ("required field",x,"not present")
            valid *=False      
        if md[x] not in core:
            print ("unknown required metadata field",x,"=",md[x])
            valid *= False
    for x,v in md.items():
        if x != x.lower() and x.lower() not in md.keys():
            valid *=False
            print ("OOPS upper case",x)
            fixes[x.lower()]=v
    if not valid:
        print (did, " fails basic metadata tests")
        if len(fixes) !=0:
            print ("you could fix this by applying this fix")
            print (json.dumps(fixes,indent=4))
    
    # look for upper case in keys

    
            
            
            

            
    return valid, fixes


if __name__ == '__main__':

    if len(sys.argv) < 2:
        print ("please provide a json file to check")
        sys.exit(1)
    jsonname = sys.argv[1]
    if not os.path.exists(jsonname):
        print ("input file does not exist",jsonname)
        sys.exit(1)
    jsonfile = open(jsonname,'r')
    filemd = json.load(jsonfile)
    errfile = open(jsonname+".err",'w')
    status,fixes = TypeChecker(filemd=filemd,errfile=errfile,verbose=False)
    errfile.close()