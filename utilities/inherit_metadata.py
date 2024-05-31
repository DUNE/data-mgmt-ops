from metacat.webapi import MetaCatClient
from argparse import ArgumentParser as ap
import json

required_keys = [
  "core.data_stream",
  "core.file_content_status",
  "core.file_type",
  "core.run_type",
  "core.runs",
  "core.runs_subruns",
  "dune.daq_test",
  "retention.status",
  "retention.class",
]

def check_md(req_keys, parent_md, parent_name):
  bad_keys = [rk for rk in req_keys if rk not in parent_md]
  if len(bad_keys) > 0:
    raise Exception( ##TODO -- better exception
      f'Error! The following required keys are missing from metadata of {parent_name}'
      '\n\t' + ', '.join(bad_keys)
    )

def get_parent_md(parent_name):
  mc = MetaCatClient()
  parent_file = mc.get_file(did=parent_name, with_metadata=True,
                            with_provenance=False)

  #TODO -- check

  parent_md = parent_file['metadata']
  check_md(required_keys, parent_md, parent_name)
  inherited_md = {rk:parent_md[rk] for rk in required_keys}
  return inherited_md

def inherit(parent_name):
  output = {
    'parents':[
      {'did':parent_name}
    ],
    'metadata':get_parent_md(parent_name),
  }
  return output

if __name__ == '__main__':
  parser = ap()
  parser.add_argument('--parent', '-p', type=str, required=True,
                      help='Parent file did (namespace:name)')
  parser.add_argument('--json', '-j', type=str, required=True,
                      help='Output json file')
  args = parser.parse_args()

  output = inherit(args.parent)


  # Serializing json
  json_object = json.dumps(output, indent=2)
   
  # Writing to sample.json
  with open(args.json, "w") as outfile:
    outfile.write(json_object)

