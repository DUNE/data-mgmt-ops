"""metacat dupCounter

simple check for duplicates

returns count of files with same characteristics as this one

if not stored yet count=1 is bad

if already stored count=2 is bad

"""
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
import argparse

from metacat.webapi import MetaCatClient

mc_client = MetaCatClient(os.environ["METACAT_SERVER_URL"])

def dupCounter(parent=None,namespace=None,detector=None, appname=None,appversion=None,fcl=None,data_tier=None,data_stream=None,campaign=None,file_format=None,verbose=False):    
    ''' give a parent and info about this file, look for children and look for duplicates .  Can be done before file is created - depending on if this file is already stored count=1 or count>1 are bad'''

    
    # make a tag based on important criteria 
    tag = (namespace,detector,appname,appversion,fcl,data_tier,data_stream,campaign,file_format)
    if verbose: print (tag)
    p = parent
    parentmd = mc_client.get_file(did=parent,with_metadata=True,with_provenance=True)
    if verbose:
        print ("the parent, %s:%s"%(parentmd["namespace"],parentmd["name"]))
    children = parentmd["children"]
    if len(children) == 0:
        return 0

    if verbose:
        print ("had %d children"%len(children))
    
    count = 0

    for child in children:
        
        childmd = mc_client.get_file(fid=child["fid"],with_metadata=True,with_provenance=True)
        if verbose: print (childmd["name"])
        cm = childmd["metadata"]
        ctag = None
        if cm["dune.output_status"]!="confirmed":
            continue
        if cm["core.data_tier"] != data_tier:  # fast check
            if verbose: print ("different tier")
            continue

        try:
            ctag = (childmd["namespace"],
                    cm["core.run_type"],
                    cm["core.application.name"],
                    cm["core.application.version"],
                    cm["dune.config_file"],
                    cm["core.data_tier"],
                    cm["core.data_stream"],
                    cm["dune.campaign"],
                    cm["core.file_format"])
        except:
            ctag = None
            print ("could not make tag")
            continue
        if (verbose):
            print("%s:%s"%(childmd["namespace"],childmd["name"]))
            print("ctag",ctag)
            print(" tag",tag)
        if ctag == tag:
            if verbose: print ("found duplicate",count)
            count += 1

    return count 

def checkFromMD(parent=None,md=None,verbose=False):
    ' use this if you have metadata for the file already'
    cm = md["metadata"]
    return dupCounter(parent,namespace=md["namespace"],
                      detector=cm["core.run_type"],
                    appversion=cm["core.application.version"],
                    appname=cm["core.application.name"],
                    fcl = cm["dune.config_file"],
                    data_tier=cm["core.data_tier"],
                    data_stream=cm["core.data_stream"],
                    campaign=cm["dune.campaign"],
                    file_format=cm["core.file_format"],
                    verbose=verbose)

if __name__ == "__main__":
    ' a test '
    parser = argparse.ArgumentParser(description='count duplicates for a proposed file configuration\n can take either file characteristics or draft metadata')
    parser.add_argument("--parent",help='name of parent file',type=str,default=None)
    parser.add_argument("--namespace",help='namespace for this file',type=str,default=None)
    parser.add_argument("--detector",help="detector ie. core.run_type",type=str,default=None)
    parser.add_argument("--appname",help='application name being run',type=str,default=None)
    parser.add_argument("--appversion",help='application version to run',type=str,default=None)
    parser.add_argument("--fcl",help='config file being run',type=str,default=None)
    parser.add_argument("--data_tier",help='data_tier for file',type=str,default=None)
    parser.add_argument("--data_stream",help='data_stream for file',type=str,default=None)
    parser.add_argument("--campaign",help='data_stream for file',type=str,default=None)
    parser.add_argument("--file_format",help='data_stream for file',type=str,default=None)
    parser.add_argument("--jsonfile",help='json with md to check alternate to doing all fields explicitly',type=str,default=None)
    parser.add_argument('--verbose',help='make very verbose',default=False,action='store_true')

    args = parser.parse_args()

    if args.parent==None:
        print ("must tell me the parent")
    
    if args.jsonfile == None:
        try:
            print (dupCounter(parent=args.parent,namespace=args.namespace,detector=args.detector,appname=args.appname,appversion=args.appversion,fcl=args.fcl,data_tier=args.data_tier,data_stream=args.data_stream,campaign=args.campaign,file_format=args.file_format,verbose=args.verbose))
        except Exception as e:
            print ("dupCounter check failed",e)
            print (-1)

    else:
        try:
            mdfile = open(args.jsonfile,'r')
            md = json.load(mdfile)
            mdfile.close()
            print (checkFromMD(parent=args.parent,md=md,verbose=args.verbose))
        except  Exception as e:
            print ("dupCounter check failed on json input",e)
            print (-1)

'''
# test code
export TESTFILE="hd-protodune-det-reco:np04hd_raw_run028049_0754_dataflow7_datawriter_0_20240718T054941_reco_stage1_reco_stage2_20240719T122841_keepup.root"
export TESTPARENT="hd-protodune:np04hd_raw_run028049_0754_dataflow7_datawriter_0_20240718T054941.hdf5"

metacat file show -m -l -j $TESTFILE>testfile.json

python dupCounter.py --parent=$TESTPARENT --namespace='hd-protodune-det-reco' --detector='hd-protodune' --appname=reco --appversion=v09_91_02d01 --fcl='standard_reco_stage2_calibration_protodunehd_keepup.fcl' --data_stream=physics --data_tier=full-reconstructed --campaign='hd-protodune-reco-keepup-v0' --file_format='artroot' --verbose

echo "-------------"

python dupCounter.py --parent=$TESTPARENT --jsonfile=testfile.json  
'''
    