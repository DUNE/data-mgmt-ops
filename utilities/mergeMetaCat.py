########## metadata helper ##############

# this provides a meta data merger class which given a defined list of external information about a file and a list of input files, will produce metadata for the output.

# originally used by MINERvA

# H Schellman, Sept. 13, 2021

import os,sys,time,datetime
from metacat.webapi import MetaCatClient
import json
import argparse
from statistics import mean
from TypeChecker import TypeChecker
import CheckSum

mc_client = MetaCatClient(os.environ["METACAT_SERVER_URL"])


#-------utilities ------#

def dumpList(the_list):
    'dump something item by item'
    for item in the_list:
        print (item, the_list[item])

def timeform(now):
    'time formatting'
    timeFormat = "%Y-%m-%d_%H:%M:%S"
    nowtime = now.strftime(timeFormat)
    nowTstamp= time.strptime(nowtime,timeFormat)
    return int(time.mktime(nowTstamp))

class mergeMeta():
  #""" Base class for making metadata for a file based on parents"""
  
    def __init__(self, opts, debug):
        'basic setup for mergeMeta'
      
        self.opts = opts #this is a dictionary containing the option=>value pairs given at the command line
        self.debug = debug
        self.mc_client = MetaCatClient(os.environ["METACAT_SERVER_URL"])
        # these are things you need to tell the program
        self.externals = ["name","namespace","core.start_time","core.end_time","size",'core.data_tier']

        # these are things you cannot mix in a merge
        self.consistent = ["core.file_type","core.file_format","core.data_tier",'core.application.name','dune.campaign']

        # these are things you can ignore or merge
        self.ignore = ["checksum","created_timestamp","Offline.options","core.first_event_number","parents","Offline.machine","core.last_event_number","core.runs","core.runs_subruns"]

        self.source = "metacat" # alternative = local

        self.special = ['info.wallsec', 'info.memory', 'info.cpusec', 'DUNE.fcl_name']

############################################
## Function that forms merged metadata
## for a list of files
############################################
    def checkmerge(self, the_list):
        ' input is a list of metacat files'
        checks = {}
        # initialize checks for consistency - items in consistent should only have one variant in the list
        for tag in self.consistent:
            checks[tag] = []
  
        ##Look through the file list and get the metadata for each
        a = 0
        for f in the_list:
            if not a%100: print('%i/%i'%(a, len(the_list)), end='\r')
            a += 1
           
            if self.source == "local":
                if not os.path.exists(f):
                    print(" can't find file", f, "quitting")
                    return False
                if self.debug:
                    print(" looking at: ", f)
          
                with open(f, 'r') as metafile:
                    thismeta = json.load(metafile)
            else:
                themeta = mc_client.get_file(did=f,with_metadata=True)
            if self.debug:
                dumpList(themeta)
            thismeta = themeta["metadata"]
            # here to find the must not mix ones
            # Loop over the tags we've defined as consistent
            # and check that it's in the file metadata
            for tag in self.consistent:
                if tag not in thismeta:
                    checks[tag].append("missing")  # if it ain't there, it aint there.
              ## Then, add the value from this metadata field to the check list 
                if thismeta[tag] not in checks[tag]:
                    checks[tag].append(thismeta[tag])
            
            
          #Checks that all files have the same value for this field
            for tag in self.consistent:
                if (len(checks[tag]) > 1):
                    print ("mergeMetaCat: tag ", tag, " has problem ",checks[tag])
                    return False
        
        return True

  
    def concatenate(self, the_list, externals, user=''):
        
      # here are things that are unique to the output and must be supplied externally
        for tag in self.externals:
            if not tag in externals:
                print ("mergeMetaCat: must supply", tag, "before we can merge")
                sys.exit(2)
            
        firstevent = 999999999999
        lastevent = -999
        runlist = []
        subrunlist = []
        eventcount = 0
        parentage = []
        if(len(the_list) < 1):
            return []
      
#        starttime = ""
#        endtime = ""

        # here are things that are internals and must be consistent
        checks = {}
        mix = {}
