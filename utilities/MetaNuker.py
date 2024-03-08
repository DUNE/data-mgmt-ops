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

indent = ["", "     ", "            ", "                   "]
def didmaker(namespace=None,name=None):
    return "%s:%s"%(namespace,name)

def tagmaker(metadata=None):
    fields = ["dune.campaign","core.data_tier"]
    # "core.application.name","core.data_tier","core.data_stream","dune.campaign","core.file_format"
    tag = ""
    for field in fields:
        tag += "%s__"%metadata[field]
    tag = tag[0:-2]
    #print (tag)
    return tag   

def jsondump(adict):
    return json.dumps(adict,indent=4)          

def ChildNuker(myfid=None,children=[],verbose=False,fix=False,level=0):
    ' set up to recursively nuke all the children of a file, but not the file itself'
    level += 1
    success = True
    # expects children to be a list of child id's      
    if verbose:
        print (indent[level],"level",level,"%s had %d children"%(myfid,len(children)),children)
    if len(children) == 0:
        print (indent[level],"ChildNuker found 0 children to nuke",myfid,success,0)
        return success
    count = 0
    for child in children:
        #print ("child",jsondump(child))
        childfid = child["fid"]
        childmd = mc_client.get_file(fid=childfid,with_metadata=True,with_provenance=True)
        childdid = didmaker(childmd["namespace"],childmd["name"])
        # if verbose:
        #     print ("level ",level,", child is",child["fid"],childdid)
        if "children" in childmd:
            grandchildren = childmd["children"]
            success *= ChildNuker(myfid=childfid,children=grandchildren, verbose=verbose, fix=fix,level=level)
        success *= NukeMe(myfid=childfid,verbose=verbose,fix=fix,level=level)
        if success:
            count += 0
    print (indent[level],"ChildNuker, children of",myfid,success,count)
    return success

def NukeMe(myfid=None,verbose=False,fix=False,level=0):
    success = True
    mymd = mc_client.get_file(fid=myfid,with_metadata=True,with_provenance=True)
    mytag = tagmaker(mymd["metadata"])
    print (indent[level],"level",level,"plan to nuke ",myfid,mytag) 
    mydid = didmaker(mymd["namespace"],mymd["name"])
    children = mymd["children"]
    if len(children)>0:

        print (indent[level],"level",level,"cannot nuke",myfid,"as it has children",children)
        if fix:
            success *= False
            return success
        else:
            print(" since in test mode, continue")
            success *= True
    else:
        success *= True
    # do whatever it takes to remove this child
    print (indent[level],"level", level, "Nuking", myfid, mytag)
    success *= ActualNuke(myfid=myfid,verbose=verbose,fix=fix,level=level)
    # then remove the parentage
    if success: 
        RemoveMeFromParents(myfid=myfid,level=level)
    print (indent[level],"NukeMe: have finished nuking",myfid,success)
    return success

def ActualNuke(myfid=None,verbose=False,fix=False,level=-1):
    print (indent[level],"this is where you would code the removal of ",myfid)
    success = True
    print (indent[level],"I have nuked",myfid,success)
    return success


def RemoveMeFromParents(myfid=None,level=None):
    success = True
    print (indent[level],"level",level,"tell my parents",myfid)
    mymd = mc_client.get_file(fid=myfid,with_metadata=False, with_provenance=True)
    parents = mymd["parents"]
    if len(parents) < 1:
        print (indent[level],"level",level,myfid," had no parents")
        success *= True
        print (indent[level],"RemoveMeFromParents",myfid,success)
        return success
    for parent in parents:
        
        parentfid = parent["fid"]
        parentmd = mc_client.get_file(fid=parentfid,with_metadata=True, with_provenance=True)
        
        siblings = parentmd["children"]
        print (indent[level],"level",level,"parent search",myfid,parentfid,tagmaker(parentmd["metadata"]))
        print (indent[level],"level",level,"old siblings",siblings)
        if {"fid":myfid} in siblings:
            #print ("Found the parent",parentfid, " did find myself", myfid,siblings)
            #print ("level",level,"want to remove",{"fid":myfid},"from",siblings)
            siblings.remove({"fid":myfid})
            print (indent[level],"level",level,"new siblings",siblings)
            print (indent[level],"this is where you would fix the parentage")
            success *= True
        else:
            print (indent[level],"Found the parent",parentfid, " did not find myself", myfid,siblings)
            success *= False
    


    # here is where you fix the parentage
    print (indent[level],"RemoveMeFromParents",myfid,success)
    return success

if __name__ == '__main__':

    filename = "fardet-vd:nu_dunevd10kt_1x8x6_3view_30deg_1237_60_20230802T013411Z_gen_g4_detsim_hitreco.root"

    nukeme = False
    fix = "test"
    verbose = True
    if len(sys.argv) < 3:
        print ("arguments are fid, test/run")
    else:    
        filename = sys.argv[1]
        fix = sys.argv[2]   

    md = mc_client.get_file(did=filename,with_metadata=True,with_provenance=True)
    myfid = md["fid"]
    mytag = tagmaker(md["metadata"])
    level = 0 
    if "children" in md:
        children = md["children"]
        print (indent[level],"level",level,"try to nuke children of",myfid,mytag)
        status = ChildNuker(myfid=myfid,children=children,verbose=verbose,fix=fix,level=level)   


    # do myself

    if nukeme:
        status = NukeMe(myfid=myfid,verbose=False,fix=False,level=0)





            
            

