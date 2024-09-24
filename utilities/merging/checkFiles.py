import os,sys
from subprocess import call,run
from metacat.webapi import MetaCatClient
from mergeMetaCat import run_merge
from datetime import datetime, timezone
from ROOT import TFile
import argparse
import shutil
import json
from rucio.client.replicaclient import ReplicaClient
#from rucio.client.didclient import DIDClient
#from rucio.common.exception import DataIdentifierNotFound, DataIdentifierAlreadyExists, FileAlreadyExists, DuplicateRule, RucioException

def checkFile(filepath):
    f = 0
    try:
        f = TFile.Open(filepath,"READONLY")
        return True
    except Exception as e:
        print ("could not open",filepath,e)
        return False


mc_client = MetaCatClient(os.environ["METACAT_SERVER_URL"])
replica_client=ReplicaClient()

parser = argparse.ArgumentParser(description='check contents of a dataset')

parser.add_argument("--dataset",type=str, help="dataset", default=None)
parser.add_argument("--nfiles",type=int, help="number of files to check total",default=1000)
parser.add_argument("--skip",type=int, help="number of files to skip before doing nfiles",default=0)
parser.add_argument('--debug',help='make very verbose',default=False,action='store_true')


args = parser.parse_args()

debug = args.debug

query = "files from %s ordered skip %d limit %d"%(args.dataset,args.skip,args.nfiles)

alist = list(mc_client.query(query=query))
print ("this many files",len(alist))
flist = []

f = open("missed_%d_%d.txt"%(args.skip,args.nfiles),'w')
x = 0
locations = []
missed = []
good = 0
bad = 0
unreadable = 0
chunksize = 50
for chunk in range(0,int(len(alist)/chunksize)+1):
    print ("do a chunk from",chunk,x,x+chunksize)
    ruciolist = []
    for file in alist[x:x+chunksize]:
        
        ruciolist.append({"scope":file["namespace"],"name":file["name"]})
    x += chunksize
    try:
        result = list(replica_client.list_replicas(ruciolist)) # goes away if you don't grab it???
    except Exception as e:
        result = None
        print('--- Rucio list_replicas call fails: ' + str(e))
        print(' stop this chunk',args.skip)
        f.write("RUCIO FAIL: "+thedid+"\n")
        continue

    for file in result:
        did = file["scope"]+":"+file["name"]
        #print (did)
        pfns = file["pfns"]

        location = None

        goodsites = ["fnal"]
        for rse in pfns:
            if debug: print ("\n RSE",rse)
            goodsite = False
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
            bad += 1
            continue
        
        if not checkFile(location):  # can I open the file? 
            print ("BIG PROBLEM - cannot read file",location)
            missed.append(did)
            f.write(location+"\n")
            unreadable += 1
            continue

        locations.append(location)
        good += 1

    

print ("good=",good,"bad=", bad,"unreadable=",unreadable)
f.close()


