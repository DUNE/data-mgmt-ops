import os,sys

import MakeTarball

import argparse

from MakeTarball import timeform,MakeTarball


    

if __name__ == "__main__":

    test=False
   

    parser = argparse.ArgumentParser(description='Merge root files')
    
    parser.add_argument("--detector",type=str, help="detector id [hd-protodune]",default="hd-protodune")
    #parser.add_argument("--dataset",type=str, help= "metacat dataset",default=None)
    parser.add_argument("--chunk",type=int, help="number of files/merge",default=50)
    parser.add_argument("--nfiles",type=int, help="number of files to merge total",default=1000)
    parser.add_argument("--skip",type=int, help="number of files to skip before doing nfiles",default=0)
    parser.add_argument("--run",type=int, help="run number", default=None)
    parser.add_argument("--destination",type=str,help="destination directory", default=None)
    parser.add_argument("--data_tier",type=str,default="root-tuple-virtual",help="input data tier [root-tuple-virtual]")

    #parser.add_argument("--test",help="write to test area",default=False,action='store_true')
    #parser.add_argument("--skip",type=int, help="skip on query",default=0)
    parser.add_argument('--application',help='merge application name [inherits]',default=None,type=str)
    parser.add_argument('--version',help='software version for merge [inherits]',default=None,type=str)
    parser.add_argument('--debug',help='make very verbose',default=False,action='store_true')
    parser.add_argument('--maketar',help="make a tarball",default=False,action='store_true')
    parser.add_argument('--usetar',help="full path for existing tarball",default=None,type=str)
    
    args = parser.parse_args()

    debug = args.debug

    if args.run is None:
        print ("You have to set a run number")
        sys.exit(1)

    if args.maketar is False and args.usetar is None:
        print ("you either have to set --maketar or provide --usetar value")
        sys.exit(1)

    if args.destination is None:
        srun = str(args.run).zfill(10)
        jobtag = "run%s"%srun

        destination = "/pnfs/dune/scratch/users/%s/merging/%s"%(os.getenv("USER"),jobtag)
    else:
        destination = args.destination

    if not os.path.exists(destination):
        print ("make a destination",destination)
        os.mkdir(destination)

    environs = ""
    environs = "-e CHUNK=%d "%args.chunk
    environs += "-e SKIP=%d "%args.skip
    environs += "-e RUN=%d "%args.run
    environs += "-e NFILES=%d "%args.nfiles
    environs += "-e DETECTOR=%s "%args.detector
    environs += "-e DATA_TIER=%s "%args.data_tier
    environs += "-e DESTINATION=%s "%destination
    environs += "-e USERNAME=%s "%os.getenv("USER")


    location = None
    if args.maketar:
        tmpdir = "/exp/dune/data/users/%s/tars"%(os.getenv("USER"))
        tardir = "/pnfs/dune/scratch/users/%s/tars"%(os.getenv("USER"))

        if not os.path.exists(tmpdir):
            os.mkdir(tmpdir)
        if not os.path.exists(tardir):
            os.mkdir(tardir)
        basedirname="."
        tag = "tarball-%s"%timeform()
        location = MakeTarball(tmpdir=tmpdir,tardir=tardir,tag = tag,basedirname=basedirname,debug=True)
        print (location)
    else:
        location = args.usetar

    if not os.path.exists("logs"):
        os.mkdir("logs")

    cmd = "cp remote.sh %d_remote.sh"%args.run
    os.system(cmd)

    cmd = "jobsub_submit "
    cmd += "--group dune "
    cmd += "--resource-provides=usage_model=DEDICATED,OPPORTUNISTIC "
    cmd += "--singularity-image /cvmfs/singularity.opensciencegrid.org/fermilab/fnal-wn-el9:latest "
    cmd += "--role=Analysis "
    cmd += "--expected-lifetime 4h "
    cmd += "--memory 2000MB "
    cmd += "--tar_file_name dropbox://"+location+" "
    cmd += "--use-cvmfs-dropbox " 

    cmd += environs
    cmd += " file://%d_remote.sh"%args.run
    cmd += " >& logs/submit_%d_%s.log"%(args.run,timeform())
    print (cmd)
    try:
        os.system(cmd)
    except:
        print ("submission failed for some reason")



