import os,sys
from subprocess import call,run
from metacat.webapi import MetaCatClient
from mergeMetaCat import run_merge
from datetime import datetime, timezone
from ROOT import TFile
import argparse
import shutil
import json
import tarfile
from rucio.client.replicaclient import ReplicaClient
from rucio.client.didclient import DIDClient
from rucio.common.exception import DataIdentifierNotFound, DataIdentifierAlreadyExists, FileAlreadyExists, DuplicateRule, RucioException


mc_client = MetaCatClient(os.environ["METACAT_SERVER_URL"])

def pnfs2xrootd(filename):
    return filename.replace("/pnfs/","root://fndca1.fnal.gov:1094//pnfs/fnal.gov/usr/")

def xrootd2pnfs(filename):
    tmp = filename.split("/usr/")
    return os.path.join("/pnfs/",tmp[1])

def checkFile(filepath):
    f = 0
    try:
        f = TFile.Open(filepath,"READONLY")
        return True
    except Exception as e:
        print ("could not open",filepath,e)
        return False



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

def mergeData(newpath,input_files,debug=False):
    'use hadd to merge the data, no limit on length of list'
    #if os.path.exists(newpath):
    #newpath = newpath.replace(".root","_"+makeTimeStamp()+"_"+makeHash(input_files)+".root")
    #call("touch hadd_%d_%d.log"%(skip,chunk))
    args = ["hadd", "-v", "0","-f", newpath] + input_files
    #args += [" >>& hadd_%d_%d.log"%(skip,chunk)]
    #print (args)
    retcode = 1
    try:
        retcode = call(args)
    except:
        print ("error in merge")
        retcode +=2
    if retcode != 0:
        print("MergeRoot: Error from hadd!")   
    return newpath,retcode

def mergeLar(newpath,input_files,config,debug=False):
    'use larto  merge the data, no limit on length of list'
    #if os.path.exists(newpath):
    #newpath = newpath.replace(".root","_"+makeTimeStamp()+"_"+makeHash(input_files)+".root")
    #call("touch hadd_%d_%d.log"%(skip,chunk))
    args = ["lar", "-c", config] + input_files
    print (args[0],args[1],args[2],args[3])
    print ("lar call", args)
    #args += [" >>& hadd_%d_%d.log"%(skip,chunk)]
    #print (args)
    retcode = 1
    try:
        retcode = call(args)
    except:
        print ("error in lar merge")
        retcode +=2
    if retcode != 0:
        print("MergeRoot: Error from lar",retcode)   
    
    if os.path.exists("./caf.root"): 
        os.rename('./caf.root',newpath)
    elif os.path.exists("./larMerge.root"): 
        os.rename('./larMerge.root',newpath)
    else:
        print (" can't figure out output name")
        retcode+=100
    return newpath,retcode

def metacat2location(alist=None,copylocal=False,debug=False):
    # tries to get a file from FNAL or other site if not available
    # alist is the result of a metacat query

    # first make a list in rucio format
    for file in alist:
        thedid = "%s:%s"%(file["namespace"],file["name"])
        flist.append(thedid)
        if debug: print ("new file",file)
        ruciolist.append({"scope":file["namespace"],"name":file["name"]})
    retcode = 0
    locationmap = {}
    # doing this because I cannot figure out syntax to feed a list of files to rucio
    try:
        result = list(replica_client.list_replicas(ruciolist)) # goes away if you don't grab it???
    except Exception as e:
        result = None
        print('--- Rucio list_replicas call fails: ' + str(e))
        print(' stop this chunk',skip,chunk)
        retcode = 1
        return locationmap,local,1
    if debug: print ("rucio",list(result))

    

    badsites = ["qmul","surfsara"]
    goodsites = ["fnal"]
    for file in result:
        did = file["scope"]+":"+file["name"]
        pfns = file["pfns"]
        if debug: print ("\n ",did)
        location = None
        goodsite = 0

        for rse in pfns:
            if debug: print ("\n RSE",rse)
            badsite=0
            if "fnal" in rse:
                location = rse
                if debug: print ("this as at FNAL",rse)
                goodsite +=1
                break
            for site in badsites:
                if site in rse:
                    if debug: print ("this is a bad site",site)
                    badsite +=1
                    break
            for site in goodsites:
                if site in rse:
                    if debug: print ("this is a good site",site)
                    goodsite +=1
                    location = rse
                    break
            if copylocal and not badsite:
                if debug: print ("this site is ok",rse,badsites)
                location = rse
                break

        if location is None:
            print ("giving up on this file",rse)
            missed.append(did)

            continue
        if "fnal" not in location:
            if debug: print ("good location but need to copy it over",location)
            newlocation,retcode = makeLocalCopy(locationlist=[location],cache="cache",debug=debug)
            if debug: print ("new local copy",newlocation)
            location = newlocation[0]
            #local.append(location)
        else: # at fnal
            if not checkFile(location):  # can I open the file? 
                print ("BIG PROBLEM - cannot read file",location)
                locationmap[did]=None
                continue

            #local.append(location)

        #goodfiles.append(did)
        #locations.append(location)
        locationmap[did]=location
        local.append(location)
    if len(flist) != len(locationmap.keys()):
        print("WARNING: metacat2rucio could not find all the files",len(flist),len(locationmap.keys()))
        
        for x in flist:
            print ("check",x)
            if x not in list(locationmap.keys()):
                print ("not there", x)
        
        retcode = 100
    return locationmap,retcode

