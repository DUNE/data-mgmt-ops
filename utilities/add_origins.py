from metacat.webapi import MetaCatClient
from argparse import ArgumentParser as ap
import json

def add_args(parser):
  parser.add_argument('--past_fcls', type=str, nargs='+')
  parser.add_argument('--past_apps', type=str, nargs='+')

def add_origins(args, version):
  if args.past_apps is None or len(args.past_fcls) != len(args.past_apps):
    raise ValueError('Need to provide same number of past apps and fcls')
  
  results = {
    'origin.applications.config_files': {
      args.past_apps[i]:args.past_fcls[i] for i in range(len(args.past_apps))
    },
    'origin.applications.versions': {
      args.past_apps[i]:version
      for i in range(len(args.past_apps))
    },
    'origin.applications.names':args.past_apps,
  }
  return results

if __name__ == '__main__':
  parser = ap()
  parser.add_argument('--json', '-j', type=str, required=True,
                      help='Output json file')
  add_origin_args(parser)
  args = parser.parse_args()

  output = add_origins(args, 'v1')

  # Serializing json
  json_object = json.dumps(output, indent=2)
   
  # Writing to sample.json
  with open(args.json, "w") as outfile:
    outfile.write(json_object)

