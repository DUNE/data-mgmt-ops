"""metacat MetaFixer

evaluate and fix metacat for files

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


#import samweb_client



from metacat.webapi import MetaCatClient

from TypeChecker import TypeChecker

DEBUG = False

mc_client = MetaCatClient(os.getenv("METACAT_SERVER_URL"))


class MetaFixer:
    ''' Class to check and fix metadata'''

    def __init__(self,verbose=False,errname="error.txt",tests=None,fix=None):
        ''' 
        __init__ initialization, does very little

        :param verbose: print out a lot of things

        '''
        self.query_files=None
        self.verbose = verbose
        self.fix=fix
        self.limit=1000000
        self.skip=0
        self.errfile=open(errname,'w')
        self.errfile.write(errname+"\n")
        self.tests=tests

    
    

    def getInput(self,query=None,limit=10000000,skip=0):
        ''' 
        get a query and return a list of did's
        '''
        self.skip = skip
        self.limit = limit
        thequery = query + " skip %d limit %d "%(self.skip,self.limit)

        print ("thequery:",thequery)
        try:
            self.query_files = list(mc_client.query(thequery))
            print ("getinput returned:",len(self.query_files), "files") 
        except:
            print("metacat query ", thequery, " failed")
            sys.exit(0)
        
        return self.query_files
    
    def explore(self):
        " see what there is in a general query "

        
        if not os.path.exists("metadata"):
             #this explores and counts things'
            os.mkdir("metadata")
       
        datatypes = ["core.data_tier","core.run_type","dune.campaign","dune_mc.gen_fcl_filename","core.application","dune.requestid"]
        typecount = {}
        for datatype in datatypes:
            typecount[datatype]={}
        typecount["namespace"]={}
        count = self.skip
        for file in self.query_files :
            count += 1
            #if self.verbose:print (file)
            thedid = "%s:%s"%(file["namespace"],file["name"])

            if count%10 == 0 and self.verbose:
                print (count, thedid)
            try:
                md = mc_client.get_file(did=thedid,with_metadata=True,with_provenance=True)
            except:
                print ("failed at file",count,thedid)
                break
            
            self.checker(md)

    def checker(self, filemd=None):
        ' check various aspects of the file '
        did = "%s:%s"%(filemd["namespace"],filemd["name"])
        for check in self.tests:
            if check == "duplicates":
                self.dupfinder(filemd=filemd)
            if check == "parentage":
                self.parentfixer(filemd)
            if check == "types":
                status = TypeChecker(filemd)
                print ("result of type check",filemd["name"],status)

    def parentfixer(self, filemd=None,check="parentage"):
        ' check parentage of the file '
        did = "%s:%s"%(filemd["namespace"],filemd["name"])
        status = "good"
        if "parents" in filemd and len(filemd["parents"])> 0:
            # has some parentage, look at it. 
            parents = filemd["parents"]
            if self.verbose:
                print ("parents",parents)
                for p in parents:
                    parentmd = mc_client.get_file(fid=p["fid"])
                    if self.verbose:
                        print(parentmd["namespace"],parentmd["name"],jsondump(p))
                    self.errfile.write("%s, parentage ok\n"%did)
            return status
        else: # no parents found
            metadata = filemd["metadata"]
            if "core.parents" in metadata:
                parentlist = []
                if self.verbose:
                    print ("core.parents", metadata["core.parents"])
                for p in metadata["core.parents"]:
                    if ":" in p["file_name"]:
                        #if self.verbose:
                            
                        self.errfile.write("%s, missing parents\n"%did)
                        thisparent = {"did":p["file_name"]}
                        
                    else:
                        if self.verbose:
                            print ("ERROR missing namespace for parent in  this file",did)
                        self.errfile.write("%s, missing namespace in parents\n"%did)
                        thisparent = {"did":"%s:%s"%(filemd["namespace"],p["file_name"])}  # hack in namespace of child file
                    parentlist.append(thisparent)
                
                print ("parents to add",parentlist)
                if self.fix:
                    print ("Tried to fix this file", did)
                    try:
                        mc_client.update_file(did,  parents=parentlist)
                        print ("fix succeeded")
                        self.errfile.write("%s, fixed it\n"%did)
                    except:
                        print ("fix failed")
                        self.errfile.write("%s, failed to fix \n"%did)
                        status = "fail"
                        return status

            else:
                self.errfile.write("%s, no parents or core.parents\n"%did)
        return status

    

    def dupfinder(self,filemd=None):
        ' loop over parents, look for children and look for duplicates'
        thedid = "%s:%s"%(filemd["namespace"],filemd["name"])
        md = filemd["metadata"]
        tag = "%s_%s_%s_%s_%s_%s_%s"%(filemd["namespace"],md["core.application.version"],md["core.application.name"],md["core.data_tier"],md["core.data_stream"],md["dune.campaign"],md["core.file_format"])
        if self.verbose:
            print ("---------------------------\n")
            print ("thefile",thedid)
        if "parents" in filemd and len(filemd["parents"])> 0:
            # has some parentage, look at it. 
            parents = filemd["parents"]
            for p in parents:
                parentmd = mc_client.get_file(fid=p["fid"],with_metadata=True,with_provenance=True)
                if self.verbose:
                    print ("the parent, %s:%s"%(parentmd["namespace"],parentmd["name"]))
                children = parentmd["children"]
                if len(children) == 0:
                    message = "%s, ERROR no children\n"%(thedid)
                    self.errfile.write(message)
                    print (message)
                if self.verbose:
                    print ("had %d children"%len(children))
                if len(children) == 1:
                    continue
                count = 0
                for child in children:
                    
                    childmd = mc_client.get_file(fid=child["fid"],with_metadata=True,with_provenance=True)
                    cm = childmd["metadata"]
                    childdid = "%s:%s"%(childmd["namespace"],childmd["name"])
                    if childdid == thedid:
                        continue
                    #print ("child", jsondump(childmd))
                    ctag = "BAD"
                    try:
                        ctag = "%s_%s_%s_%s_%s_%s_%s"%(childmd["namespace"],cm["core.application.version"],md["core.application.name"],cm["core.data_tier"],cm["core.data_stream"],cm["dune.campaign"],cm["core.file_format"])
                    except:
                        error = "%s, ERROR ctag couldn't be made %s\n"%(thedid,childdid)
                        self.errfile.write(error)
                        continue
                    
                    #print (childdid)
                    if ctag == tag:
                        count += 1
                        
                        if count > 0:
                            message = "%s, ERROR duplicate file %d, %s %s\n"%(thedid,count, childdid,ctag)
                            print (message)
                            self.errfile.write(message)

                
        



    def cleanup(self):
        ' make certain the output errorfile is closed'
        self.errfile.close()
                            
def jsondump(adict):
    ' dump a dictionary to a nicely formatted string'
    return json.dumps(adict,indent=4)                   

def parentchecker(query):
    ' build the complicated parent query -- it is very slow '
    newquery = " %s - children(parents(%s))"%(query,query)
    return newquery





                    
if __name__ == '__main__':

    data_tier = "full-reconstructed"
    workflow = 1630
    FIX = False
    TESTME = False
    tests = ["types","parentage"]
    if len(sys.argv) < 2:
        print ("normally should add a data_tier, and workflow #, default to %s, %s"%(data_tier, workflow))
        print ("to actually run, the 3rd argument needs to be run '")
    else:
        data_tier = sys.argv[1]          
        workflow = int(sys.argv[2])   
    if len(sys.argv) > 3:
        if sys.argv[3] == "run":
            FIX = True  
        if sys.argv[3] == "test":
            TESTME = True

    #for workflow in [1638,1650]:
    hd = [1630,1631,1632,1650,1638,1633,1596,1597,1598,1599,1600,1601,1602,1604,1606,1608,1609,1581,1582,1584,1594,1586,1587,1588,1595]
    vd = [1583,1590,1591,1593] + list(range(1610,1630))

          
    for workflow in [1781]:

        testquery = ""
        if  "parentage" in tests:
            testquery =  "files from dune:all where core.data_tier='%s' and dune.workflow['workflow_id'] in (%d) "%(data_tier,workflow)
        print ("top level query metacat query \" ",testquery, "\"")
        if "duplicates" in tests:

            testquery =  "files from dune:all where core.data_tier='%s' and dune.workflow['workflow_id'] in (%d)"%(data_tier,workflow)

        if TESTME:
            testquery += " limit 100"
        print (testquery)

        #parentquery = (parentchecker(testquery))
        #print ("parent checker",parentquery)
        summary = mc_client.query(query=testquery,summary="count")
        #checksummary = mc_client.query(query=parentquery,summary="count")
        print ("summary of testquery", summary)#, checksummary)
        # if 0 == checksummary["count"]:
        #     print ("you seem to have parents for all files - quitting")
        #     sys.exit(0)
        now = "%10.0f"%datetime.datetime.now().timestamp()

        fixer=MetaFixer(verbose=False,errname="%s_%d_%s.txt"%(data_tier,workflow,now),tests=tests, fix=FIX)
        thelimit=100
        theskip=0
        for i in range(0, thelimit):
            thelist = fixer.getInput(query=testquery,limit=thelimit,skip=theskip)
            if len(thelist) == 0:
                print ("got to the end of the list at ",theskip)
                break
            fixer.explore()
            if len(thelist) <= 0:
                print ("readed end of list at",theskip)   
            theskip += thelimit
        fixer.cleanup() 