def maketargz(list=None,tarname=None,localcache="cache",debug=False):
    local = []
    try:
        if debug: print("tarname",tarname)
        tar = tarfile.open(tarname,"w:gz")
        print ("open tarname", tarname)
    except Exception as e:
        print ("failed to open tar",e,tarname)
        retcode = 2
        return tarname,retcode
    try:
        local,retcode = makeLocalCopy(list,localcache,debug)
        if retcode != 0:
            print ("WARNING: could not get all files into cache, quitting",retcode)
            cleanup(local)
            return tarname,retcode
    except Exception as e:
        print ("local copy failed",e,list,localcache)
        return tarname,4
    try:
        print ("start of taring")
        for file in local:
            #newfile = file
            if debug: print ("add file to tar",file)
            tar.add(file,os.path.basename(file))
        tar.close()
        cleanup(local)
        return tarname,0
    except Exception as e:
        print ("WARNING: tar file failed:",tarname,e)
        cleanup(local)
        return tarname,1

def makeLocalCopy(locationlist=None,cache="cache",debug=False):
    if not os.path.exists(cache):
        try:
            os.mkdir(cache)
        except Exception as e:
            print ("WARNING: No local cache could be defined",cache)
            return [],1
    local = []
    if debug:
        print ("locationlist",locationlist)
    for location in locationlist:
        if cache in location or os.path.exists(os.path.join(cache,os.path.basename(location))):
            if debug: print("using local copy",location)
            local.append(os.path.join(cache,os.path.basename(location)))
        else:
            cp_args = ["xrdcp",location,cache]
            try:
                completed_process = run(cp_args, capture_output=True,text=True)   
                if debug: print (completed_process)       
            except Exception as e:
                print ("WARNING: error doing local copy",e,location)
                continue
            local.append(os.path.join(cache,os.path.basename(location)))
    retcode = len(locationlist)-len(local)
    return local,retcode

def cleanup(local,debug=False):
    for file in local:       
        if debug: print ("removing",file)
        os.remove(file)

