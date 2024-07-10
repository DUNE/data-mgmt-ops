"""Check metadata against a template"""
import os,json
from argparse import ArgumentParser as ap
 

def TypeChecker(args, filemd, errfile="Types.err"):
    " check for type and missing required fields in metadata"
    verbose = args.verbose
    DEBUG = args.debug 

    # list defaults for metadata fields
    basetypes = {
        "name": str,
        "namespace": str,
        "checksums": dict,
        "size":int,
        "metadata":{
            "core.application.family": str,
            "core.application.name": str,
            "core.application.version": str,
            "core.data_stream":str,
            "core.data_tier": str,
            "core.end_time": float,
            "core.event_count": int,
            "core.events": list,
            "core.file_content_status": str,
            "core.file_format": str,
            "core.file_type": str,
            "core.first_event_number": int,
            "core.last_event_number": int,
            "core.run_type": str,
            "core.runs": list,
            "core.runs_subruns": list,
            "core.start_time": float,
            "dune.daq_test": str,
            "dune.config_file": str,
            "dune_mc.gen_fcl_filename": str,
            "dune_mc.geometry_version":str,
            "retention.status": str,
            "retention.class": str
        }
    }

    if args.no_checksum: basetypes.pop('checksums')
    if args.no_size: basetypes.pop('size')

    # set default values for fields that are often missing but needed
    fixDefaults = {
        "core.file_content_status":"good",
        "retention.status":"active",
        "retention.class":"unknown"
    }
    
    # place to put optional fields: all is optional for all, otherwise you need to tell it data_tier

    optional = { "all":["core.events","dune.daq_test"],
                "root-tuple":["core.event_count","core.first_event_number","core.last_event_number"],
                "raw":["dune.config_file", "dune_mc.gen_fcl_filename","dune_mc.geometry_version","core.application.family","core.application.name","core.application.version"],
                "trigprim":["dune.config_file", "dune_mc.gen_fcl_filename","dune_mc.geometry_version","core.application.family","core.application.name","core.application.version"],
                "root-tuple-virtual":["core.event_count","core.first_event_number","core.last_event_number"]}
    
    
    
   
    did = filemd["namespace"]+":"+filemd["name"]

    # do this as file may not have an fid yet, but fid makes shorter error messages. 
    if "fid" in filemd:
        fid = filemd["fid"]
    else:
        fid = did

    # start out with valid and no fixes needed    
    valid = True
    fixes = {}

    # loop over default md keys

    for x, xtype in basetypes.items():
        if verbose: print (x,xtype)
        if x in optional["all"]: continue
        # check required
        if x not in filemd.keys():
            error = x+" is missing from "+ fid + "\n"
            print (error)
            errfile.write(error)
            valid *= False
            print (filemd.keys())
            
                
        # check type
        if xtype != type(filemd[x]) and x != "metadata":
            if xtype == float and type(filemd[x]) == int: continue
            error = "%s has wrong type in %s \n"%(x,fid)
            print (error)
            errfile.write(error)
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
            errfile.write(error)
            valid *= False
            if x in fixDefaults:
                fixes[x]=fixDefaults[x]
            continue
        # check for type
        if xtype != type(md[x]):
            if xtype == float and type(md[x]) == int: continue
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

    parser = ap()
    parser.add_argument('--json', '-j', type=str, required=True,
                        help='Input json file to be check')
    parser.add_argument('--no-checksum', action='store_true',
                        help='Skip the checksum check')
    parser.add_argument('--no-size', action='store_true',
                        help='Skip the size check')
    parser.add_argument('--verbose', '-v', action='store_true',
                        help='Run verbosely')
    parser.add_argument('--debug', '-d', action='store_true',
                        help='Run in debug mode')
    args = parser.parse_args()

    jsonname = args.json
    jsonfile = open(jsonname,'r')
    filemd = json.load(jsonfile)
    errfile = open(jsonname+".err",'w')
    status,fixes = TypeChecker(args, filemd=filemd, errfile=errfile)
    errfile.close()