#        other = {}
        for tag in self.consistent:
            checks[tag] = []
    
        # loop over files in the list
        a = 0
        special_md = {}
        for f in the_list:
            if self.debug: print ("mergeMetaCat: look at ",f)
            if not a%100: print('%i/%i'%(a, len(the_list)), end='\r')
            #print('%i/%i'%(a, len(the_list)))
            a += 1
            # parse = f.split(":")
            # namespace = parse[0]
            # filename = parse[1]
            #get the metadata for each file

            if self.source == "local":
                if not os.path.exists(f):
                    print(" can't find file", f, "quitting")
                    break
                if self.debug:
                    print(" looking at:", f)
                  
                with open(f, 'r') as metafile:
                    mainmeta = json.load(metafile)
            else:
                if self.debug:  ("look for did",f)
                if ":" not in f:
                    if self.debug:  ("file",f,"is missing namespace")
                    sys.exit(1)
                parse = f.split(":")

                mainmeta = mc_client.get_file(name=parse[1],namespace=parse[0])# ,with_metadata=True,with_provenance=True)
            if mainmeta == None:
                print ("mergeMetaCat: file",f, "had no metadata")
                sys.exit(1)
            thismeta = mainmeta["metadata"]
            #print (thismeta)
            if self.debug:
                dumpList(thismeta)
                  
            #Loop over tags in the metadata
            for tag in thismeta:
                if self.debug:
                    print ("mergeMetaCat:  check tag ", tag)
                  ##Check if it's a new field
                if (tag not in self.consistent and
                    tag not in self.externals and tag not in mix):
                    if self.debug:
                        print ("mergeMetaCat:  found a new parameter to worry about", tag)
                    if tag in self.special:
                      # print('special', tag)
                        self.getSpecialMD(tag, thismeta[tag], special_md)
                    else:
                        mix[tag]=[thismeta[tag]]
            if self.debug:
                dumpList(thismeta)
            #print ("mergeMetaCat: meta is", thismeta)
            #print ("mergeMetaCat: mix is", mix)

            #Loop over the tags that must be consistent
            #and add the fields to the checklist
            for tag in self.consistent:
                if self.debug: print (tag,checks[tag])
                if tag not in thismeta: continue
                if thismeta[tag] not in checks[tag]:
                    checks[tag].append(thismeta[tag])

            #See how many mixed fields are here
            for tag in mix:
                if tag in thismeta:
                    if thismeta[tag] not in mix[tag]:
                        mix[tag].append(thismeta[tag])
                        if self.debug:
                            if self.debug:  ("tag",tag," has", len(mix[tag]), "mixes")

            #Get the first and last events and the count
            if self.debug and "core.first_event_number" in thismeta:
                print ("first_event",thismeta["core.first_event_number"],firstevent)
            if "core.first_event_number" in thismeta:
                if thismeta["core.first_event_number"] <= firstevent:
                    firstevent = thismeta["core.first_event_number"]
            if "core.last_event_number" in thismeta:      
                if thismeta["core.last_event_number"] >= lastevent:
                    lastevent = thismeta["core.last_event_number"]
            if "core.event_count" in thismeta: 
                eventcount = eventcount + thismeta["core.event_count"]
        
            # is this already in the runlist
            for run in thismeta["core.runs"]:
                if run not in runlist:
                    runlist.append(run)
            for subrun in thismeta["core.runs_subruns"]:
                if subrun not in subrunlist:
                    subrunlist.append(subrun)

            if self.debug:
                print (thismeta["core.runs"], runlist)
            # Get the list of parents
            parentage.append({"fid":mainmeta["fid"]})
            
        
        #Start building the new metadata 
        newJsonMetaData={}  # the metadata part
        newJsonData={}# the upper level part

        #For the must-be-consistent tags,
        #first check that things are not getting mixed up,
        #these are things that should carry through.
        for tag in self.consistent:
            if (len(checks[tag]) == 0):
                print ("mergeMetaCat: tag",tag,"is missing, hope this is ok")
                continue
            if(len(checks[tag]) > 1):
                print ("mergeMetaCat tag ", tag, " has problem ",checks[tag]," clean up file list and retry")
                sys.exit(1)
            else:
                if "." in tag:
                    newJsonMetaData[tag] = checks[tag][0]
                else:
                    newJsonData[tag] = checks[tag][0]

        for tag in mix:
          #ignore certain ones
            if tag in self.ignore or tag == 'core.runs' or tag == 'core.event_count':
                continue
            if len(mix[tag]) == 1:
                newJsonMetaData[tag] = mix[tag][0]
            elif len(mix[tag]) > 1:
                print ("mergeMetaCat: don't write out mixed tags", tag)
                #print (mix[tag])

        self.finishSpecialMD(special_md)

        # overwrite with the externals if they are there
        for tag in externals:
            if "." in tag:
                if self.debug:  ("overwrite top levein info with external",tag,externals[tag])
                newJsonMetaData[tag] = externals[tag]
        for tag in special_md:
            if "." in special_md:
                newJsonMetaData[tag] = special_md[tag]
      
        #if no event count was provided from externals, use the input files
        if("core.event_count" not in newJsonMetaData or newJsonMetaData["core.event_count"] == -1):
            newJsonMetaData["core.event_count"] = eventcount
              
        # set these from the parents
        if(firstevent!=-1 and lastevent !=-1):
            newJsonMetaData["core.first_event_number"] = firstevent
            newJsonMetaData["core.last_event_number"] = lastevent
            newJsonMetaData["core.event_count"] = eventcount
            newJsonMetaData["core.runs"] = runlist
            newJsonMetaData["core.runs_subruns"] = subrunlist
            newJsonData["parents"] = parentage

        #events/lumblock info is missing
        else:
            newJsonMetaData["core.first_event_number"] = firstevent
            newJsonMetaData["core.last_event_number"] = lastevent
            newJsonMetaData["core.event_count"] = eventcount
            newJsonMetaData["core.runs"] = runlist
            newJsonMetaData["core.runs_subruns"] = subrunlist
            newJsonData["parents"] = parentage

        if newJsonMetaData["core.data_stream"] == "mc":
            newJsonMetaData["core.first_event_number"] = firstevent
            newJsonMetaData["core.last_event_number"] = lastevent
            newJsonMetaData["core.event_count"] = eventcount
            newJsonMetaData["core.runs"] = runlist
            newJsonMetaData["core.runs_subruns"] = subrunlist
            newJsonData["parents"] = parentage
            
        newJsonData["metadata"]=newJsonMetaData
        if user != '': newJsonData['creator'] = user

        for tag in externals:
            if "." not in tag:
                if self.debug:  ("overwrite top levein info with external",tag,externals[tag])
                newJsonData[tag] = externals[tag]
        if(self.debug):
            print ("mergeMetaCat: -------------------\n")
            dumpList(newJsonData)
        
        # self.mc_client.validateFileMetadata(newJsonData)
        #try:
        #  self.mc_client.validateFileMetadata(newJsonData)
        #except Exception:
        #  print (" metadata validation failed - write it out anyways")
        try:
            status,fixes = TypeChecker(newJsonData,verbose=False)
            if not status: print ("mergeMetaCat: Checked metadata",status,fixes)
        except:
            print ("mergeMetaCat: TypeChecker failed")
        return newJsonData
    
    def setDebug(self, debug=False):
        self.debug = debug 
    def setSourceLocal(self):
        self.source = "local"
    def setSourceMetaCat(self):
        self.source = "metacat"


    ##Method to grab some info parents
    def fillInFromParents(self, did, new_json_filename):
         
        if self.source == "local":
            filename = did
            meta_file = open(filename, 'r')
            this_meta = json.load(meta_file)
            
        else:
            this_meta = self.mc_client.get_file(did=did, with_metadata=True,with_provenance=True)
        parents = this_meta["parents"]

        parent_metas = [self.mc_client.get_file(fid = f, with_metadata=True,with_provenance=True) for f in parents]

        ##skip these fields from parents
        skip = ['did', 'created_timestamp', 'creator', 'size', 'checksum',
                'core.content_status', 'core.file_type', 'core.file_format', 'core.group', 'core.data_tier',
                'core.application.name', 'core.event_count', 'core.first_event_number', 'core.last_event_number',
                'core.start_time', 'core.end_time', 'art.file_format_era',
                'art.file_format_version', 'art.first_event', 'art.last_event',
                'art.process_name', 'DUNE.requestid', 'runs',
                'parents', 'name', 'core.data_stream']

        all_fields = {}
        for pm in parent_metas:
            for t in pm:
                if t in skip: continue 
                if t not in all_fields: all_fields[t] = []
                all_fields[t] += [pm[t]]
        new_meta = {}
        for t, l in all_fields.items():
            #print(t, l)

            if len(set(l)) > 1: print("ERROR")
            else: new_meta[t] = l[0]

        filled_meta = this_meta
        for t, m in new_meta.items():
            if t in filled_meta:
                print("ERROR")
                break
            filled_meta[t] = m 

        ##Patch the run type and data_stream
        #print("Patching run type")
        # new_runs = []
        # for r in filled_meta['runs']:
        #     #print(r)
        #     new_runs.append(r)
        #     #new_runs[-1][2] = 'protodune-sp' 
        # filled_meta['runs'] = new_runs

        #filled_meta['data_stream'] = 'physics'

        with open(new_json_filename , 'w') as f:
            json.dump(filled_meta, f, indent=2, separators=(',', ': '))

    def getSpecialMD(self, tag, val, special_md):
        if tag in ['info.wallsec', 'info.cpusec']:
            if tag not in special_md.keys():
                special_md[tag] = 0.
            special_md[tag] += val
        elif tag == 'info.memory':
            if tag not in special_md.keys():
                special_md[tag] = []
            special_md[tag].append(val)
        elif tag == 'DUNE.fcl_name':
            special_md[tag] = val.split('/')[-1]

    def finishSpecialMD(self, special_md):
        if 'info.memory' in special_md.keys():
            special_md['info.memory'] = mean(special_md['info.memory'])