def makeName(md,jobtag,tier,skip,chunk,stage):
   
    sskip = str(skip).zfill(6)
    schunk = str(chunk).zfill(6)
    timestamp = makeTimeStamp()
    metadata = md["metadata"]
    if "set" in jobtag[0:4]:
        detector = metadata["core.run_type"]
        campaign = metadata["dune.campaign"]
        fcl = metadata["dune.config_file"]
        app = metadata["core.application.name"]+"_"+metadata["core.application.version"]
        fname = ("%s_%s_%s_%s_merged_skip%s_lim%s_stage_%s_%s.root"%(detector,campaign,fcl,app,sskip,schunk,stage,timestamp))#.replace("__",".")
        return fname
    

    detector = metadata["core.run_type"]
    ftype = metadata["core.file_type"]
    stream = metadata["core.data_stream"]
    tier = metadata["core.data_tier"].replace("-virtual","")
    
    source = metadata["dune.config_file"].replace(".fcl","")

    # if "set" in jobtag[0:4]:
    #     localtag = jobtag.replace(detector+"__","")
    #     localtag = localtag.replace(tier+"__","")
    #     localtag = localtag.replace(".fcl","")
    # else:
    localtag = jobtag.replace(".txt","")

    
    

    fname = "%s_%s_%s_%s_%s_%s_merged_skip%s_lim%s_%s_%s.root"%(detector,ftype,localtag,stream,source,tier,sskip,schunk,stage,timestamp)
    return fname

    # hd-protodune-det-reco:np04hd_raw_run027311_0000_dataflow1_datawriter_0_20240620T044028_reco_stage1_20240623T095830_keepup_hists.root



    detector = metadata["core.run_type"]
    ftype = metadata["core.file_type"]
    stream = metadata["core.data_stream"]
    tier = metadata["core.data_tier"].replace("-virtual","")
    
    source = metadata["dune.config_file"].replace(".fcl","")

    # if "set" in jobtag[0:4]:
    #     localtag = jobtag.replace(detector+"__","")
    #     localtag = localtag.replace(tier+"__","")
    #     localtag = localtag.replace(".fcl","")
    # else:
    localtag = jobtag.replace(".txt","")

    
    

    fname = "%s_%s_%s_%s_%s_%s_merged_skip%s_lim%s_%s_%s.root"%(detector,ftype,localtag,stream,source,tier,sskip,schunk,stage,timestamp)
    return fname

    # hd-protodune-det-reco:np04hd_raw_run027311_0000_dataflow1_datawriter_0_20240620T044028_reco_stage1_20240623T095830_keepup_hists.root

def calculate_chunks(nfiles_total, skip_files, chunk_size):
    """
    Function to calculate the number of chunks for file processing.

    Args:
    - nfiles_total (int): Total number of files to process.
    - skip_files (int): Number of files to skip initially.
    - chunk_size (int): Number of files to process per chunk.

    Returns:
    - n_chunks (int): The total number of chunks required.
    """
    remaining_files = nfiles_total
    # Ceiling division to calculate number of chunks needed
    n_chunks = (remaining_files + chunk_size - 1) // chunk_size  # Total number of chunks required

    print(f"Total files to process: {nfiles_total}")
    print(f"Files to skip: {skip_files}")
    print(f"Number of chunks: {n_chunks}\n")

    return n_chunks

 
