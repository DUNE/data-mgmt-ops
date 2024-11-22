"""
Script to check:
        1) whether files from metacat are declared in rucio
        2) whether files declared in rucio have replicas

Usage:
  1) Checking metacat files
    check_rucio_files check_content \
        --mql <mql query> \
        -n <number of concurrent processes -- default:number of available cpus> \
        --outstr <output>

    Will check rucio for files matching the mql query.

    Runs in parallel.

    Will produce 2 output files:
        - <output>_good_files.txt -- Files that do exist in rucio
        - <output>_bad_files.txt -- Files that do not exist in rucio

  2) Checking rucio replicas
    check_rucio_files check_replicas \
        -i <input_file> \
        -n <number of chunks -- default:1> \
        --outstr <output>

    Will check rucio for replicas for files listed in the input file.
    This file should have one did (scope:file_name) per line. This can be the 
    '*_good_files.txt' file produced from the check_content routine.

    Will produce 2 output files:
        - <output>_with_replicas.txt -- Files that have a replica in rucio 
        - <output>_no_replicas.txt -- Files that do not have a replica in rucio 
"""


import rucio
from rucio.client.replicaclient import ReplicaClient
from rucio.client.didclient import DIDClient
from metacat.webapi import MetaCatClient
from argparse import ArgumentParser as ap
import multiprocessing as mp

def to_str(f):
  '''Simple string output'''
  return f'{f["scope"]}:{f["name"]}'

def check_one(fin):
  '''Check a single metacat file if it exists in rucio'''
  i, f = fin
  print(i)
  try:
    #If it exists return true
    dc.list_content(scope=f['scope'], name=f['name'])
    return (to_str(f), True)
  except(rucio.common.exception.DataIdentifierNotFound):
    #Return false if there's an exception -- that means it doesn't exist
    return (to_str(f), False)
    

def get_files(args):
  #Get simple dids from metacat
  files = [f for f in mc.query(args.mql)]
  return [
    {'scope':f['namespace'], 'name':f['name']} for f in files
  ]

def check_content(args):
  '''Method to check whether metacat-declared files also exist in rucio'''

  #Get the files from metacat
  files = get_files(args)
  print('Got', len(files), 'files')

  #Run in parallel and execute the checking
  with mp.Pool(args.n) as pool:
    results = pool.map(check_one, enumerate(files))

  #Write out the list of files that do not exist in rucio
  with open(f'{args.outstr}_bad_files.txt', 'w') as f:
    f.writelines([f[0] + '\n' for f in results if not f[1]])

  #Write out the list of files that do exist in rucio
  with open(f'{args.outstr}_good_files.txt', 'w') as f:
    f.writelines([f[0] + '\n' for f in results if f[1]])

def check_replicas(args):
  '''
  Method to check whether rucio-declared files have a replica
  '''

  #Get the file list as dids
  with open(args.i, 'r') as f:
    files = [l.strip('\n') for l in f.readlines()]
  files = [
    {'scope':f.split(':')[0], 'name':f.split(':')[1]}
    for f in files
  ]

  #Split into args.n chunks
  n = 1 if args.n is None else args.n
  import math
  chunk = math.ceil(len(files)/n)
  files = [
    files[i*chunk:(i+1)*chunk] for i in range(n)
  ]

  #Iterate over chunks and list replicas
  results = []
  for chunk in files:
    results += [
        # Checks if there is an rse associated with this file
        # and sets a flag if so
        (f'{i["scope"]}:{i["name"]}',len(i['rses']) > 0)
        for i in rc.list_replicas(dids=chunk)
    ]

  #Save the files without replicas
  with open(f'{args.outstr}_no_replicas.txt', 'w') as f:
    f.writelines([f[0] + '\n' for f in results if not f[1]])
  #Save the files with replicas
  with open(f'{args.outstr}_with_replicas.txt', 'w') as f:
    f.writelines([f[0] + '\n' for f in results if f[1]])


if __name__ == '__main__':
  parser = ap()
  parser.add_argument('routine', type=str, default='check_content')
  parser.add_argument('-i', type=str)
  parser.add_argument('--mql', type=str)
  parser.add_argument('-n', type=int, default=None)
  parser.add_argument('--outstr', type=str, default='')
  args = parser.parse_args()

  mc = MetaCatClient()
  dc = DIDClient()
  rc = ReplicaClient()

  routines = {
    'check_content':check_content,
    'check_replicas':check_replicas,
  }
  routines[args.routine](args)
