""" script to submit mergeRoot as a batch job, has similar arguments
H. Schellman, Sept 2024
"""

import os,sys
import argparse
import json

from metacat.webapi import MetaCatClient

import MakeTarball

from MakeTarball import timeform,MakeTarball

from preMergeAudit import checklist


mc_client = MetaCatClient(os.environ["METACAT_SERVER_URL"])
    

if __name__ == "__main__":

    test=False
   

    parser = argparse.ArgumentParser(description='Merge root files')
    
    parser.add_argument("--detector",type=str, help="detector id [hd-protodune]",default=None)
    parser.add_argument("--dataset",type=str, help= "metacat dataset",default=None)
    parser.add_argument("--chunk",type=int, help="number of files/merge this step, should be < 100",default=50)
    parser.add_argument("--nfiles",type=int, help="number of files to merge total",default=100000)
    parser.add_argument("--skip",type=int, help="number of files to skip before doing nfiles",default=0)
    parser.add_argument("--run",type=int, help="run number", default=None)
    parser.add_argument("--destination",type=str,help="destination directory", default=None)
    parser.add_argument("--data_tier",type=str,default="root-tuple-virtual",help="input data tier [root-tuple-virtual]")
    parser.add_argument("--file_type",type=str,default="detector",help="input detector or mc, default=detector")

    parser.add_argument('--application',help='merge application name [inherits]',default=None,type=str)
    parser.add_argument('--version',help='software version of files to merge (required)',default=None,type=str)
    parser.add_argument('--merge_version',help='software version for merged file [inherits]',default=None,type=str)
    parser.add_argument('--debug',help='make very verbose',default=False,action='store_true')
    parser.add_argument('--maketar',help="make a tarball",default=False,action='store_true')
    parser.add_argument('--usetar',help="full path for existing tarball",default=None,type=str)
    parser.add_argument("--uselar",help='use lar instead of hadd',default=False,action='store_true')
    parser.add_argument('--lar_config',type=str,default=None,help="fcl file to use with lar when making tuples, required with --uselar")
    parser.add_argument('--merge_stage',type=str,default="unknown",help="stage of merging, final for last step")
    parser.add_argument('--project_tag',type=str,default=None,help="tag to describe the project you are doing")
    parser.add_argument('--direct_parentage',default=False,action='store_true')
    parser.add_argument("--datasetName", type=str, help="optional name of output dataset this will go into", default=None)
    parser.add_argument("--campaign", type=str, help="campaign", default=None)
    
    
    args = parser.parse_args()

    debug = args.debug

    if not args.detector:
        print ("You must specify a detector: hd-protodune, fardet-vd ... or we won't know what to do with the output")
        sys.exit(1)

    if (args.run is None  or  args.version is None) and args.dataset is None:
        print ("You have to set a run number --run and a --version, or a --dataset",args.run, args.version, args.dataset)

        
        sys.exit(1)

    if args.uselar and not args.dataset:
        print ("right now you can only use lar with the dataset option")
        sys.exit(1)


    if args.maketar is False and args.usetar is None:
        print ("you either have to set --maketar or provide --usetar value")
        sys.exit(1)

    if args.usetar and not os.path.exists(args.usetar):
        print("tarfile does not exist",args.usetar)
        sys.exit(1)

    if args.uselar and args.lar_config is None:
        print ("if using lar, you must provide a fcl file and merge_version=dunesw version")
        sys.exit(1)

    if args.run:
        query = "files where dune.output_status=confirmed and core.run_type=%s and core.file_type=%s and core.runs[any]=%d and core.data_tier=%s  and core.application.version=%s ordered "%(args.detector,args.file_type,args.run,args.data_tier,args.version)

    
    elif args.dataset:
        query = "files from %s ordered skip %d limit %d "%(args.dataset,args.skip,args.nfiles)

    print ("query",query)

    info = mc_client.query(query=query,summary="count")
    print (info)

    numfiles  = info["count"]

    thetime = timeform()

    

    if args.uselar and args.dataset is None:
        print("currently can only run lar with datasets")
        sys.exit(1)

    if numfiles == 0:
        print("No files found, if running mc you need to set --file_type=mc")
        sys.exit(1)
        
    if numfiles > args.nfiles:
        numfiles = args.nfiles 

    # make well formatted strings

    sskip = str(args.skip).zfill(6)
    snfiles = str(args.nfiles).zfill(6)

    if args.project_tag:
        project =  args.project_tag  +"_"
    else:
        project = ""
    

    if args.run:
        srun = str(args.run).zfill(10)
    else:
        srun = ""

    if args.run:
        thetag  = "run_%s%s_%s_%s_%s"%(project,srun,sskip,snfiles,thetime) 
    
    else:
        thetag = "merging_%s%s_%s_%s"%(project, sskip,snfiles,thetime)

    if args.uselar:
        thetag = "merging_%s%s_%s_%s_%s"%(project,sskip,snfiles,(args.lar_config).replace(".fcl",""),thetime)

    
    print ("make a new tag ", thetag)


    if args.destination is None:
        
        if args.run:
            
            jobtag = "%s"%thetag
            
        else:
            jobtag = "%s"%(thetag)
        
        
        destination = "/pnfs/dune/scratch/users/%s/merging/%s"%(os.getenv("USER"),jobtag)
    else:
        destination = args.destination

    fids,duplicates,missing = checklist(usemeta=True,query=query,rucio_site="fnal")
    if len(duplicates) > 0:
        print ("there are duplicates in this sample, can't merge",len(duplicates))
        sys.exit(1)
    else:
        print ("passed a duplicates test with no problems")
    
    if len(missing) > 0:
        print ("there are",len(missing)," files not available at the merge site, giving up")
        missed = open(jobtag+"_missing.log",'w')
        
        json.dump(missing,missed,indent=4)
        missed.close()
        sys.exit(1)

    if args.merge_version is None and not args.dataset:
        args.merge_version = args.version

    if not os.path.exists(destination):
        print ("make a destination",destination)
        os.mkdir(destination)
     

    print ("number of files to process is ",numfiles)
    location = None
    if args.maketar:
        tmpdir = "/exp/dune/data/users/%s/tars"%(os.getenv("USER"))
        tardir = "/pnfs/dune/scratch/users/%s/tars"%(os.getenv("USER"))

        if not os.path.exists(tmpdir):
            os.mkdir(tmpdir)
        if not os.path.exists(tardir):
            os.mkdir(tardir)
        basedirname="."
        tag = "tarball-%s"%thetime
        location = MakeTarball(tmpdir=tmpdir,tardir=tardir,tag = tag,basedirname=basedirname,debug=True)
        #print ("tar location is ",location)
    else:
        location = args.usetar
    print ("tarfile is ",location)
    logdir = os.path.join(os.getenv("PWD"),"logs")
    if not os.path.exists(logdir):
        os.mkdir(logdir)
    print ("submit logs will appear in",logdir)

    chunk_size = args.chunk
    nfiles_total = args.nfiles
    skip_files = args.skip
    # Compute how many files are remaining to process, without reducing the total files
    remaining_files = nfiles_total

    # Ceiling division to calculate number of chunks needed
    n_chunks = (remaining_files + chunk_size - 1) // chunk_size  # Total number of chunks required

    print(f"Total files to process: {nfiles_total}")
    print(f"Files to skip: {skip_files}")
    print(f"Number of chunks: {n_chunks}\n")

    # Loop through each chunk, print the start and end file index for each chunk
    for chunk_idx in range(n_chunks):
        first_file_idx = skip_files + chunk_idx * chunk_size  # Starting index for this chunk
        # For the last chunk, ensure we don't exceed the total number of files
        last_file_idx = min(first_file_idx + chunk_size, skip_files + remaining_files)
    
        print(f"Chunk {chunk_idx + 1}: Process files {first_file_idx} to {last_file_idx}")

        subname = "%s/%d_%d_%s.sh"%(logdir,first_file_idx,last_file_idx,thetag)
        if args.run:
            g = open("remote.sh",'r')
        if args.dataset:
            g = open("remote_dataset.sh",'r')
        if args.uselar:
            g = open("remote_lar.sh",'r')
        sub = open(subname,'w')
        lines = g.readlines()
        for line in lines:
            # Note: since we are doing submission per chunk we don't need to specify the chunk size
            # this is done based on numbers of chunks
            _chunk = last_file_idx-first_file_idx
            newline = line.replace("$CHUNK","%d"%_chunk)
            newline = newline.replace("$SKIP","%d"%first_file_idx)
            if args.merge_stage: 
                newline = newline.replace("$STAGE",args.merge_stage)
            if args.datasetName: 
                newline = newline.replace("${DATASETNAME}",args.datasetName)
            if args.run:
                newline = newline.replace("$RUN","%d"%args.run)

            else:
                newline = newline.replace("$RUN","%d"%0)
            if args.dataset:
                newline = newline.replace("$DATASET",args.dataset)
            else:
                newline = newline.replace("$DATASET","0")
            if args.direct_parentage:
                newline = newline.replace("$DIRECTPARENTAGE","--direct_parentage")
            else:
                newline = newline.replace("$DIRECTPARENTAGE","")
            # tmp variable for number of files as we are ajusting the number of files per chunk
            _nfiles = last_file_idx-first_file_idx
            newline = newline.replace("$NFILES","%d"%_nfiles)
            newline = newline.replace("$DETECTOR",args.detector)
            if args.data_tier: newline = newline.replace("$DATA_TIER",args.data_tier)
            newline = newline.replace("$FILETYPE",args.file_type)
            if args.version: newline = newline.replace("$VERSION",args.version)
            if args.merge_version: newline = newline.replace("$MERGE_VERSION",args.merge_version)
            newline = newline.replace("$DESTINATION",destination)
            newline = newline.replace("$TIMESTAMP",thetime)
            newline = newline.replace("$USERNAME",os.getenv("USER"))
            if args.uselar:
                newline = newline.replace("$USELAR","--uselar")
            if args.lar_config:
                newline = newline.replace("$LARCONFIG",args.lar_config)
            if args.campaign:
                newline = newline.replace("$CAMPAIGN", args.campaign)
            sub.write(newline)
            #print (newline)
        sub.close()
        environs = ""
        # environs = ""
        #environs = "-e CHUNK=%d "%args.chunk
        #environs += "-e SKIP=%d "%bigskip
        #environs += "-e STAGE=%s "%args.merge_stage
        if args.datasetName:
            environs += "-e DATASETNAME=%s "%args.datasetName
        #if args.run: 
        #    environs += "-e RUN=%d "%args.run
        # if args.dataset: 
        #     environs += "-e DATASET=%s "%args.dataset
        #     environs += "-e RUN=0 "
        # if args.direct_parentage:
        #     environs += "-e DIRECT_PARENTAGE='--direct_parentage' "
        # else:
        #     environs += "-e DIRECT_PARENTAGE='' "
        #environs += "-e NFILES=%d "%nfiles
        #environs += "-e DETECTOR=%s "%args.detector
        #environs += "-e FILETYPE=%s "%args.file_type
        #environs += "-e DATA_TIER=%s "%args.data_tier

        # these are needed to set up lar
        #if args.run and args.version: environs += "-e VERSION=%s "%args.version 
        if args.merge_version: environs += "-e MERGE_VERSION=%s "%args.merge_version
        # environs += "-e DESTINATION=%s "%destination
        # environs += "-e TIMESTAMP=%s "%thetime
        # environs += "-e USERNAME=%s "%os.getenv("USER")
        # environs += "-e USELAR=%s "%args.uselar
        # environs += "-e LARCONFIG=%s "%args.lar_config
        cmd = "jobsub_submit "
        cmd += "--group dune "
        cmd += "--resource-provides=usage_model=DEDICATED,OPPORTUNISTIC "
        if args.uselar:
            cmd += "--singularity-image /cvmfs/singularity.opensciencegrid.org/fermilab/fnal-dev-sl7:latest "
        else:
            cmd += "--singularity-image /cvmfs/singularity.opensciencegrid.org/fermilab/fnal-wn-el9:latest "
        if os.getenv("USER") != "dunepro":
            cmd += "--role=Analysis "
        else:
            cmd += "--role=Production "
        cmd += "--expected-lifetime 8h "
        cmd += "--memory 4000MB "
        cmd += "--disk 20GB "
        cmd += "--tar_file_name dropbox://"+location+" "
        cmd += "--use-cvmfs-dropbox " 


        cmd += environs
        here = os.environ["PWD"]
        #subname = "%s/%d_%d_%s.sh"%(logdir,bigskip,nfiles,thetag)
                
        # if args.run:
        #     rcmd =  "cp remote.sh "+subname
        # if args.dataset:
        #     rcmd =  "cp remote_dataset.sh "+subname
        # if args.uselar:
        #     rcmd =  "cp remote_lar.sh "+subname

        # os.system(rcmd)
        cmd += " file://"+os.path.join(here,subname)
        
        cmd += " >& %s/submit_%d_%d_%s_%s_%s.log"%(logdir,first_file_idx,last_file_idx,thetag,first_file_idx,thetime)
       
        
        
        print (cmd)
        
        cmdfile = open("%s/submit_%d_%d_%s_%s_%s.job"%(logdir,first_file_idx,last_file_idx,thetag,first_file_idx,thetime),'w')
        cmdfile.write(cmd)
        cmdfile.close()
        try:
            os.system(cmd)
        except Exception as e:
            print ("submission failed for some reason",e,"need to submit from AL9 window")
        #bigskip += bigchunk
        
