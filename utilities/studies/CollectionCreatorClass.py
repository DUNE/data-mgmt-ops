"""metacat CollectionCreatorClass"""
##
# @mainpage CollectionCreatorClass
#
# @section description_main
#
#  You can invoke this with python CollectionCreatorClass --json=<json with list of required field values>
# optional arguments are --min_time (earliest date)  --max_time (latest date)
##
# @file CollectionCreatorClass.py

# pylint: disable=C0303
# pylint: disable=C0321 
# pylint: disable=C0301  
# pylint: disable=C0209
# pylint: disable=C0103 
# pylint: disable=C0325 
# pylint: disable=C0123



from argparse import ArgumentParser as ap

import sys
import os
import json

import samweb_client

from metacat.webapi import MetaCatClient
samweb = samweb_client.SAMWebClient(experiment='dune')

DEBUG = False

mc_client = MetaCatClient(os.getenv("METACAT_SERVER_URL"))


class CollectionCreatorClass:
    ''' Class to create data collections'''

    def __init__(self,verbose=False):
        ''' 
        __init__ initialization, does very little

        :param verbose: print out a lot of things

        '''
        self.namespace = None
        self.name = None # actual name
        self.did = None # (namespace+defname)
        self.meta = None # (list of tags)
        self.metaquery = None # metacat query
        self.samquery = None # translation of metaquery into sam language
        self.user = os.getenv("USER") # default is person running the script
        self.info = None
        self.verbose = verbose
        self.test = False
        self.sam = False

    ## set up from another script by using a dictionary or a did name  -- parallels the command line

    def load (self,thedict = None, did = None, test = False):
        ''' 
        load the information from the json dict into the class
        does not change the db
        
        :param thedict: contents of input json description of collection
        
        :param did: id of a preexisting dataset to refill with new files

        calls make_name, make_query and make_sam_query

        
        '''

        if thedict is None and did is None:
            print ("no dictionary or dataset name provided - perhaps you want to use the --json or --did argument to specify on command line")
            sys.exit(1)

        self.test = test

        # this inputs a did
        if did is not None:
            self.did = did
            stuff = self.did.split(":")
            if len(stuff)!=2:
                print ("did", self.did, "has invalid format")
                sys.exit(1)
            if self.namespace is None:
                if(self.verbose):
                    print ("getting namespace from --did", stuff[0])
                self.namespace = stuff[0]
            self.name = stuff[1]
            try:
                info = mc_client.get_dataset(self.did)
            except:
                print ("failure finding information for ", self.did)
                sys.exit(1)
            
            self.info = info

            if "datasetpar.query" in info["metadata"]:
                self.metaquery = info["metadata"]["datasetpar.query"]
            else:
                print ("could not find a query in the dataset metadata for ", self.did, info)
                print ("this only works for datasets made with CollectionCreatorClass")
                sys.exit(1)
        
        if thedict is not None:
            self.meta = thedict
        
        self.make_name()
        self.make_query()
        self.make_sam_query()

    def run(self):
        ''' 

        contact the db and actually generate the collection based on the data stored in the load phase
        calls MakeDataSet and MakeSamDefinition
        modifies the metacat db
        
        '''
        if self.namespace is None:
            self.namespace = self.user
        if self.did is None and self.name is None:
            print ("need to run load first to get name or did")
            sys.exit(1)

        if not self.test:          
            self.makeDataset()

            if self.sam: self.makeSamDefinition()
        


    ## create a collection name from template in json file. If none exists use a list of fields. 
    def make_name(self):
        ''' create a name from template in json file. If none exists use a list of fields. 
         does not modify the db '''

        if self.did is not None:
            names = self.did.split(":")
            self.name = names[1]
            self.namespace = names[0]
            return
        if self.verbose: print ("----------------------------")
        if self.verbose: print ("make a name for this dataset")
        ignore = ["description","defname","namespace","ordered"]

        if "defname" in self.meta.keys():
            template = self.meta["defname"]
            namekeys = template.split("%")
            if DEBUG: print (namekeys)
            if DEBUG: print (self.meta)
            for x in self.meta.keys():
                if x in ignore: continue
                extend = "%"+x
                if DEBUG: print ("extend",extend)
                if extend in template:
                    if self.meta[x] is None:
                        template = template.replace(x,"none")
                    else:
                        template = template.replace(extend,self.meta[x])
                    continue
                else:
                    if self.verbose: print ("keyword ",x,"not in defname, are you sure?")
            if "%" in template:
                print ("unrecognized tag in defname",template)
                sys.exit(1)
         
            template = template.replace("%",".")
            template = template.replace(":","-") # protect against ":" for ranges
            template = template.replace(",","_") # protect against "," in lists
            if template[0] == ".": template = template[1:]
            
            print ("dataset name will be: ",template,"\n")
            self.name = template
        
        else:
            order=["core.run_type","dune.campaign","core.file_type","core.data_tier","core.data_stream","dune_mc.gen_fcl_filename","core.application.version","min_time","max_time","deftag"]
            name = ""
            for i in order:
                if i in self.meta and self.meta[i]is not None:
                    new = self.meta[i]
                    new.replace(".fcl","")
            
                    if i == "max_time":
                        new ="le"+self.meta[i]
                    if i == "min_time":
                        new ="ge"+self.meta[i]
                    if i == "deftag":
                        new = self.meta[i]
                    name += new
                    name += "__"
            name = name[:-2]
            if self.verbose: print ("name will be",name)
            self.name = name

    ## make a metacat query from the AND of the json inputs

    def make_query(self):
        ''' build a metacat query if none exists already
        does not modify the db'''

        if self.verbose: print ("---------------------")
        print ("make or find a metacat query")
        # skip if already set (generally by did)
        if self.metaquery is not None:
            if DEBUG: print ("found a query",self.metaquery)
            return
        
        query = "files where"
        
        
        for item in self.meta.keys():
            if item == "Comment": continue
            if (DEBUG): print (item)
            if self.meta[item] is None:
                continue
            if "." not in item:
                continue
            val = self.meta[item]
            # put quotes around values that have "-" in them because metacat doesn't interpret "-" well
            if type(val) == str and "-" in val and not "'" in val: 
                val = "\'%s\'"%val

            
            query += " "+item+"="+str(val)
            query += " and"
            
        # strip off the last "and"
        query = query[:-4]
        if (DEBUG): 
            print (query)
    
        if "runs" in self.meta:
            runs = self.meta["runs"]
            if ":" not in runs:
                runs = "(%s)"%runs
            rquery = " and core.runs[any] in %s"%runs   
            query += rquery
        
        if "workflow_ids" in self.meta:
            workflows = self.meta["workflow_ids"]
            if ":" not in workflows:
                workflows = "(%s)"%workflows
            rquery = " and dune.workflow['workflow_id'] in %s"%workflows  
            query += rquery

        # do time range - takes some work as there are two possibilities

        mint = ""
        maxt = ""

        if "min_time" not in self.meta or self.meta["min_time"] is None: 
            mint = None

        if "max_time" not in self.meta or self.meta["max_time"] is None: 
            maxt = None

        if maxt is not None and mint is not None:

            if mint is not None:
                mint = self.meta["min_time"]
                    
            if maxt is not None:
                maxt = self.meta["max_time"]
                
            
            var = "created_timestamp"
            
            timequery = "" 
            
            
            if mint is not None: 
                timequery += " and %s >= '%s'"%(var,mint)

            if maxt is not None: 
                timequery += " and %s <= '%s'"%(var,maxt)
            query += timequery
        else:
            if self.verbose: print ("No time range set, use all files")

        query += " ordered "

        print(query,"\n")
        self.metaquery = query
        

    def make_sam_query(self):
        ''' 
        use the existing metacat query to make a sam query
        does not modify the db
        '''
        if not self.sam: return
        if self.verbose: print ("-------------------------")
        print ("make a samweb query")
        if self.metaquery is None:
            print (" no metacat query to make sam query from")
            sys.exit(1)
        s = self.metaquery.split("where")
        if len(s) < 2:
            return None
        r = s[1]
        # convert some fields
        r = r.replace("core.","")
        r = r.replace("dune_mc.","DUNE_MC.")
        r = r.replace("dune.","DUNE.")
        r = r.replace("application.","")
        r = r.replace("runs[any] in","run_number")
        r = r.replace(":","-")
        r = r.replace("'","")
        r = r.replace("ordered", "" )
        r = r.replace("created_timestamp","create_date")
        r = r.replace("limit "," with limit ")
        r = " availability:anylocation and " + r
        # if ("skip" in r): print ("skip doesn't work yet in sam")
        # print ("samweb list-files --summary \"", r, "\"")
        print ("samquery", r,"\n")
        self.samquery = r

    ## parse sys.argv and either get existing query or read json and make a new query/dataset
    def setup(self):
        ''' 
        parse the arguments for the command line
        does not modify the db
        '''
        parser = ap()
        
        parser.add_argument('--namespace',type=str,default=os.getenv("USER"),help="metacat namespace for dataset")
        parser.add_argument('--user', type=str, help='user name')

        parser.add_argument('--json',type=str,default=None, help='filename for a json list of parameters to and')
        parser.add_argument('--did',type=str,default=None,help="<namespace>:<name> for existing dataset to append to")
        parser.add_argument('--test',type=bool,default=False,const=True,nargs="?",help='do in test mode')
        parser.add_argument('--verbose',type=bool,default=False,const=True,nargs="?",help='print out a lot')
        parser.add_argument('--sam',type=bool,default=False,const=True,nargs="?",help='use sam')       
        args = parser.parse_args()
        if DEBUG: print (args)

        if args.user is None and os.environ["USER"] is not None:  args.user = os.environ["USER"]

        self.user = args.user
        self.verbose = args.verbose

        self.namespace = args.namespace

        self.sam = args.sam

        # check if using prexisting did - if so reuse existing query

        if args.json is None:
            if args.did is None:
                print ("no json or did file, in future you will be able to append to a dataset directly")
                sys.exit(1)
            else:  # yes this is pre-existing dataset
                self.load(did=args.did,test=args.test)
                self.run()

        else:
            # read the data description tags from json file
            if not os.path.exists(args.json):
                print ("json file",args.json," does not exist, quitting")
                sys.exit(1)
            f = open(args.json,'r')
            if f:
                Tags = json.load(f)
                self.load(thedict=Tags,test=args.test)
                self.run()
            else:
                print ("could not open",args.json)
                sys.exit(1)   

    def printSummary(self,results):
        ''' 
        print a summary of metacat info in a nicer format
        does not modify the db
        '''
        nfiles = total_size = 0
        for f in results:
            nfiles += 1
            total_size += f.get("size", 0)
        if DEBUG: print("Files:       ", nfiles)
        if total_size >= 1024*1024*1024*1024:
            unit = "TB"
            n = total_size / (1024*1024*1024*1024)
        elif total_size >= 1024*1024*1024:
            unit = "GB"
            n = total_size / (1024*1024*1024)
        elif total_size >= 1024*1024:
            unit = "MB"
            n = total_size / (1024*1024)
        elif total_size >= 1024:
            unit = "KB"
            n = total_size / 1024
        else:
            unit = "B"
            n = total_size
        print("Matacat files: %d"%nfiles, "Total size:  ", "%d (%.3f %s)" % (total_size, n, unit))
    
    ## use the query from make_query to make a metacat dataset

    def makeDataset(self):
        ''' 
        actualy make the metacat dataset from information loaded into the class
        does modify the db
        '''

        if self.verbose: print ("---------------------------")
        if self.verbose: print ("try to make a metacat dataset")
        if self.metaquery is None:
            print ("ERROR: need to run make_query or supply an input dataset first")
            sys.exit(1)
     
        # already have a dataset - just want to update it

        if self.did is not None:
            if not self.test:
                print ("add files to existing dataset", self.did)
                mc_client.add_files(self.did,query=self.metaquery)
                return
            else:
                print ("this was just a test with an existing dataset")
            return
        
        # need to make dataset metadata from json input in self.meta

        cleanmeta = self.meta.copy()
        # move dataset creation flags into dataset....
        for x in self.meta.keys():
            if not "." in x: # we have some extra parameters - need to store properly
                if DEBUG: print ("rename search params that are not . type")
                if x == "description":  # this goes in the real description field so skip
                    if x in cleanmeta:cleanmeta.pop(x)
                    continue
                cleanmeta["datasetpar."+x]=self.meta[x]
                if x in cleanmeta:cleanmeta.pop(x)
            
        for x in self.meta.keys():
            if x not in cleanmeta: continue
            
            if self.meta[x] is None:
                if DEBUG: print ("remove null key",x,self.meta[x])
                if x in cleanmeta: cleanmeta.pop(x)
            else:
                cleanmeta[x] = self.meta[x]
            
        if DEBUG: print (cleanmeta)

        # store the query used to make this dataset for future reuse
        cleanmeta["datasetpar.query"] = self.metaquery

        did = "%s:%s"%(self.namespace,self.name)

        
        try:
            already = mc_client.get_dataset(did)
        except:
            print ("no dataset of this name yet, make one")
            already = None

        

        if already is None:
            if self.verbose: print ("make a new dataset",did)
            if self.verbose: print ("query",self.metaquery)
        
            mc_client.create_dataset(did,files_query=self.metaquery,description=self.meta["description"],metadata=cleanmeta)
            self.did = did
            self.info = mc_client.get_dataset(did)
            print ("made dataset", self.did, "\n")
