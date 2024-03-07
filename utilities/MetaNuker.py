"""metacat MetaNuker

kill a file and all of its children, remove from children list of its parent. 

"""
##
# @mainpage MetaNuker
#
# @section description_main
#
#  
# @file MetaNukerpy

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

def didmaker(namespace=None,name=None):
    return "%s:%s"%(namespace,name)

def jsondump(adict):
    return json.dumps(adict,indent=4)          

def ChildNuker(parentfid=None,children=[],verbose=False,fix=False,level=0):
    level += 1
    # expects children to be a list of child id's      
    if verbose:
        print ("level %d, %s had %d children"%(level, parentfid,len(children)))
    if len(children) == 0:
        return 0
    count = 0
    thefid = parentfid
    for child in children:
        #print ("child",jsondump(child))
        childfid = child["fid"]
        childmd = mc_client.get_file(fid=childfid,with_metadata=True,with_provenance=True)
        childdid = didmaker(childmd["namespace"],childmd["name"])
        if verbose:
            print ("level ",level,", child is",child["fid"],childdid)
        if "children" in childmd:
            grandchildren = childmd["children"]
            check = ChildNuker(parentfid=childfid,children=grandchildren, verbose=verbose, fix=fix,level=level)
        

        NukeChild(parentfid=thefid,childfid=childfid,verbose=verbose,fix=fix,level=level)
        count += 0
    return count

def NukeChild(parentfid = None, childfid=None,verbose=False,fix=False,level=None):
    print ("level",level,", plan to nuke ",childfid,"and fix parentage in",parentfid)
    childmd = mc_client.get_file(fid=childfid,with_metadata=True,with_provenance=True)
    childdid = didmaker(childmd["namespace"],md["name"])
    childtier = childmd["metadata"]["core.data_tier"]
    grandchildren = childmd["children"]
    if len(grandchildren)>0:
        print ("level",level,"cannot nuke",childfid,"as it has children",grandchildren)
        sys.exit(1)
    # do whatever it takes to remove this child
    print ("Nuking ", childdid,childtier)
    RemoveFromParent(parentfid,childfid)

def RemoveFromParent(parentfid=None,childfid=None):
    parentmd = mc_client.get_file(fid=parentfid,with_metadata=False, with_provenance=True)
    ancestry= parentmd["children"]
    if childfid in ancestry:
        print ("Found the parent",parentfid, " found myself", childfid)
        print (ancestry)

    # here is where you fix the parentage


filename = "fardet-hd:nu_dune10kt_1x2x6_1412_336_20230826T153311Z_gen_g4_detsim_hitreco__20240222T221256Z_reco2.root"
fix = "test"
verbose = True
if len(sys.argv) < 3:
    print ("arguments are fid, test/run")
else:    
    filename = sys.argv[1]
    fix = sys.argv[2]   

md = mc_client.get_file(did=filename,with_metadata=False,with_provenance=True)
myfid = md["fid"]

if "children" in md:
    children = md["children"]
    print (myfid,filename,children)
    ChildNuker(parentfid=myfid,children=children,verbose=verbose,fix=fix,level=0)   



myparents = md["parents"]


        
        

