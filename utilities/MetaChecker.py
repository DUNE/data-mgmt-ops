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
    '''returns a string from a dict to print'''
    return json.dumps(adict,indent=4)                   

def parentchecker(query):
    ' code the complex search for files without parents'
    newquery = " %s - children(parents(%s))"%(query,query)
    return newquery

PARENTS = False
CONFIRM = True
Tests = {"PARENTS":False,"CONFIRM":False}
if len(sys.argv) > 1 and sys.argv[1] == "parents":
    Tests["PARENTS"] = True
if len(sys.argv) > 1 and sys.argv[1] == "confirm":
    Tests["CONFIRM"] = True

hd = [1650,1638,1630,1631,1632,1633,1596,1597,1598,1599,1600,1601,1602,1604,1606,1608,1609,1581,1582,1584,1594,1586,1587,1588,1595]
vd = [1583,1590,1591,1593] + list(range(1610,1630))



for workflow in range(1775,1782):
  
    for data_tier in ["full-reconstructed","root-tuple-virtual","pandora-info"]:
        #if data_tier != "full-reconstructed": continue
        testquery="files from dune:all where core.data_tier='%s' and dune.workflow['workflow_id'] in (%d)   "%(data_tier,workflow)
        print (testquery)
        try:
            testsummary = mc_client.query(query=testquery,summary="count")
        except:
            print ("bummer - that query failed - may want to report")
            testsummary = None
        print ("check on  workflow ",workflow,data_tier)
        print ("summary of all files",testsummary)

        # note this take FOREVER so have option to turn it off. 

        if testsummary["count"] < 1:
            print (" no files found, go to next step")

        if Tests["PARENTS"]:
            parentquery=parentchecker(testquery)
            print (parentquery)
            try:
                checksummary= mc_client.query(query=parentquery,summary="count")
            except:
                print ("bummer - that query failed - may want to report")
                checksummary = None
            print ("summary of files missing parentage",checksummary)
        if Tests["CONFIRM"]:
            confirm = testquery + "and dune.output_status!=confirmed"
            print (confirm)
            try:
                checksummary= mc_client.query(query=confirm,summary="count")
            except:
                print ("bummer - that query failed - may want to report")
                checksummary = None
            print ("summary of files not confirmed",checksummary)
            if checksummary != None and  checksummary["count"] != 0:
                f = open("confirm_%d_%s.txt"%(workflow,data_tier),'w')

                files = mc_client.query(query=confirm)
                for file in files:
                    thedid = "%s:%s"%(file["namespace"],file["name"])
                    line = "%s , unconfirmed store\n"%(thedid)
                    f.write(line)


    
