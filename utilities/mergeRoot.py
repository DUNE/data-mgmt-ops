import os,sys
from subprocess import call,run
from metacat.webapi import MetaCatClient
from mergeMetaCat import run_merge
from datetime import datetime, timezone
import argparse
import shutil
from rucio.client.replicaclient import ReplicaClient
from rucio.client.didclient import DIDClient
from rucio.common.exception import DataIdentifierNotFound, DataIdentifierAlreadyExists, FileAlreadyExists, DuplicateRule, RucioException


mc_client = MetaCatClient(os.environ["METACAT_SERVER_URL"])

#def doit():
#    run_merge(newfilename=fileName, newnamespace = args.nameSpace, datatier=args.dataTier, application=None, version=None, flist=None, do_sort=True, merge_type="metacat", user=os.getenv("USER"), debug=False)

def makeTimeStamp():
    'make a timestamp'
    t = datetime.now(timezone.utc).strftime("%Y%m%dT%H%M%S")
    return t

def makeFake(fake="fake.root",thelist=None,path=None):
    'make some fake files for testing which are copies of fake'
    locations=[]
    for x in thelist:
        name = x.split(":")[1]
        shutil.copy(fake, os.path.join(path,name))
        locations.append(os.path.join(path,name))
    return locations

def makeHash(alist):
    'make a hash from the filenames to avoid duplicate merges'
    astring = '_'.join(alist)
    h = hex(hash(astring))[2:]
    return h

def mergeData(newpath,input_files):
    'use hadd to merge the data, no limit on length of list'
    #if os.path.exists(newpath):
    #newpath = newpath.replace(".root","_"+makeTimeStamp()+"_"+makeHash(input_files)+".root")
    args = ["hadd", "-f", newpath] + input_files
    #print (args)
    retcode = call(args)
    if retcode != 0:
        print("MergeRoot: Error from hadd!")
        exit(retcode)
    return newpath

def cleanup(local):
    for file in local:
        print ("removing",file)
        os.remove(file)
    

