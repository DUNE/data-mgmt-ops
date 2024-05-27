"""metacat MetaChecker"""
##
# @mainpage MetaChecker
#
# @section description_main
#
#  
# @file MetaChecker.py

# run checks to find files without parentage
# need to code in list of workflows or other things to check at line ~50

# if argument fast, will skip the parentage check 

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
import time
from datetime import datetime
import tenacity
from math import sqrt

import logging

logging.basicConfig(
    level=logging.INFO,
    format="%(asctime)s:%(name)s:%(levelname)s:%(message)s",
)

TENACITY_LOGGER = logging.getLogger("Retrying")


#import samweb_client



from metacat.webapi import MetaCatClient
# samweb = samweb_client.SAMWebClient(experiment='dune')

# tenacity debug
def fib(n):
    return int(((1 + sqrt(5))/2)**n / sqrt(5) + 0.5)

def wait_fib(rcs):
    return fib(rcs.attempt_number - 1)

my_retryer = tenacity.Retrying(
    stop=tenacity.stop_after_attempt(5),
    after=tenacity.after_log(TENACITY_LOGGER, logging.WARNING),
    before_sleep=tenacity.before_sleep_log(TENACITY_LOGGER, logging.WARNING),
    wait=wait_fib,
    reraise=True
)
testquery = ''

DEBUG = False

mc_client = MetaCatClient(os.getenv("METACAT_SERVER_URL"))

def jsondump(adict):
    '''returns a string from a dict to print'''
    return json.dumps(adict,indent=4)                   

def parentchecker(query):
    ' code the complex search for files without parents'
    newquery = " %s - children(parents(%s))"%(query,query)
    return newquery

@my_retryer.wraps
def get_metacat_query_results(mc_client=mc_client,testquery=testquery):
    results = mc_client.query(query=testquery,with_metadata=True, with_provenance=True)
    #for filemd in results:
    #    pass
    #    #print(f' file - {type(filemd)} {filemd}')                                                                                                                                                                                                                                                                            
    return results

@my_retryer.wraps
def check_start_end_times(mc_client, fid, namespace='', name='', did='', metadata=None):
#def check_start_end_times(mc_client=mc_client, fid = fid, namespace=namespace, name=name, did=did, metadata=metadata):

    #print(f'fid={fid}\n {metadata}')
    metadata_keys = ["core.start_time","core.end_time"]
    metadata_dict = {}
    for key in metadata:
        metadata_dict[key] = metadata[key]
    convert_time = False
    for key in metadata_keys:
        if key in metadata:
            if type(metadata[key]) is str:
                # check format of string is numeric
                if metadata[key].replace('.','',1).isdigit():
                    epoch_time = float(metadata[key])
                else:
                    utc_time = datetime.strptime(str(metadata[key])+"Z","%Y-%m-%fT%H:%M:%SZ")
                    epoch_time = float((utc_time - datetime(1970,1,1)).total_seconds())
                # convert to float
                convert_time = True
                print(f'{fid} {did} {key} {type(metadata[key])} {metadata[key]} {epoch_time}')
                metadata_dict[key] = epoch_time
    # update time stamps from string to float
    if len(metadata_dict) > 0 and convert_time :
        #print(f'result = mc_client.update_file(did={did}')
        print(f'result = mc_client.update_file(did={did}, metadata={metadata_dict})')
        result = mc_client.update_file(fid=fid, metadata=metadata_dict)
        print(result)
        print(" ")

