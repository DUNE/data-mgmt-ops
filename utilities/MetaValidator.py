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
    ' make a did from namespace and name'
    return "%s:%s"%(namespace,name)

 

def jsondump(adict):
    'make a nice json formated string out of a dictionary'
    return json.dumps(adict,indent=4)          

class MetaValidator:

    def __init__(self,configname=None,verbose=None,type=None):
        self.verbose = verbose
        self.type = type
        if configname is not None:
            f = open(configname,'r')
            try:
                self.config = json.load(f)
            except:
                print ("Could not read json config file",configname)
        else:
            self.config = self.default()

        print (self.config)

    def default(self,type="raw"):
        defaultconfig = ["checksums",       
                        "created_timestamp",\
                        "creator",\
                        "core.data_stream",\
                        "core.data_stream",\
                        "core.data_tier",\
                        "core.end_time",\
                        "core.file_content_status",\
                        "core.file_format",\
                        "core.file_type",\
                        "core.run_type",\
                        "core.runs",\
                        "core.start_time",\
                        "retention.class",
                        "retention.status",\
                        "name",\
                        "namespace",\
                        "retired",\
                        "retired_by",\
                        "retired_timestamp",\
                        "size",\
                        "updated_by",\
                        "updated_timestamp"\
                        ]
        return defaultconfig
    
    def flatten(self,config):
        flat = {}
        for x in config.keys():
            if x != "metadata":
                flat[x] = config[x]
            else:
                meta = config["metadata"]
                for y in meta.keys():
                    flat[y] = meta[y]
        if self.verbose:
            print (flat)
        return flat


    def test(self,new):
        missing = []

        for x in self.config:
            if x not in new.keys():
                missing.append(x)
        print ("these fields are missing",missing)
              


if __name__ == '__main__':

    datatype = "raw"
    filename = sys.argv[1]
    if len(sys.argv)> 2:
        type = sys.argv[2]
    validator = MetaValidator(verbose=False,type=datatype)
    input = open(filename,'r')
    test = json.load(input)
    check = validator.flatten(test)
    validator.test(check)


