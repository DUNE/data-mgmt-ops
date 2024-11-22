import rucio
from rucio.client.replicaclient import ReplicaClient
from rucio.client.didclient import DIDClient
from metacat.webapi import MetaCatClient
from argparse import ArgumentParser as ap
import multiprocessing as mp

def to_str(f):
  return f'{f["scope"]}:{f["name"]}'

def check_one(f, good_files, bad_files):
  try:
    dc.list_content(scope=f['scope'], name=f['name'])
    good_files.append(to_str(f))
    #print('good file')
  except(rucio.common.exception.DataIdentifierNotFound):
    bad_files.append(to_str(f))
    #print('bad file')
    

def check_dids(args, files, good_files, bad_files):
  for i, f in enumerate(files):
    if not i%100: print(f'{i}/{len(files)}')
    check_one(f, good_files, bad_files)


def get_files(args):
  files = [f for f in mc.query(args.mql)]
  import math
  n = math.ceil(len(files)/args.n)
  return [
    [{'scope':f['namespace'], 'name':f['name']} for f in files[i:i + n]]
    for i in range(0, len(files), n)
  ]

def check_content(args):
  files = get_files(args)

  with mp.Manager() as manager:
    good_files = manager.list()
    bad_files = manager.list()
    n = [
        mp.Process(
            target=check_dids,
            args=(
                args,
                files[i],
                good_files,
                bad_files,
            )
        )
        for i in range(args.n)
    ]
  
    for p in n:
      p.start()
    for p in n:
      p.join()


    with open(f'{args.outstr}_bad_files.txt', 'w') as f:
      f.writelines([f + '\n' for f in bad_files])
    with open(f'{args.outstr}_good_files.txt', 'w') as f:
      f.writelines([f + '\n' for f in good_files])


if __name__ == '__main__':
  parser = ap()
  parser.add_argument('routine', type=str, default='check_content')
  parser.add_argument('-i', type=str)
  parser.add_argument('--mql', type=str)
  parser.add_argument('-n', type=int, default=1)
  parser.add_argument('--outstr', type=str, default='')
  args = parser.parse_args()

  mc = MetaCatClient()
  dc = DIDClient()

  routines = {
    'check_content':check_content,
  }
  routines[args.routine](args)
