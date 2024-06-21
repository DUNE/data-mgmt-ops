import os
from subprocess import call
from metacat.webapi import MetaCatClient
from mergeMetaCat import run_merge
import shutil


mc_client = MetaCatClient(os.environ["METACAT_SERVER_URL"])

def doit():
    run_merge(newfilename=args.fileName, newnamespace = args.nameSpace, datatier=args.dataTier, application=None, version=None, flist=None, do_sort=True, merge_type="metacat", user=os.getenv("USER"), debug=False)

def makeFake(fake="fake.root",list=None,path=None):
    locations=[]
    for x in list:
        name = x.split(":")[1]
        shutil.copy(fake, os.path.join(path,name))
        locations.append(os.path.join(path,name))
    return locations


def mergeData(newpath,input_files):
    args = ["hadd", "-f", newpath] + input_files
    retcode = call(args)
    if retcode != 0:
        print("Error from hadd!")
        exit(retcode)
    

if __name__ == "__main__":

    test = True
    
    query = "files where dune.workflow['workflow_id']=2362 and core.data_tier=root-tuple"
    alist = list(mc_client.query(query=query))
    flist = []
    for file in alist:
        thedid = "%s:%s"%(file["namespace"],file["name"])
        flist.append(thedid)
    print (flist)
    if test:
       locations =  makeFake(os.path.join(os.getenv("TMP"),"fake.root"),flist,os.getenv("TMP"))
    else:
        "need to use rucio to find"
        locations = []
    print (locations)
    newfile = "tmp.root"
    retcode = mergeData(newfile,locations)

    #print (thelist)
    theinfo = mc_client.query(query=query,summary="count")
    print (theinfo)
    retcode = run_merge(newfilename=newfile, newnamespace=os.getenv("USER"), datatier="root-tuple", application="merge_root", version="v0", flist=flist, merge_type="metacat", do_sort=0, user='', debug=False)
    

    