if __name__ == "__main__":
    """
    Script to merge file chunks using a Metacat query, based on user input options such as workflow, run, dataset, etc.

    This script splits the total number of files into smaller chunks, processes them chunk by chunk, and runs 
    Metacat queries to retrieve the files based on user-defined conditions such as detector type, file type, 
    workflow ID, data tier, run, dataset, and version. The chunks are processed in parallel streams for different data types (e.g., "physics", "cosmics", "calibration"). 
    """

    test=False
   
    fast=False # dangerous as merges data but not meta properly

    outsize = 4000000000

    parser = argparse.ArgumentParser(description='Merge Data - need to choose run, workflow, dataset or listfile')
    #parser.add_argument("--fileName", type=str, help="Name of merged file, will be padded with timestamp if already exists", default="merged.root")
    parser.add_argument("--listfile",type=str, help="file containing a list of files to merge, they must have json in the same director")
    parser.add_argument("--workflow",type=int, help="workflow id to merge",default=None)
    parser.add_argument("--detector",type=str, help="detector id [hd-protodune]",default="hd-protodune")
    parser.add_argument("--chunk",type=int, help="number of files/merge",default=50)
    parser.add_argument("--nfiles",type=int, help="number of files to merge total",default=100000)
    parser.add_argument("--skip",type=int, help="number of files to skip before doing nfiles",default=0)
    parser.add_argument("--run",type=int, help="run number", default=None)
    parser.add_argument("--dataset",type=str, help="input dataset", default=None)
    parser.add_argument("--destination",type=str,help="destination directory", default=None)
    parser.add_argument("--data_tier",type=str,default="root-tuple-virtual",help="input data tier [root-tuple-virtual]")
    parser.add_argument("--output_data_tier",type=str,default=None,help="output data tier [None]")
    parser.add_argument("--file_type",type=str,default="detector",help="input detector or mc, default=detector")

    parser.add_argument("--test",help="write to test area",default=False,action='store_true')
    #parser.add_argument("--skip",type=int, help="skip on query",default=0)
    parser.add_argument('--application',help='merge application name [inherits]',default=None,type=str)
    parser.add_argument('--version',help='software version for input query',default=None,type=str)
    parser.add_argument('--merge_version',help='software version for merge [inherits]',default=None,type=str)
    parser.add_argument('--debug',help='make very verbose',default=False,action='store_true')
    parser.add_argument("--uselar",help='use lar instead of hadd',default=False,action='store_true')
    parser.add_argument('--lar_config',type=str,default=None,help="fcl file to use with lar when making tuples, required with --uselar")
    parser.add_argument('--merge_stage',type=str,default="unknown",help="stage of merging, final for last step")
    parser.add_argument('--direct_parentage',default=False,action='store_true')
    parser.add_argument("--datasetName", type=str, help="optional name of output dataset this will go into", default=None)
    parser.add_argument("--maketar",help="make a gzipped tar file",default=False,action='store_true')
    parser.add_argument("--copylocal",help="copy files to local cache from remote",default=False,action='store_true')

    

    args = parser.parse_args()

    if args.maketar:  
        print ("setting copylocal to true for maketar")
        args.copylocal=True

    debug = args.debug
    if args.workflow is None and args.run is None and args.dataset is None and args.listfile is None:
        print ("ERROR: need to specify either workflow or run or dataset or listfile ")
        sys.exit(1)

    # get a list of files from metacat

    replica_client=ReplicaClient()

    if args.uselar and not args.lar_config and not args.merge_version:
        print ("If using Lar you should provide --lar_config and --merge_version=lar_version")
        sys.exit(1)

    if args.uselar and args.maketar:
        print ("you need to choose your merging method - cannot do both lar and tar")
        sys.exit(1)

    if "-virtual" in args.data_tier and not args.maketar:
        args.output_data_tier = args.data_tier.replace("-virtual","")

    if args.uselar and not args.output_data_tier:
        args.output_data_tier = args.data_tier

    if args.maketar and not args.output_data_tier:
        args.output_data_tier = args.data_tier + "-tar"

    
    nfiles_total = args.nfiles

    if args.listfile:
        thelistfile = open(args.listfile,'r')
        theflist = thelistfile.readlines()
        thelistfile.close()
        nfiles_total = len(theflist)
        jobtag = "list-%s"%os.path.basename(args.listfile)

    chunk_size = args.chunk
    skip_files = args.skip
       
    n_chunks  = calculate_chunks(nfiles_total, skip_files, chunk_size)

    print ("starting up")
    for data_stream in ["", "physics","cosmics","calibration"]:
        if (args.dataset or args.listfile) and data_stream != "":
            continue # dataset doesn't look at stream so only do once
        elif not (args.dataset or args.listfile) and data_stream == "":
            continue # this is when you need to do the loop over data_stream

        for chunk_idx in range(n_chunks):
            first_file_idx = skip_files + chunk_idx * chunk_size  # Starting index for this chunk
            # For the last chunk, ensure we don't exceed the total number of files
            last_file_idx = min(first_file_idx + chunk_size, skip_files + nfiles_total)
    
            if args.workflow is not None:
                query = "files where dune.output_status=confirmed and core.run_type=%s and core.file_type=%s and dune.workflow['workflow_id']=%d and core.data_tier=%s and core.data_stream=%s and core.application.version=%s ordered skip %d limit %d"%(args.detector,args.file_type,args.workflow,args.data_tier,data_stream,args.version, first_file_idx, last_file_idx - first_file_idx )
                sworkflow = str(args.workflow).zfill(10)
                jobtag = "workflow%s"%sworkflow
                
            
            elif args.run is not None:
                query = "files where dune.output_status=confirmed and core.run_type=%s and core.file_type=%s and core.runs[any]=%d and core.data_tier=%s and core.data_stream=%s and core.application.version=%s ordered skip %d limit %d"%(args.detector,args.file_type,args.run,args.data_tier,data_stream,args.version,first_file_idx, last_file_idx - first_file_idx)
                srun = str(args.run).zfill(10)
                jobtag = "run%s"%srun
                
            elif args.dataset is not None:
                query = "files from %s ordered  %d limit %d"%(args.dataset,first_file_idx, last_file_idx - first_file_idx)
                    
                jobtag = "set-%s"%(args.dataset.replace(":",'_x_')).replace(".fcl","")

            elif args.listfile is not None:
                print('doing filelist')
                thefiles = (theflist.copy())[first_file_idx:last_file_idx]
                alist = []
                mfiles = []
                
                print ("listfile list for this chunk: ",first_file_idx, len(thefiles))
                for f in thefiles:
                    file = f.strip()
                    filename = os.path.basename(file)
                    if args.debug:("print check file",file)

                    if not os.path.exists(file):
                        print ("file",file,"does not exist, skipping")
                        continue
                    mfile = file+".json"
                    mfilename = os.path.basename(mfile)
                    #if args.debug:("print check metafile",mfile,mfilename in dir,os.path.exists(mfile))
                    if not os.path.exists(mfile):
                        
                        print ("metafile",file,"has no metadata, skipping")
                        continue
                    mfiles.append((mfile))
                    # store xroot for actual file
                    alist.append(pnfs2xrootd(file))
            else:
                print ("ERROR: need to supply --run, --workflow or --dataset")
                sys.exit(1)

            if not args.listfile:  
                print ("mergeRoot: metacat query = ", query)
                alist = list(mc_client.query(query=query))
                theinfo = mc_client.query(query=query,summary="count")

            if debug:
                if (theinfo['count']!= 0):
                    print(f"Chunk {chunk_idx + 1}: Process files {first_file_idx} to {last_file_idx}")
                    print(theinfo)

            flist = []
            ruciolist = []
            local = []

            if len(alist)<= 0:
                print ("mergeRoot: returning zero files, nothing to do")
                break

            # make lists
            if not args.listfile:
                for file in alist:
                    thedid = "%s:%s"%(file["namespace"],file["name"])
                    flist.append(thedid)
                    if debug: print ("new file",file)
                    ruciolist.append({"scope":file["namespace"],"name":file["name"]})
                    
                if debug: print (ruciolist)
            # now get a list of locations from rucio
            if args.listfile:  # this just allows tests without using rucio
                print("========== ")
                print(alist)
                locations =  alist.copy()
                goodfiles = mfiles
                local = locations
                
            else:   
                retcode = 0
                locations = []  
                goodfiles = []
                # doing this because I cannot figure out syntax to feed a list of files to rucio
                try:
                    result = list(replica_client.list_replicas(ruciolist)) # goes away if you don't grab it???
                except Exception as e:
                    result = None
                    print('--- Rucio list_replicas call fails: ' + str(e))
                    print(' stop this chunk',skip,chunk)
                    break
                if debug: print ("rucio",list(result))

                badsites = ["qmul","surfsara"]
                goodsites = ["fnal"]
                for file in result:
                    did = file["scope"]+":"+file["name"]
                    pfns = file["pfns"]
                    if debug: print ("\n ",did)
                    location = None
                    
                    for rse in pfns:
                        if debug: print ("\n RSE",rse)
                        goodsite = False
                        # for site in badsites:
                        #     if site in rse:
                        #         if debug: print ("this is a bad site",site)
                        #         goodsite = False
                        #         break
                        for site in goodsites:
                            if site in rse:
                                if debug: print ("this is a good site",site)
                                goodsite = True
                                break
                        if goodsite:     
                            if debug: print ("this site is ok",rse,badsites)
                            location = rse
                            break
            
                    if location is None:
                        print ("giving up on this file",rse)
                        missed.append(did)
                        continue
                    if "fnal" not in location:
                        cp_args = ["xrdcp",location,"./cache/."]
                        try:
                            completed_process = run(cp_args, capture_output=True,text=True)   
                            if debug: print (completed_process)
                    
                            
                        except Exception as e:
                            print ("error doing local copy",e)
                            continue
                        local.append(os.path.join("./cache",os.path.basename(location)))
                    else: # at fnal
                        if not checkFile(location):  # can I open the file? 
                            print ("BIG PROBLEM - cannot read file",location)
                            missed.append(did)
                            continue

                        local.append(location)
                    goodfiles.append(did)
                    locations.append(location)
                print (" list lengths goodfiles,locations", len(goodfiles),len(locations))
        

            if debug: print ("local",local)

            #if debug: print (locations)

            # copy files to local area for merge

            filecount = 0

            if len(goodfiles) >= 1:
                
                print (goodfiles[0])
                if not args.listfile:
                    firstmeta = mc_client.get_file(did=goodfiles[0],with_metadata=True)
                else:
                    f1 = open(goodfiles[0],'r')
                    firstmeta = json.load(f1)
                    if "namespace" in firstmeta:
                        namespace = firstmeta["namespace"]
                    else:
                        namespace = "unknown"
                    f1.close()
                #firstmeta["core.data_tier"] = args.data_tier
                # firstname = firstmeta["name"]
                # pieces = firstname.split("_")
                # pieces = pieces[0:2]+pieces[7:]
                # keep = []
                
                # if args.listfile: 
                #     namespace=firstmeta["namespace"]
                # for i in range(0,len(pieces)):
                #     x = pieces[i]
                #     #print (x[0:3],x[0:3])
                #     if x[0:3] == "run": 
                        
                #         continue
                #     #if x[0:4] == "2024": continue
                #     if "datawriter" in x: 
                    
                #         continue
                #     if "dataflow" in x: continue
                #     keep.append(x)
                

                    
                
                # newname ='_'.join(keep)
                # sskip = str(skip).zfill(6)
                # schunk = str(chunk).zfill(4)
                
                # newname = newname.replace(".root","_merged_%s_%s_skip%s_lim%s_%s.root"%(data_stream,jobtag,sskip,schunk,makeTimeStamp()))
                # print ("newname",newname)
                filecount = last_file_idx - first_file_idx
                if len(goodfiles) < last_file_idx:
                    filecount = len(goodfiles) 
                newname = makeName(firstmeta,jobtag,args.data_tier,first_file_idx,filecount,args.merge_stage)
                print ("newname",newname)
                
                
            else:
                print ("no good files left in list")
            missed = []
            outputfile = newname
            if args.uselar:
                newfile,retcode = mergeLar(outputfile,local,args.lar_config) #lar
            else:  
                newfile,retcode = mergeData(outputfile,local) #hadd
            print ("merged data", newfile,retcode)

            if retcode != 0:
                errlog = open(outputfile+".failure",'w')
                json.dump(goodfiles,errlog,indent=4)
                errlog.close()
                continue 

            
            print ("mergeRoot: output will go to ",newfile)

            if debug: print (flist)
            if True:
                merge_type = "metacat"
                newnamespace=None
                jsonlist = None
                if args.listfile: 
                    merge_type="local"
                    newnamespace = namespace
                    
                retcode = run_merge(newfilename=newfile, newnamespace=newnamespace, datasetName=args.datasetName,
                                datatier="root-tuple", application=args.application,version=args.merge_version, flist=goodfiles, 
                                merge_type=merge_type, do_sort=0, user='', debug=debug, stage=args.merge_stage,skip=first_file_idx,nfiles=last_file_idx,direct_parentage=args.direct_parentage)
                
                
                jsonfile = newfile+".json"
                print ("MergeRoot: retcode", retcode,jsonfile)

            else:
                print ("MergeRoot: ERROR making merged metadata")
                retcode +=4
                sys.exit(retcode)

            if os.path.exists(newfile):
                print ("clean up inputs")
                #cleanup(local)

            if args.destination is None:

                topdestination = "/pnfs/dune/persistent/users/%s/merging/"%os.getenv("USER")
                if args.test:
                    topdestination = "/pnfs/dune/persistent/users/%s/test_merging/"%os.getenv("USER")
                destination = os.path.join(topdestination,jobtag+"_"+makeTimeStamp())
                
                mk_args = ["ifdh", "-p", "mkdir",destination]
                try:
                    process = run(mk_args,capture_output=True,text=True)   
                    print ("made output directory",destination)
                except Exception as e:
                    print("Could not make remote directory",e, destination)
                    sys.exit(100)
        
            else:
                destination = args.destination

            if destination is not None and os.path.exists(jsonfile):
                 
                cp_args = ["ifdh", "cp","-D", newfile,jsonfile,destination]
                if destination == "local":
                    continue
                else:
                    
                    cmd = "ifdh cp %s %s %s"%(newfile,jsonfile,destination)
                    print (cp_args)
                    try:
                        completed_process = run(cp_args, capture_output=True,text=True)   
                        print (completed_process)  
                        print ("remove local copies")
                        os.remove(newfile)
                        os.remove(jsonfile)

                
                    except Exception as e:
                        print ("WARNING: doing copy to destination",e,cp_args,destination)
                        print ("try again ", cmd)

                        try: 
                            os.system(cmd)
                            os.remove(newfile)
                            os.remove(jsonfile)
                        except Exception as e:
                            print ("ERROR: second attempt at copy failed, quitting",e)
                            break
            for x in missed:
                print ("file missed",x)
