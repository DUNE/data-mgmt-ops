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


class MetaFixer:
    ''' Class to check and fix metadata'''

    def __init__(self,verbose=False,errname="error.txt",test=None,fix=None):
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
        self.test=test

    
    

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
            os.mkdir("metadata")
        " this explores and counts things"
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
            
            self.checker(md,test)

            value = file["namespace"]
            if value in typecount["namespace"]:
                typecount["namespace"][value] +=1
            else:
                typecount["namespace"][value]=1
                f = open("metadata/namepace.json",'w')
                data = json.dumps(md,indent=4)
                
                f.write(data)
                f.close()
                
                    
            #
            metadata = md["metadata"]
            for datatype in datatypes:
                if datatype in metadata.keys():
                    value = metadata[datatype]
                    if value in typecount[datatype]:
                        typecount[datatype][value] = typecount[datatype][value]+1
                    else:
                        typecount[datatype][value] = 1
        
                        f = open("metadata/"+datatype+"__"+value+".json",'w')
                        data = json.dumps(md,indent=4)
                        f.write(data)
                        f.close()
            
        if self.verbose:
            print(json.dumps(typecount,indent=4))

    def checker(self, filemd=None,check="parentage"):
        ' check various aspects of the file '
        did = "%s:%s"%(filemd["namespace"],filemd["name"])
        if check == "duplicates":
            self.dupfinder(filemd=filemd)
        if check == "parentage":
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
            else:
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

                else:
                    self.errfile.write("%s, no parents or core.parents\n"%did)

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
                    #print ("child", jsondump(childmd))
                    ctag = "%s_%s_%s_%s_%s_%s_%s"%(childmd["namespace"],cm["core.application.version"],md["core.application.name"],cm["core.data_tier"],cm["core.data_stream"],cm["dune.campaign"],cm["core.file_format"])

                    childdid = "%s:%s"%(childmd["namespace"],childmd["name"])
                    #print (childdid)
                    if ctag == tag:
                        count += 1
                        
                        if count > 1:
                            message = "%s, ERROR duplicate file %d, %s %s\n"%(thedid,count, childdid,ctag)
                            print (message)
                            self.errfile.write(message)

                
        



    def cleanup(self):
        self.errfile.close()
                            
def jsondump(adict):
    return json.dumps(adict,indent=4)                   

def parentchecker(query):
    newquery = " %s - children(parents(%s))"%(query,query)
    return newquery





                    
if __name__ == '__main__':

    data_tier = "full-reconstructed"
    workflow = 1630
    FIX = False
    TESTME = False
    test = "duplicates"
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
    hd = [1650,1638,1630,1631,1632,1633,1596,1597,1598,1599,1600,1601,1602,1604,1606,1608,1609,1581,1582,1584,1594,1586,1587,1588,1595]
    vd = [1583,1590,1591,1593] + list(range(1610,1630))

          
    for workflow in hd:

        testquery = ""
        if test == "parentage":
            testquery =  "files from dune:all where core.data_tier='%s' and dune.workflow['workflow_id'] in (%d) "%(data_tier,workflow)
        print ("top level query metacat query \" ",testquery, "\"")
        if test == "duplicates":

            testquery =  "files from dune:all where core.data_tier='%s' and dune.workflow['workflow_id'] in (%d) "%(data_tier,workflow)

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

        fixer=MetaFixer(verbose=False,errname="%s_%s_%d_%s.txt"%(test,data_tier,workflow,now),test=test, fix=FIX)
        thelimit=100
        theskip=0
        for i in range(0, 100000):
            thelist = fixer.getInput(query=testquery,limit=thelimit,skip=theskip)
            if len(thelist) == 0:
                print ("got to the end of the list at ",theskip)
                break
            fixer.explore()
            if len(thelist) <= 0:
                print ("readed end of list at",theskip)   
            theskip += thelimit
        fixer.cleanup()