if __name__ == "__main__":

    test=False
    debug=True
    fast=False # dangerous as merges data but not meta properly

    outsize = 4000000000

    parser = argparse.ArgumentParser(description='Merge Data')
    #parser.add_argument("--fileName", type=str, help="Name of merged file, will be padded with timestamp if already exists", default="merged.root")
    parser.add_argument("--workflow",type=int, help="workflow id to merge",default=None)
    parser.add_argument("--chunk",type=int, help="number of files/merge",default=20)
    parser.add_argument("--nfiles",type=int, help="number of files to merge total",default=1000)
    parser.add_argument("--skip",type=int, help="number of files to skip before doing nfiles",default=0)
    parser.add_argument("--run",type=int, help="run number", default=None)
    #parser.add_argument("--skip",type=int, help="skip on query",default=0)

    #parser.add_argument("--chunk",type=int,help="# of files to put in a single chunk",chunk=100)
    args = parser.parse_args()

    if args.workflow is None and args.run is None:
        print ("need to specify either workflow or run")
        sys.exit(1)

    # get a list of files from metacat

    replica_client=ReplicaClient()


    print ("starting up")
    for data_stream in ["cosmics","calibration","physics"]:
        todo = True
        chunk = min(args.chunk,args.nfiles)
        skip = args.skip
        count = 0
        print (data_stream,chunk,skip)
        while todo:
            if args.workflow is not None:
                query = "files where core.run_type=hd-protodune and core.file_type=detector and dune.workflow['workflow_id']=%d and core.data_tier=root-tuple and core.data_stream=%s ordered skip %d limit %d"%(args.workflow,data_stream,skip, chunk)
                jobtag = "workflow%d"%args.workflow
                
            else:
                query = "files where core.run_type=hd-protodune and core.file_type=detector and core.runs[any]=%d and core.data_tier=root-tuple and core.data_stream=%s ordered skip %d limit %d"%(args.run,data_stream,skip, chunk)
                jobtag = "run%d"%args.run

            print ("mergeRoot: metacat query = ", query)
            alist = list(mc_client.query(query=query))
            if len(alist)<= 0:
                print ("mergeRoot: DONE")
                todo = False
                break

            theinfo = mc_client.query(query=query,summary="count")
        
            if debug: print (theinfo)
            
            flist = []
            ruciolist = []
            local = []

            # make lists
            for file in alist:
                thedid = "%s:%s"%(file["namespace"],file["name"])
                flist.append(thedid)
                if debug: print ("new file",file)
                ruciolist.append({"scope":file["namespace"],"name":file["name"]})
                
            if debug: print (ruciolist)
        # now get a list of locations from rucio
        #     
            if test: # this just allows tests without using rucio
                locations =  makeFake(os.path.join(os.getenv("TMP"),"fake.root"),flist,os.getenv("TMP"))
            else:   
                
                locations = []  
                goodfiles = []
                # doing this because I cannot figure out syntax to feed a list of files to rucio
                try:
                    result = list(replica_client.list_replicas(ruciolist)) # goes away if you don't grab it???
                except Exception as e:
                    result = None
                    print('--- Rucio list_replicas call fails: ' + str(e))
                if debug: print ("rucio",list(result))

                missed = []

                badsites = ["qmul","surfsara"]
                for file in result:
                    did = file["scope"]+":"+file["name"]
                    pfns = file["pfns"]
                    if debug: print ("\n ",did)
                    location = None
                    
                    for rse in pfns:
                        if debug: print ("\n RSE",rse)
                        goodsite = True
                        for site in badsites:
                            if site in rse:
                                if debug: print ("this is a bad site",site)
                                goodsite = False
                                break
                        if goodsite:     
                            if debug: print ("this site is ok",rse,badsites)
                            location = rse
                            continue
                    if location is None:
                        print ("giving up on this file",rse)
                        missed.append(did)
                        continue
                    cp_args = ["xrdcp",location,"./cache/."]
                    try:
                        completed_process = run(cp_args, capture_output=True,text=True)   
                        if debug: print (completed_process)
                
                        
                    except Exception as e:
                        print ("error doing local copy",e)
                        continue
                    local.append(os.path.join("./cache",os.path.basename(location)))
                    goodfiles.append(did)
                    locations.append(location)
                    
                #     rucio_args = ["rucio","list-file-replicas", "--pfns","--protocols=root", file]      
                #     print ("rucio args",rucio_args)
                #     completed_process = run(rucio_args, capture_output=True,text=True)   
                #     thepath = completed_process.stdout.strip()
                #     print ("rucio output",thepath)
                #     # this is here so you can skip files from known bad sites. 
                #     if ("qmul" in thepath): 
                #         print ("SKIPPING QMUL")
                #         continue
                #     print (file,thepath)
                #     goodfiles.append(file)
                #     locations.append(thepath)

            if debug: print ("local",local)

            if debug: print (locations)

            # copy files to local area for merge

            if len(goodfiles) >= 1:
                
                print (goodfiles[0])
                firstmeta = mc_client.get_file(did=goodfiles[0],with_metadata=True)
                firstname = firstmeta["name"]
                pieces = firstname.split("_")
                pieces = pieces[0:2]+pieces[7:]
                keep = []
                
                for i in range(0,len(pieces)):
                    x = pieces[i]
                    #print (x[0:3],x[0:3])
                    if x[0:3] == "run": 
                        
                        continue
                    if x[0:4] == "2024": continue
                    if "datawriter" in x: 
                    
                        continue
                    if "dataflow" in x: continue
                    keep.append(x)
                

                    
                
                newname ='_'.join(keep)
                newname = newname.replace(".root","_merged_%s_%s_skip%d_lim%d_%s.root"%(data_stream,jobtag,skip,chunk,makeTimeStamp()))
                print ("newname",newname)
            else:
                print ("no good files left")
            skip += chunk
            count += chunk
            if count >= args.nfiles: 
                todo = False
            
            outputfile = newname
            newfile = mergeData(outputfile,local)


            
            print ("mergeRoot: output will go to ",newfile)

            #print (thelist)
            if debug: print (flist)
            retcode = run_merge(newfilename=newfile, newnamespace=os.getenv("USER"), 
                                datatier="root-tuple", flist=goodfiles, 
                                merge_type="metacat", do_sort=0, user='', debug=debug)
            print ("MergeRoot: retcode", retcode)

            if os.path.exists(newfile):
                print ("clean up inputs")
                cleanup(local)

        
