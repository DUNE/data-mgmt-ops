''' am I a clone'''

import sys,os
from metacat.webapi import MetaCatClient
mc_client = MetaCatClient(os.environ["METACAT_SERVER_URL"])

verbose = False

def dupfinder(filemd=None):
    ' loop over parents, look for children and look for duplicates'
    thedid = "%s:%s"%(filemd["namespace"],filemd["name"])
    md = filemd["metadata"]
    tag = "%s_%s_%s_%s_%s_%s_%s_%s_%s_%s"%(filemd["namespace"],md["core.application.version"],md["core.application.name"],md["core.data_tier"],md["core.data_stream"],md["dune.campaign"],md["core.file_format"],md["core.run_type"],md["core.file_type"],md["dune.config_file"])
    
    if verbose:
        print ("---------------------------\n")
        print ("thefile",thedid)
        print ("tag",tag)
    if "parents" in filemd and len(filemd["parents"])> 0:
        # has some parentage, look at it. 
        parents = filemd["parents"]
        for p in parents:
            parentmd = mc_client.get_file(fid=p["fid"],with_metadata=True,with_provenance=True)
            if verbose:
                print ("the parent, %s:%s"%(parentmd["namespace"],parentmd["name"]))
            children = parentmd["children"]
            if len(children) == 0:
                message = "%s, ERROR no children\n"%(thedid)
                print (message)
            if verbose:
                print ("had %d children"%len(children))
            if len(children) == 1:
                continue
            count = 0
            for child in children:
                #if verbose: print ("child",child)
                childmd = mc_client.get_file(fid=child["fid"],with_metadata=True,with_provenance=True)
                cm = childmd["metadata"]
                childdid = "%s:%s"%(childmd["namespace"],childmd["name"])
                if childdid == thedid:
                    continue
                #print ("child", jsondump(childmd))
                ctag = "BAD"
                try:
                    ctag = "%s_%s_%s_%s_%s_%s_%s_%s_%s_%s"%(childmd["namespace"],cm["core.application.version"],cm["core.application.name"],cm["core.data_tier"],cm["core.data_stream"],cm["dune.campaign"],cm["core.file_format"],cm["core.run_type"],cm["core.file_type"],cm["dune.config_file"])
                    if verbose: print("ctag",ctag)
                except:
                    error = "%s, ERROR ctag couldn't be made %s\n"%(thedid,childdid)
                    
                    continue
            
                #print (childdid)
                if ctag == tag:
                    count += 1
                    
                    if count > 0:
                        message = "ERROR duplicate file %d\n,%s\n %s\n %s\n %s\n"%(count, thedid, childdid,tag,ctag)
                        print (message)


                

def amIaClone(fid=None,name=None,namespace=None,did=None):
    message = " need to specify either fid or name/namespace"
    if fid == None:
        if did == None:
            if name == None or namespace== None:
                print (message)
                sys.exit(1)
            else:
                did = "%s:%s"%(namespace,name)
                fid = None
        else:
            fid = None
    print (fid,did)
    if fid is not None:
        md = mc_client.get_file(fid=fid,with_metadata=True,with_provenance=True)
    else:
        md = mc_client.get_file(did=did,with_metadata=True,with_provenance=True)
    return dupfinder(md)
              
if __name__ == '__main__':   
    did = sys.argv[1]
    print (amIaClone(did=did))

    
