''' look for problems in input dataset before merging '''
import os,sys,time,datetime
from metacat.webapi import MetaCatClient
import json
import argparse
from statistics import mean
from TypeChecker import TypeChecker
import CheckSum

mc_client = MetaCatClient(os.environ["METACAT_SERVER_URL"])

def checklist(usemeta=False,query=None,thelistfile=None,verbose=False):
    duplicates = []
    fids = []
    if usemeta:
        alist = list(mc_client.query(query=query))
    else:
        f = open(thelistfile,'r')
        alist = f.readlines()
        f.close()
    
    print ("# of files",len(alist))

    for filename in alist:
    
        #print ("test filenane",filename)
        
        if usemeta:
            jsonfilename = filename["namespace"]+":"+filename["name"]
            #thefid = filename["fid"]
    
            themeta = mc_client.get_file(did=jsonfilename,with_metadata=True,with_provenance=True)
        else:
            jsonfilename = filename.strip()
            if "json" not in jsonfilename:
                jsonfilename=jsonfilename + ".json"
            g = open(jsonfilename,'r')
            themeta = json.load(g)
            #print ("newname",themeta["name"]+"\n")
            g.close()
        
        if "parents" in themeta:
            for parent in themeta["parents"]:
                if "fid" in parent:
                    thefid = parent["fid"]
                    if thefid in fids:
                        if verbose: print ("Found a duplicate in ",jsonfilename)
                        duplicates.append(thefid)
                    else:
                        fids.append(thefid)
        else:
            print ("no parents to check in",jsonfilename)
    print ("check for duplicate",duplicates)
    return fids, duplicates


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Audit data before merge')
    
    parser.add_argument("--query",type=str, help="file containing a list of files to merge, they must have json in the same director")
    parser.add_argument("--listfile",type=str, help="file containing list of paths to files to check",default=None)
    parser.add_argument("--useMetaCat",default=False,action='store_true')
    parser.add_argument("--verbose",default=False,action='store_true')

    args = parser.parse_args()

    fids,duplicates = checklist(usemeta=args.useMetaCat,thelistfile=args.listfile,query=args.query,verbose=args.verbose)
    #testquery = "files where dune.output_status=confirmed and  dune.workflow['workflow_id'] in (2542)"
    #fids,duplicates = checklist(usemeta=True,thelistfile=None,query=testquery)
    if len(duplicates) > 0:
        print ("found duplicates",len(duplicates))
        k = open("duplicates.txt")
        for x in duplicates:
            k.write(x)
        k.close()