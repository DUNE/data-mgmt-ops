''' tester for FileChecker for one file - gets md from metacat'''
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

from metacat.webapi import MetaCatClient

if __name__ == '__main__':
    
    mc_client = MetaCatClient(os.getenv("METACAT_SERVER_URL"))
    if len(sys.argv) < 2:
        print ("need a namespace:name as input")
    else:
        thedid = sys.argv[1]

    
    now = "%10.0f"%datetime.datetime.now().timestamp()
    errname = ("%s_%s.txt"%(thedid,now)).replace(":","__")
    print (errname)
    errfile = open(errname,'w')
    try:
        filemd = mc_client.get_file(did=thedid,with_metadata=True,with_provenance=True)
    except:
        print (" attempt to get metadata failed for ", thedid)
    status = TypeChecker(filemd=filemd,errfile=errfile,verbose=False)
    
    errfile.close()