def only_check_start_end_times(mc_client, fid, metadata, verbose=False):

    #print(f'fid={fid}\n {metadata}')
    metadata_keys = ["core.start_time","core.end_time"]
    #metadata_dict = {}
    #for key in metadata:
    #    metadata_dict[key] = metadata[key]
    convert_time = False
    for key in metadata_keys:
        if key in metadata:
            if type(metadata[key]) is str:
                # check format of string is numeric
                if metadata[key].replace('.','',1).isdigit():
                    epoch_time = float(metadata[key])
                else:
                    utc_time = datetime.strptime(str(metadata[key])+"Z","%Y-%m-%fT%H:%M:%SZ")
                    epoch_time = float((utc_time - datetime(1970,1,1)).total_seconds())
                # convert to float
                convert_time = True
                if verbose:
                  print(f'{fid} {key} {type(metadata[key])} {metadata[key]} new: {type(epoch_time)}')
                #print(f'{fid} {did} {key} {type(metadata[key])} {metadata[key]} {epoch_time}')
                metadata[key] = epoch_time
    return convert_time
    #if not convert_time:
    #  return None
    #else:
    #  return metadata_dict

def only_check_subruns(mc_client, fid, metadata, verbose=False):
  #If good md already there, move on
  if 'core.runs_subruns' in metadata:
    if verbose:
      print('core.runs_subruns in metadata:', metadata['core.runs_subruns'])
    return False

  #This should be there
  if 'core.subruns' not in metadata:
    raise Exception(f'Metadata for {fid} is missing both '
                    'core.subruns and core.runs_subruns. This could be very bad.'
                    ' Check by hand')

  metadata['core.runs_subruns'] = metadata['core.subruns']
  del metadata['core.subruns']

  return True

@my_retryer.wraps
def do_update_metadata(mc_client, fid, metadata):
  result = mc_client.update_file(fid=fid, metadata=metadata)

if __name__ == '__main__':
  hd = [1750, 1752, 1754,  1757, 1763, 1764, 1765, 1766, 1767, 1768, 1782]
  
  hd = [1752, 1754,  1757, 1763, 1764, 1765, 1766, 1767, 1768, 1782]
  
  hd = [1750]
  
  for workflow in hd:
  
      testquery=f"files from dune:all where dune.workflow['workflow_id']={workflow}"
      print (testquery)
  
      results = get_metacat_query_results(mc_client=mc_client,testquery=testquery)
  
      fileno = 0
      for filemd in results:
          #print(f' file - {type(filemd)} {filemd}')
          fileno += 1
          fid = filemd["fid"]
          namespace = filemd["namespace"]
          name = filemd["name"]
          did = f'{namespace}:{name}'
          if "metadata" in filemd:
              metadata = filemd["metadata"]
              check_start_end_times(mc_client=mc_client, fid=fid, namespace=namespace, name=name, did=did, metadata=metadata)
          #Check for children
          if "children" in filemd and len(filemd["children"])> 0:
              # look over the check for grand children
              childrenmd = mc_client.get_files(filemd["children"], with_metadata=True, with_provenance=True)
              for childmd in childrenmd:
                  fid = childmd["fid"]
                  namespace = childmd["namespace"]
                  name = childmd["name"]
                  did = f'{namespace}:{name}'
                  if "metadata" in childmd:
                      metadata = childmd["metadata"]
                      check_start_end_times(mc_client=mc_client, fid=fid, namespace=namespace, name=name, did=did, metadata=metadata)
                  # check for grandkids
                  if "children" in childmd and len(childmd["children"])> 0:
                      grand_childrenmd = mc_client.get_files(childmd["children"], with_metadata=True, with_provenance=True)
                      for grand_childmd in grand_childrenmd:
                          fid = grand_childmd["fid"]
                          namespace = grand_childmd["namespace"]
                          name = grand_childmd["name"]
                          did = f'{namespace}:{name}'
                          if "metadata" in grand_childmd:
                              metadata = grand_childmd["metadata"]
                              check_start_end_times(mc_client=mc_client, fid=fid, namespace=namespace, name=name, did=did, metadata=metadata)
          if fileno % 1000 == 0:
              print(f'Workflow ID {workflow} processed # files = {fileno}')
          #DPBif fileno > 10:
          #DPB    break
      #DPBsys.exit(0)
      print(f'Workflow ID {workflow} processed # files = {fileno}')
