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

def dupCounter(parent=None,namespace=None,appname=None,appversion=None,fcl=None,data_tier=None,data_stream=None,campaign=None,file_format=None,verbose=False):    
    ''' give a parent and info about this file, look for children and look for duplicates .  Can be done before file is created - depending on if this file is already stored count=1 or count>1 are bad'''

    
    # make a tag based on important criteria 
    tag = (namespace,appversion,appname,fcl,data_tier,data_stream,campaign,file_format)
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
        cm = childmd["metadata"]
        ctag = None
        if cm["core.data_tier"] != data_tier:  # fast check
            if verbose: print ("different tier")
            continue

        try:
            ctag = (childmd["namespace"],
                    cm["core.application.version"],
                    cm["core.application.name"],
                    cm["dune.config_file"],
                    cm["core.data_tier"],
                    cm["core.data_stream"],
                    cm["dune.campaign"],
                    cm["core.file_format"])
        except:
            ctag = None
            continue
        if (verbose):
            print("%s:%s",(childmd["namespace"],childmd["name"]))
            print(ctag)
            print(tag)
        if ctag == tag:
            count += 1

    return count 

def checkFromMD(parent=None,md=None,verbose=False):
    ' use this if you have metadata for the file already'
    cm = md["metadata"]
    return dupCounter(parent,namespace=md["namespace"],
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
    verbose=False
    test = "hd-protodune-det-reco:np04hd_raw_run028049_0754_dataflow7_datawriter_0_20240718T054941_reco_stage1_reco_stage2_20240719T122841_keepup.root"
    parent = "hd-protodune:np04hd_raw_run028049_0754_dataflow7_datawriter_0_20240718T054941.hdf5"
    
    mc_client = MetaCatClient(os.getenv("METACAT_SERVER_URL"))

    md = mc_client.get_file(did=test,with_metadata=True,with_provenance=True)

    cm = md["metadata"]
    print ("check = ", dupCounter(parent=parent,namespace=md["namespace"],
                    appversion=cm["core.application.version"],
                    appname=cm["core.application.name"],
                    fcl = cm["dune.config_file"],
                    data_tier=cm["core.data_tier"],
                    data_stream=cm["core.data_stream"],
                    campaign=cm["dune.campaign"],
                    file_format=cm["core.file_format"],
                    verbose=verbose))
    
    print ("md check",checkFromMD(parent,md,verbose=verbose))



