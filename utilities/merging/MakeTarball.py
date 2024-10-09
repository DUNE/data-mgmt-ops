# Define function to create tarball


import os,sys,time,datetime

def timeform():
  now = datetime.datetime.now()
  timeFormat = "%Y%m%d%H%M%S"
  nowtime = now.strftime(timeFormat)
  return nowtime

def MakeTarball(tmpdir=None,tardir=None,tag=None,basedirname=None,debug=False):

    found = os.path.isfile("%s/myareatar_%s.tar.gz"%(tardir,tag))

    if(not found):
        #cmd = "tar -czf /exp/minerva/app/users/$USER/myareatar_%s.tar.gz %s"%(tag,basedir)
        if debug: print (" in directory",os.getcwd())
        tarname = "myareatar_%s.tar.gz"%(tag)
        tarpath = os.path.join(tmpdir,tarname)
        cmd = "tar --exclude={*.git,*.png,*.pdf,*.gif,*.csv,*.root,*.tbz2,*.log,*.job,*.json,*.failure} -zcf  %s %s"%(tarpath,basedirname)

        if debug: print ("Making tar",cmd)
        os.system(cmd)
        
        cmd2 = "xrdcp %s %s/"%(tarpath,tardir)
        
        if debug: print ("Copying tar",cmd2)

        os.system(cmd2)

        cmd = "rm %s "%(tarpath)
        
        if debug: print ("removing tar",tarpath)

        os.system(cmd2)

        return os.path.join(tardir,tarname)
    
if __name__ == "__main__":
    tmpdir = "/exp/dune/data/users/%s/tars"%(os.getenv("USER"))
    tardir = "/pnfs/dune/scratch/users/%s/tars"%(os.getenv("USER"))

    #tmpdir = "/Users/schellma/tmp/tars"
    #tardir = "/Users/schellma/data/tars"
    if not os.path.exists(tmpdir):
        os.mkdir(tmpdir)
    if not os.path.exists(tardir):
        os.mkdir(tardir)
    basedirname="."
    tag = "tarball-%s"%timeform()
    
    location = MakeTarball(tmpdir=tmpdir,tardir=tardir,tag = tag,basedirname=basedirname,debug=True)
    print ("export TARFILE=%s"%location)