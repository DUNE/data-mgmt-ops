"""Check metadata against a template"""
import os,sys
 

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
    fid = filemd["fid"]
    did = filemd["namespace"]+":"+filemd["name"]
    optional = ["core.events","dune.daq_test"]
    valid = True
    for x, xtype in basetypes.items():
        if verbose: print (x)
        if x in optional: continue
        if x not in filemd.keys():
            error = x+" is missing from "+ fid
            print (error)
            errfile.write(error+"\n")
            valid *= False
                
        if xtype != type(filemd[x]) and x != "metadata":
            error = "%s has wrong type in %s"%(x,fid)
            print (error)
            errfile.write(error+"\n")
            valid *= False

    # now do the metadata
    md = filemd["metadata"]
    for x, xtype in basetypes["metadata"].items():
        if verbose: print (x)
        if x in optional: continue
        if x not in md.keys():
            error = x+ " is missing from "+ fid
            print (error)
            errfile.write(error)
            valid *= False
            continue
        if xtype != type(md[x]):
            error =  "%s has wrong type in %s"%(x,fid)
            print (error)
            errfile.write(error+"\n")
            valid *= False
    if not valid:
        print (did, " fails basic metadata tests")
        
    return valid
