import os,sys

import MakeTarball

import argparse

from MakeTarball import timeform,MakeTarball

from metacat.webapi import MetaCatClient
mc_client = MetaCatClient(os.environ["METACAT_SERVER_URL"])
    

if __name__ == "__main__":

    test=False
   

    parser = argparse.ArgumentParser(description='Merge root files')
    
    parser.add_argument("--detector",type=str, help="detector id [hd-protodune]",default="hd-protodune")
    parser.add_argument("--dataset",type=str, help= "metacat dataset",default=None)
    parser.add_argument("--chunk",type=int, help="number of files/merge",default=50)
    parser.add_argument("--nfiles",type=int, help="number of files to merge total",default=100000)
    parser.add_argument("--skip",type=int, help="number of files to skip before doing nfiles",default=0)
    parser.add_argument("--run",type=int, help="run number", default=None)
    parser.add_argument("--destination",type=str,help="destination directory", default=None)
    parser.add_argument("--data_tier",type=str,default="root-tuple-virtual",help="input data tier [root-tuple-virtual]")
    parser.add_argument("--file_type",type=str,default="detector",help="input detector or mc, default=detector")

    #parser.add_argument("--test",help="write to test area",default=False,action='store_true')
    #parser.add_argument("--skip",type=int, help="skip on query",default=0)
    parser.add_argument('--application',help='merge application name [inherits]',default=None,type=str)
    parser.add_argument('--version',help='software version of files to merge (required)',default=None,type=str)
    parser.add_argument('--merge_version',help='software version for merged file [inherits]',default=None,type=str)
    parser.add_argument('--debug',help='make very verbose',default=False,action='store_true')
    parser.add_argument('--maketar',help="make a tarball",default=False,action='store_true')
    parser.add_argument('--usetar',help="full path for existing tarball",default=None,type=str)
    parser.add_argument("--uselar",help='use lar instead of hadd',default=False,action='store_true')
    parser.add_argument('--lar_config',type=str,default=None,help="fcl file to use with lar when making tuples, required with --uselar")
    parser.add_argument('--merge_stage',type=str,default="unknown",help="stage of merging, final for last step")
    
    
    args = parser.parse_args()



    debug = args.debug

    if (args.run is None  or  args.version is None) and args.dataset is None:
        print ("You have to set a run number --run and a --version, or a --dataset",args.run, args.version, args.dataset)

        
        sys.exit(1)

    if args.maketar is False and args.usetar is None:
        print ("you either have to set --maketar or provide --usetar value")
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

    if args.run:
        thetag  = "%d_%d_%d"%(args.skip,args.nfiles,args.run) 
    
    else:
        thetag = "merging_%d_%d_%s"%(args.skip,args.nfiles,thetime)

    if args.uselar:
        thetag = "merging_%d_%d_%s_%s"%(args.skip,args.nfiles,args.lar_config,thetime)

    



    if args.destination is None:
        sskip = str(args.skip).zfill(6)
        if args.run:
            srun = str(args.run).zfill(10)
            jobtag = "run%s_%s_"%(srun,sskip)+thetime
        else:
            jobtag = "%s_%s"%(thetag,sskip)
        
        

        destination = "/pnfs/dune/scratch/users/%s/merging/%s"%(os.getenv("USER"),jobtag)
    else:
        destination = args.destination

    if args.merge_version is None and not args.dataset:
        args.merge_version = args.version

    if not os.path.exists(destination):
        print ("make a destination",destination)
        os.mkdir(destination)
    # else:
    #     olddir = destination+"."+timeform()
    #     print ("destination directory",jobtag,"already exists, moving out of the way to",os.path.basename(olddir))
    #     os.rename(destination,olddir)
    #     os.mkdir(destination)

    

    

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
        print (location)
    else:
        location = args.usetar
    print ("tarfile is ",location)
    if not os.path.exists("logs"):
        os.mkdir("logs")
    
    
    
    # if args.run:
    #     cmd = "cp remote.sh %s_remote.sh"%thetag
    # else:
    #     cmd = "cp remote_dataset.sh %s_remote.sh"%thetag

    # if args.uselar:
    #     cmd = "cp remote_lar.sh lar_%s_remote.sh"%thetag

    #os.system(cmd)

    bigskip = args.skip
    bigchunk = args.chunk*20
    if args.uselar: bigchunk=args.chunk*2 # lar needs to be spread out more. 
    nfiles = min(bigchunk,numfiles)
    start = args.skip
    end = start + numfiles
    print (bigskip,numfiles,bigchunk,start,end)
    while bigskip < end:  # should ths be < or <= ?
        environs = ""
        environs = "-e CHUNK=%d "%args.chunk
        environs += "-e SKIP=%d "%bigskip
        environs += "-e STAGE=%s "%args.merge_stage
        if args.run: 
            environs += "-e RUN=%d "%args.run
            environs += "-e DATASET=None "
        if args.dataset: 
            environs += "-e DATASET=%s "%args.dataset
            environs += "-e RUN=0 "
        environs += "-e NFILES=%d "%nfiles
        environs += "-e DETECTOR=%s "%args.detector
        environs += "-e FILETYPE=%s "%args.file_type
        environs += "-e DATA_TIER=%s "%args.data_tier
        if args.run: environs += "-e VERSION=%s "%args.version 
        environs += "-e MERGE_VERSION=%s "%args.merge_version
        environs += "-e DESTINATION=%s "%destination
        environs += "-e TIMESTAMP=%s "%thetime
        environs += "-e USERNAME=%s "%os.getenv("USER")
        environs += "-e USELAR=%s "%args.uselar
        environs += "-e LARCONFIG=%s "%args.lar_config
        cmd = "jobsub_submit "
        cmd += "--group dune "
        cmd += "--resource-provides=usage_model=DEDICATED,OPPORTUNISTIC "
        if args.uselar:
            cmd += "--singularity-image /cvmfs/singularity.opensciencegrid.org/fermilab/fnal-dev-sl7:latest "
        else:
            cmd += "--singularity-image /cvmfs/singularity.opensciencegrid.org/fermilab/fnal-wn-el9:latest "
        cmd += "--role=Analysis "
        cmd += "--expected-lifetime 8h "
        cmd += "--memory 3000MB "
        cmd += "--tar_file_name dropbox://"+location+" "
        cmd += "--use-cvmfs-dropbox " 


        cmd += environs
        here = os.environ["PWD"]
        subname = "%d_%d_%s.sh"%(bigskip,nfiles,thetag)
                
        if args.run:
            rcmd =  "cp remote.sh "+subname
        if args.dataset:
            rcmd =  "cp remote_dataset.sh "+subname
        if args.uselar:
            rcmd =  "cp remote_lar.sh "+subname

        os.system(rcmd)
        cmd += " file://"+os.path.join(here,subname)
        
        cmd += " >& logs/submit_%d_%d_%s_%s_%s.log"%(bigskip,nfiles,thetag,bigskip,thetime)
       
        
        
        print (cmd)

        cmdfile = open("logs/submit_%d_%d_%s_%s_%s.job"%(bigskip,nfiles,thetag,bigskip,thetime),'w')
        cmdfile.write(cmd)
        cmdfile.close()
        try:
            os.system(cmd)
        except:
            print ("submission failed for some reason")
        bigskip += bigchunk



