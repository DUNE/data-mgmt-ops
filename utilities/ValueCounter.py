# check for how many times various fields appear in metacat
import os,sys,time,datetime
from metacat.webapi import MetaCatClient
import json
import argparse
from statistics import mean
from TypeChecker import TypeChecker
import CheckSum

mc_client = MetaCatClient(os.environ["METACAT_SERVER_URL"])

types = ["data_streams","data_tiers","run_types","file_types","file_formats"]
types = ["file_formats"]
final = open("contents.txt",'w')
for t in types:
    f = open("textfiles/"+t,'r')
    values = f.readlines()
    
    for v in values:
         
        query = "files where core.%s=%s"%(t[:-1],v.strip())
        #print (query)
        theinfo = mc_client.query(query=query,summary="count")
        print (query,theinfo)
        final.write("%s, %s, %d, %10.2f\n"%(t[:-1],v.strip(),theinfo["count"],theinfo["total_size"]/1000/1000/1000.))
    f.close()
final.close()



