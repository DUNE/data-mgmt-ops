import rucio
from rucio.client.replicaclient import ReplicaClient
from rucio.client.didclient import DIDClient
from metacat.webapi import MetaCatClient
from argparse import ArgumentParser as ap
import multiprocessing as mp

def to_str(f):
  return f'{f["scope"]}:{f["name"]}'

def check_one(fin):#, good_files, bad_files):
  i, f = fin
  print(i)
  try:
    dc.list_content(scope=f['scope'], name=f['name'])
    return (to_str(f), True)
  except(rucio.common.exception.DataIdentifierNotFound):
    return (to_str(f), False)
    

def get_files(args):
  files = [f for f in mc.query(args.mql)]
  return [
    {'scope':f['namespace'], 'name':f['name']} for f in files
  ]

def check_content(args):
  files = get_files(args)

  print('Got', len(files), 'files')
  with mp.Pool(args.n) as pool:
    results = pool.map(check_one, enumerate(files))

  with open(f'{args.outstr}_bad_files.txt', 'w') as f:
    f.writelines([f[0] + '\n' for f in results if not f[1]])
  with open(f'{args.outstr}_good_files.txt', 'w') as f:
    f.writelines([f[0] + '\n' for f in results if f[1]])

def check_one_replica(f):
  print(rc.list_replicas(scope=f.split(':')[0], name=f.split(':')[1]))

def check_replicas(args):
  with open(args.i, 'r') as f:
    files = [l.strip('\n') for l in f.readlines()]

  files = [
    {'scope':f.split(':')[0], 'name':f.split(':')[1]}
    for f in files
  ]
  n = 1 if args.n is None else args.n

  import math
  chunk = math.ceil(len(files)/n)
  files = [
    files[i*chunk:(i+1)*chunk] for i in range(n)
  ]

  results = []
  for chunk in files:
    results += [
        (f'{i["scope"]}:{i["name"]}',len(i['rses']) > 0)
        for i in rc.list_replicas(dids=chunk)
    ]

  with open(f'{args.outstr}_no_replicas.txt', 'w') as f:
    f.writelines([f[0] + '\n' for f in results if not f[1]])
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
