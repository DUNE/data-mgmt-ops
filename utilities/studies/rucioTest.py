import os,sys
from subprocess import call,run
from metacat.webapi import MetaCatClient
from mergeMetaCat import run_merge
from rucio.client.replicaclient import ReplicaClient
from rucio.client.didclient import DIDClient
from rucio.common.exception import DataIdentifierNotFound, DataIdentifierAlreadyExists, FileAlreadyExists, DuplicateRule, RucioException


scope = "hd-protodune-det-reco"
name = "np04hd_raw_run027335_0186_dataflow3_datawriter_0_20240621T061753_reco_stage1_20240630T215824_keepup_hists.root"

rucio_list = [{"scope":scope,"name":name}]

# Check we can talk to Rucio
try:
    replica_client = ReplicaClient()
except Exception as e:
    print("Connect to Rucio fails with: " + str(e), file=sys.stderr)

try:
    result = list(replica_client.list_replicas(rucio_list))
except Exception as e:
    result = None
    print('--- Rucio list_replicas call fails: ' + str(e))

print ("rucio",list(result))

results = list(result)

print (results)

locations = []
for item in results:
    print ("\n results",item)
   
    for x,y in item["pfns"].items():
        locations.append(x)
        for z in y:
            print ("\n pfn",x,y,z)

print (locations)

for file in locations:
    cp_args = ["xrdcp",file,"./cache/."]
    completed_process = run(cp_args, capture_output=True,text=True)   
    print (completed_process)