def run_merge(newfilename, newnamespace, datatier, flist, merge_type, do_sort=0, user='', debug=False):
    
    opts = {}
    maker = mergeMeta(opts,debug)
    if merge_type == 'local':
        maker.setSourceLocal()
    elif merge_type == 'metacat':
        maker.setSourceMetaCat()
    else:
        print('error: mergeMeta -t provided is not local or metacat', merge_type)
        return 1
    maker.setDebug(debug)
    inputfiles = flist
  
    if (do_sort != 0):
        inputfiles.sort()
      
    # these need to be set here as they define the output file.  

    print (" about to do checksum on newfilename",newfilename)
    checksum = CheckSum.Adler32(newfilename)
    if debug: print ("Checksum is ",newfilename,checksum)
 
    externals = {
                "name": os.path.basename(newfilename),
                "namespace": newnamespace,
                "creator": os.getenv("USER"),
                "size": os.path.getsize(newfilename),
                "core.data_tier": datatier,
                #"core.application.name": application,
                #"core.application.version": version,
                "core.data_stream": "physics",
                "core.file_format": "root",
                "core.start_time": timeform(datetime.datetime.now()),
                "core.end_time": timeform(datetime.datetime.now()),
                "retired":False,
                "retired_by":None,
                "retired_timestamp":None,
                "updated_by":None,
                "updated_timestamp":None,
                "checksums":{"adler32":checksum}
                }
                
    DEBUG = 0
    if DEBUG:
        print (externals)
    #test = maker.checkmerge(inputfiles)
    #print ("mergeMetaCat: merge status",test)
    #if test:
    if debug: print ("mergeMetaCat: concatenate")
    meta = maker.concatenate(inputfiles,externals, user=user)
    if debug: print ("mergeMetaCat: done")
    #print(meta)
    

    f = open(newfilename+".json",'w')
    json.dump(meta,f, indent=2,separators=(',',': '))

    

    return 0
 

