''' tester for one file from each dataset '''
##
# @mainpage FileChecker
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

from TypeChecker import TypeChecker

import TimeUtil

from metacat.webapi import MetaCatClient

import sam2metacat

if __name__ == '__main__':
    
    mc_client = MetaCatClient(os.getenv("METACAT_SERVER_URL"))
    #if len(sys.argv) < 2:
    #    print ("need a namespace:name as input")
    #else:
    #    thedid = sys.argv[1]

    datasets = list(mc_client.list_datasets())
    
    checks = 0
    for dataset in list(datasets):
        if dataset["created_timestamp"] < TimeUtil.utcdate_to_unix("2024-01-01"): continue
        if checks > 50: break
        ddid = "%s:%s"%(dataset["namespace"],dataset["name"])
        #if "usertests" not in ddid: continue
        #if dataset["created_timestamp"] < 1716381522.181642: continue
        
        query = "files from %s:%s where core.file_type=mc and core.data_tier=full-reconstructed and created_timestamp>2024-01-01 limit 1"%(dataset["namespace"],dataset["name"])
        
        
        try:
            files = list(mc_client.query(query))
        except:
            print("query failed")
            continue
        if len(list(files)) < 1: 
            #print ("empty dataset")
            continue
        checks += 1
        thefile = files[0]["namespace"]+":"+files[0]["name"]
        print (query)
        #metadata = mc_client.get_file(thefile,with_metadata=True,with_provenance=True)
        try:
            diffs = sam2metacat.check(thefile)
        except:
            print ('metacat check failed')
        continue
        print (thefile)
        now = "%10.0f"%datetime.datetime.now().timestamp()
        errname = ("%s_%s.txt"%(ddid,now)).replace(":","__")
        # print (errname)
        errfile = open(errname,'w')
        errfile.write(thefile+"\n")
        try:
            filemd = mc_client.get_file(did=thefile,with_metadata=True,with_provenance=True)
        except:
            print (" attempt to get metadata failed for ", thedid)
        
        status,fixes = TypeChecker(filemd=filemd,errfile=errfile,verbose=False)
        
        errfile.close()

