''' find datasets files from a query are in'''
##
# @mainpage FileFinfer
#
# @section description_main
#
#  
# @file FileChecker.py

# pylint: disable=C0303
# pylint: disable=C0321 
# pylint: disable=C0301  
# pylint: disable=C0209
# pylint: disable=C0103 
# pylint: disable=C0325 
# pylint: disable=C0123
# pyline: disable=W1514


# need to implement this
#from argparse import ArgumentParser as ap

import sys
import os
import json
import datetime

from metacat.webapi import MetaCatClient
mc_client = MetaCatClient(os.environ["METACAT_SERVER_URL"])

# from rucio.client.replicaclient import ReplicaClient
# from rucio.client.didclient import DIDClient
# from rucio.common.exception import DataIdentifierNotFound, DataIdentifierAlreadyExists, FileAlreadyExists, DuplicateRule, RucioException

#replica_client = ReplicaClient()

debug = False

def FileDatasetFinder(fid):
    result = mc_client.get_file(fid = fid, with_datasets=True)
    return result["datasets"]

# def FileRucioFinder(namespace,name):
#     debug = True
#     print ("Rucio",namespace,name)
#     rucio_list = [{"scope":namespace,"name":name}]
#     try:
#         result = list(replica_client.list_replicas(rucio_list))
#     except Exception as e:
#         result = None
#         print('--- Rucio list_replicas call fails: ' + str(e))
#         return None

#     if debug: print ("rucio",list(result))

#     results = list(result)

#     locations = []
#     for item in results:
#         print ("\n results",item)
    
#         for x,y in item["pfns"].items():
#             locations.append(x)
#             for z in y:
#                 print ("\n pfn",x,y,z)

#     print (locations)

def DataSetFinder(files):
    datasets = []
    for file in files:
        if debug: print(file)        
        thesets = FileDatasetFinder(file["fid"])
        for set in thesets:
            if set not in datasets:
                if debug:print ("new set",set)
                datasets.append(set)
    
    print ("-----results------")
    setlist = []
    for set in datasets:
        did = "%s:%s"%(set["namespace"],set["name"])
        if debug:print ("%s:%s"%(set["namespace"],set["name"]))
        setlist.append(did)
    return setlist

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print (" please enter a metacat query in quotes")
    query = sys.argv[1]
    
    
    result = mc_client.query(query) 
    files = list(result)
    datasets = DataSetFinder(files)
    # for file in files:
    #     print (file)
    #     test = FileRucioFinder(name=file["name"],namespace=file["namespace"])

    for set in datasets:
        print (set)