if __name__ == "__main__":
  
    parser = argparse.ArgumentParser(description='Merge Meta')
    parser.add_argument("--fileName", type=str, help="Name of merged file", default="new.root")
    parser.add_argument("--nameSpace", type=str, help="Namespace for merged file", default=os.environ["USER"])
    parser.add_argument('--jsonList', help='Name of file containing list of json files if -t=local', default=None, type=str)
    parser.add_argument('--fileList', help='Name of file containing list of metacat did if -t=metacat', default=None, type=str)
    parser.add_argument('-s', help='Do Sort?', default=1, type=int)
    parser.add_argument('-t', help='local or metacat', type=str, default='metacat')
    parser.add_argument('-u', help='Patch user to specified. Leave empty to not patch', type=str, default='')
    parser.add_argument('--dataTier',help='data_tier for output',default='root-tuple',type=str)
    #parser.add_argument('--application',help='merge application name',default='merge',type=str)
    #parser.add_argument('--version',help='software version for merge',default="v0",type=str)
    parser.add_argument('--debug',help='software version for merge',default=False,action='store_true')
    args = parser.parse_args()
    # print (args.fileList)
    
    if args.jsonList is None and args.fileList == None:
        print ("mergeMetaCat: need to provide name of a file contaiing either a list of local files or a list of metacat dids")
        sys.exit(1)
    if args.t == "local":
        fname = args.jsonList
    else:
        fname = args.fileList

    if os.path.exists(fname):
        f = open(fname,'r')
        x = f.readlines()
        flist = []
        for a in x:
            flist.append(a.strip())
        f.close()
    else:
        print (fname, " does not exist")
        sys.exit(1)

    run_merge(newfilename=args.fileName, newnamespace = args.nameSpace, datatier=args.dataTier, flist=flist, do_sort=args.s, merge_type=args.t, user=args.u, debug=args.debug)
