##
# @mainpage MetaFixer
#
# @section description_main
#
#  
# @file MetaFixer.py

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


#import samweb_client



from metacat.webapi import MetaCatClient

import MetaFixer

if __name__ == '__main__':
    FIX = False
    tests = ["types","parentage"]
    mc_client = MetaCatClient(os.getenv("METACAT_SERVER_URL"))
    if len(sys.argv) < 2:
        print ("need a namespace:name as input")
    else:
        thedid = sys.argv[1]

    
    now = "%10.0f"%datetime.datetime.now().timestamp()
    errname = ("%s_%s.txt"%(thedid,now)).replace(":","__")
    print (errname)
    fixer=MetaFixer.MetaFixer(verbose=False,errname=errname,tests=tests, fix=FIX)

    filemd = mc_client.get_file(did=thedid,with_metadata=True,with_provenance=True)

    fixer.checker(filemd)        
        
    fixer.cleanup() 