#     
        else: # already there
               
            if DEBUG: print ("info",already)

            if self.verbose: print ("add files to existing dataset",did)
            if self.verbose: print ("query was",self.metaquery)
            
            mc_client.add_files(did,query=self.metaquery)
            self.info = mc_client.get_dataset(did)
            self.did = did
            print ("extended dataset", self.did,"\n")
        

    def makeSamDefinition(self):
        ''' 
        make a samweb definition from information loaded into the class and tranformed by make_sam_query
        does modify the sam db unless the definition already exists
        '''
        # do some sam stuff
        if self.verbose: print ("--------------------")
        if self.verbose: print ("make sam definition")
        defname=os.getenv("USER")+"_"+self.name
        if self.verbose: print ("Try to make a sam definition:",defname)

        try:
            result = samweb.listFilesSummary("defname:"+defname)
            print ("samweb status",result)
            if result is not None:
                print ("samweb definition already exists")
                return
            else:
                if self.verbose: print ("no such definition exists, need to make it")
        except:
            print ("no such samweb definition exists, need to make it")
        if self.samquery is not None :
            try:
                samweb.createDefinition(defname,dims=self.samquery,description=self.samquery)
                print ("made samweb definition",defname,"\n")
            except:
                print ("failed to make sam definition\n")
        
    


## command line, explains the variables.
if __name__ == "__main__":
   
    creator = CollectionCreatorClass()
    
    # read in command line args
    creator.setup()
    
    verbose = creator.verbose
    # dump out information 

    if(verbose): print ("\n------------------------")
    
    if creator.sam:
        if(verbose): print ("\n samweb query")

        if(verbose): print("samweb list-files --summary \"",creator.samquery,"\"\n")
        try:
            result = samweb.listFilesSummary(creator.samquery)
        except:
            print ("SAM got here")
        if verbose: print("SAM FILES",result)
        if(verbose): print ("\n------------------------")
    if(verbose): print ("\n metacat query")
    if(verbose): print("metacat query \"",creator.metaquery,"\"\n")
    query_files = list(mc_client.query(creator.metaquery))
    if(verbose): creator.printSummary(query_files)
    if(verbose): print ("\n ------------------------")
    if(verbose): print ("\n dataset metadata")
    if creator.meta and verbose: print(json.dumps({"dataset.meta":creator.meta},indent=4))
    elif creator.did and verbose: 
        print(json.dumps(creator.info,indent=4))

    if verbose: print ("\n ------------------------")
    
 
