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
    ' make a did from namespace and name'
    return "%s:%s"%(namespace,name)

def tagmaker(metadata=None):
    'make a tag from file metadata to tell what kind of file it is'
    fields = ["dune.campaign","core.data_tier"]
    # "core.application.name","core.data_tier","core.data_stream","dune.campaign","core.file_format"
    tag = ""
    for field in fields:
        tag += "%s__"%metadata[field]
    tag = tag[0:-2]
    return tag   

def jsondump(adict):
    'make a nice json formated string out of a dictionary'
    return json.dumps(adict,indent=4)          

def ChildNuker(myfid=None,children=None,verbose=False,fix=False,level=0):
    ' set up to recursively nuke all the children of a file, but not the file itself'
    level += 1
    success = True
    # expects children to be a list of child id's      
    if verbose:
        print (indent[level],"level",level,"%s had %d children"%(myfid,len(children)),children)
    if len(children) == 0:
        if verbose:
            print (indent[level],"ChildNuker found 0 children to nuke",myfid,success,0)
        return success
    count = 0
    for child in children:
        childfid = child["fid"]
        childmd = mc_client.get_file(fid=childfid,with_metadata=True,with_provenance=True)
        if "children" in childmd:
            grandchildren = childmd["children"]
            success *= ChildNuker(myfid=childfid,children=grandchildren, verbose=verbose, fix=fix,level=level)
        success *= NukeMe(myfid=childfid,verbose=verbose,fix=fix,level=level)
        if success:
            count += 0
    if verbose: 
        print (indent[level],"ChildNuker, children of",myfid,success,count)
    return success

def NukeMe(myfid=None,verbose=False,fix=False,level=0):
    'this code removes the file and cleans up parentage'
    if verbose:
        print (indent[level],"Start nuking")
    success = True
    mymd = mc_client.get_file(fid=myfid,with_metadata=True,with_provenance=True)
    mytag = tagmaker(mymd["metadata"])
    if verbose:
        print (indent[level],"level",level,"plan to nuke ",myfid,mytag) 
    mydid = didmaker(mymd["namespace"],mymd["name"])
    children = mymd["children"]
    if len(children)>0:
        if verbose:
            print (indent[level],"level",level,"cannot nuke",myfid,"as it has children",children)
        if fix:        
            print ("have to declare this an error")
            success *= False
            return success
        # fix is not on so continue
        if verbose:
            print(" since in test mode, continue")
        success *= True
    else:
        success *= True
    # do whatever it takes to remove this child
    if verbose:
        print (indent[level],"level", level, "Nuking", myfid, mytag)
    success *= ActualNuke(myfid=myfid,verbose=verbose,fix=fix,level=level)
    # then remove the parentage
    if success: 
        success *= RemoveMeFromParents(myfid=myfid,verbose=verbose,fix=fix,level=level)
    if verbose:
        print (indent[level],"NukeMe: have finished nuking",myfid,success)
    return success

def ActualNuke(myfid=None,verbose=False,fix=False,level=-1):
    'this does the actual file removal but does not fix parentage'
    if fix:
        print (indent[level],"this is where you would code the removal of ",myfid)
    else:
        print (indent[level],"this is where you would remove",myfid, "if fix were true")
    success = True
    if verbose:
        print (indent[level],"I have nuked",myfid,success)
    return success


def RemoveMeFromParents(myfid=None,verbose=False,fix=False,level=None):
    'this loops over parents, finds the sister files from each and deletes this file from the children list of all parents'
    success = True
    if verbose:
        print (indent[level],"level",level,"tell my parents",myfid)
    mymd = mc_client.get_file(fid=myfid,with_metadata=False, with_provenance=True)
    parents = mymd["parents"]
    if verbose:
        print ("parent of the file", parents)

    if len(parents) < 1:
        success *= True
        if verbose:
            print (indent[level],"RemoveMeFromParents showed no parents",myfid,success)
        return success
    
    for parent in parents:
        
        parentfid = parent["fid"]
        parentmd = mc_client.get_file(fid=parentfid,with_metadata=True, with_provenance=True)
        siblings = parentmd["children"]
        if verbose >1:
            print (indent[level],"level",level,"parent search",myfid,parentfid,tagmaker(parentmd["metadata"]))
        if verbose:
            print (indent[level],"level",level,"old siblings",siblings)
            
        if {"fid":myfid} in siblings:
            siblings.remove({"fid":myfid})
            if verbose:
                print (indent[level],"level",level,"new siblings",siblings)
            if fix:
                if verbose:
                    print (indent[level],"code parentage removal here")
            else:
                if verbose:
                    print (indent[level],"this is where you would fix the parentage if fix were set")
            success *= True
        else:
            if verbose:
                print (indent[level],"Found the parent",parentfid, " did not find myself", myfid,siblings)
            success *= False  

    if verbose:
        print (indent[level],"RemoveMeFromParents",myfid,success)
    return success

if __name__ == '__main__':

    filename = "fardet-vd:nu_dunevd10kt_1x8x6_3view_30deg_1244_30_20230802T144941Z_gen_g4_detsim_hitreco__20240220T223003Z_reco2.root"
    filename = "fardet-vd:anu_numu2nutau_nue2numu_dunevd10kt_1x8x6_3view_30deg_27392_61_20230813T102717Z_gen_g4_detsim_hitreco__20240222T225135Z_reco2.root"  # test with vd as it is more complicated

    nukeme = True  # this means nuke me as well as descendants
    # you can set this to false when testing on a top level file you want to keep. 
    fix = False 
    verbose = 2
    if len(sys.argv) < 3:
        print ("arguments are fid, test/run")
    else:    
        filename = sys.argv[1]
        fix = sys.argv[2] == "run"   

    if nukeme:
        print ("removing",filename,"and children in mode fix=",fix)
    else:
        print ("removing only children of ",filename," in mode fix=",fix)
    md = mc_client.get_file(did=filename,with_metadata=True,with_provenance=True)
    myfid = md["fid"]
    mytag = tagmaker(md["metadata"])
    level = 0 
    if "children" in md:
        children = md["children"]
        if verbose:
            print (indent[level],"level",level,"try to nuke children of",myfid,mytag)
        status = ChildNuker(myfid=myfid,children=children,verbose=verbose,fix=fix,level=level)   


    # do myself

    if nukeme:
        if verbose:
            print ("start to remove top level file", myfid)
        status = NukeMe(myfid=myfid,verbose=verbose,fix=fix,level=level)
