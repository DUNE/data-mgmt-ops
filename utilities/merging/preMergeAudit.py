''' look for problems in input dataset before merging '''
import os,sys,time,datetime
from metacat.webapi import MetaCatClient
import json
import argparse
from statistics import mean
from TypeChecker import TypeChecker
import CheckSum
from rucio.client.replicaclient import ReplicaClient
from rucio.client.didclient import DIDClient

mc_client = MetaCatClient(os.environ["METACAT_SERVER_URL"])
replica_client=ReplicaClient()

def checklist(usemeta=False,query=None,thelistfile=None,verbose=False,rucio_site=NotImplementedError):
    max = 1000
    duplicates = []
    fids = []
    missed = []
    if usemeta:
        print ("the query is",query)
        alist = list(mc_client.query(query=query))
    else:
        f = open(thelistfile,'r')
        alist = f.readlines()
        f.close()
    
    print ("# of files",len(alist))

    if len(alist)> max:
        print ("WARNING, truncated checks at first ",max,"files")
        alist = alist[0:max]

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
                        duplicates.append([thefid,jsonfilename])
                    else:
                        fids.append(thefid)
        else:
            print ("no parents to check in",jsonfilename)
       
        if rucio_site and usemeta:
            location = None
            try:
                rucioname  = {"scope":filename["namespace"],"name":filename["name"]}
                result = list(replica_client.list_replicas([rucioname]))
            except Exception as e:
                result = None
                print('--- Rucio list_replicas call fails: ' + str(e))
                location 
            for file in result:
                did = file["scope"]+":"+file["name"]
                pfns = file["pfns"]
                if verbose: print ("\n ",did)
                
                for rse in pfns:
                    if verbose: print ("\n RSE",rse)
                    if rucio_site in rse:                       
                        location = rse
                        break
        
            if location is None:
                if verbose: print ("giving up on this file",rse)
                missed.append(did)
                


    if verbose: print ("check for duplicate",duplicates)
    return fids, duplicates, missed


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Audit data before merge')
    
    parser.add_argument("--query",type=str, help="query to produce a list of files to merge")
    parser.add_argument("--listfile",type=str, help="file containing list of paths to files to check",default=None)
    parser.add_argument("--useMetaCat",default=False,action='store_true')
    parser.add_argument("--verbose",default=False,action='store_true')
    parser.add_argument("--rucio_site",default=None,help="make certain files are at this site, no check if not set",type=str)

     

    args = parser.parse_args()

    if args.query and not args.useMetaCat:
        print ("Query option requires --useMetaCat")
        sys.exit(1)

    fids,duplicates,missing = checklist(usemeta=args.useMetaCat,thelistfile=args.listfile,query=args.query,verbose=args.verbose,rucio_site=args.rucio_site)
    #testquery = "files where dune.output_status=confirmed and  dune.workflow['workflow_id'] in (2542)"
    #fids,duplicates = checklist(usemeta=True,thelistfile=None,query=testquery)
    if len(duplicates) > 0:
        print ("found duplicates",len(duplicates))
        k = open("duplicates.txt",'w')
        for x in duplicates:
            k.write(x)
        k.close()
    if len(missing) > 0:
        print (len(missing), "files are not at",args.rucio_site)
        if args.verbose: print (missing)