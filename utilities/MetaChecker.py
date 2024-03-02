"""metacat MetaChecker"""
##
# @mainpage MetaChecker
#
# @section description_main
#
#  
# @file MetaChecker.py

# run checks to find files without parentage
# need to code in list of workflows or other things to check at line ~50

# if argument fast, will skip the parentage check 

# pylint: disable=C0303
# pylint: disable=C0321 
# pylint: disable=C0301  
# pylint: disable=C0209
# pylint: disable=C0103 
# pylint: disable=C0325 
# pylint: disable=C0123
# pyline: disable=W1514



from argparse import ArgumentParser as ap

import sys
import os
import json
import datetime


#import samweb_client



from metacat.webapi import MetaCatClient
# samweb = samweb_client.SAMWebClient(experiment='dune')

DEBUG = False

mc_client = MetaCatClient(os.getenv("METACAT_SERVER_URL"))

def jsondump(adict):
    return json.dumps(adict,indent=4)                   

def parentchecker(query):
    newquery = " %s - children(parents(%s))"%(query,query)
    return newquery

FAST = False
if len(sys.argv) > 1 and sys.argv[1] == "fast":
    FAST = True

for workflow in range(1500,1700) :
    for data_tier in ["full-reconstructed","root-tuple-virtual"]:
        #if data_tier != "full-reconstructed": continue
        testquery="files from dune:all where core.data_tier='%s' and core.run_type='fardet-vd' and dune.workflow['workflow_id'] in (%d) "%(data_tier,workflow)
        
        parentquery=parentchecker(testquery)
        testsummary = mc_client.query(query=testquery,summary="count")
        print ("check on  workflow ",workflow,data_tier)
        print ("summary of all files",testsummary)

        # note this take FOREVER so have option to turn it off. 
        if not FAST:
            checksummary= mc_client.query(query=parentquery,summary="count")
            print ("summary of files missing parentage",checksummary)

    
