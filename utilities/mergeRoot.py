import os,sys
from subprocess import call,run
from metacat.webapi import MetaCatClient
from mergeMetaCat import run_merge
from datetime import datetime, timezone
import argparse
import shutil


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
    if os.path.exists(newpath):
        newpath = newpath.replace(".root","_"+makeTimeStamp()+"_"+makeHash(input_files)+".root")
    args = ["hadd", "-f", newpath] + input_files
    #print (args)
    retcode = call(args)
    if retcode != 0:
        print("MergeRoot: Error from hadd!")
        exit(retcode)
    return newpath
    

if __name__ == "__main__":

    test=False
    debug=False
    fast=False # dangerous as merges data but not meta properly

    outsize = 4000000000

    parser = argparse.ArgumentParser(description='Merge Data')
    parser.add_argument("--fileName", type=str, help="Name of merged file, will be padded with timestamp if already exists", default="merged.root")
    parser.add_argument("--workflow",type=int, help="workflow id to merge",required=True)
    parser.add_argument("--limit",type=int, help="limit on query",default=100)
    parser.add_argument("--skip",type=int, help="skip on query",default=0)

    #parser.add_argument("--chunk",type=int,help="# of files to put in a single chunk",chunk=100)
    args = parser.parse_args()

    # get a list of files from metacat

    query = "files where dune.workflow['workflow_id']=%d and core.data_tier=root-tuple ordered skip %d limit %d"%(args.workflow,args.skip, args.limit)

    print ("mergeRoot: metacat query = ", query)
    alist = list(mc_client.query(query=query))

    theinfo = mc_client.query(query=query,summary="count")
    # in future, want to use this to break into chunks
    chunks = int(theinfo["total_size"]/outsize)+1
    spans = int(len(alist)/chunks) + 1

    
    print (theinfo, "chunks = ", chunks,"spans=", spans)
    if debug: print (theinfo)
    if len(alist)< 1:
        print ("mergeRoot: no files match that query, quitting")
        sys.exit(1)
    flist = []
    for file in alist:
        thedid = "%s:%s"%(file["namespace"],file["name"])
        flist.append(thedid)
        print ("new file",file)
    
    print (flist)
# now get a list of locations from rucio
#     
    if test: # this just allows tests without using rucio
        locations =  makeFake(os.path.join(os.getenv("TMP"),"fake.root"),flist,os.getenv("TMP"))
    else:   
        locations = []  
        goodfiles = []
        # doing this because I cannot figure out syntax to feed a list of files to rucio
        for file in flist:
            rucio_args = ["rucio","list-file-replicas", "--pfns","--protocols=root", file]      
            completed_process = run(rucio_args, capture_output=True,text=True)   
            thepath = completed_process.stdout.strip()
            # this is here so you can skip files from known bad sites. 
            if ("qmul" in thepath): 
                print ("SKIPPING QMUL")
                continue
            goodfiles.append(file)
            locations.append(thepath)

    if debug: print (locations)
    tag = "%d_%d_%d"%(args.workflow,args.skip,args.limit)
    outputfile = args.fileName.replace(".root",tag+".root")

    
    chunk = 0
    pointer = 0
    
    newfile = mergeData(outputfile,locations)
    #print ("doing ",pointer,"through",pointer+spans-1)
    #chunk += 1
    #pointer += spans
    print ("mergeRoot: output will go to ",newfile)

    #print (thelist)
    if debug: print (flist)
    retcode = run_merge(newfilename=newfile, newnamespace=os.getenv("USER"), 
                        datatier="root-tuple", application="merge_root", version="v0", flist=goodfiles, 
                        merge_type="metacat", do_sort=0, user='', debug=debug)
    print ("MergeRoot: retcode", retcode)

        
