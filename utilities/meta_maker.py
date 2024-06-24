import place_metadata, get_events_for_md, inherit_metadata
from argparse import ArgumentParser as ap
import os
import json

if __name__ == '__main__':

  parser = ap()
  parser.add_argument('--file', '-f', required=True, type=str,
                      help="File did for which we're making metadata (namespace:name)",
                      )
  parser.add_argument('--get_events', action='store_true',
                      help='Get event numbers from artroot file')
  place_metadata.base_args(parser)
  parser.add_argument('--parent', '-p', default=None, type=str,
                      help='Parent DID to inherit from (namespace:name)\nOR parent json metadata (requires --parent_as_json)')
  parser.add_argument('--parent_as_json', action='store_true', help='') #TODO
  parser.add_argument('--json', '-j', required=True, type=str,
                      help='Output json name')
  args = parser.parse_args()

  base_md = place_metadata.make_md_from_args(args)

  output = {
    'name':args.file.split(':')[1],
    'namespace':args.file.split(':')[0],
    'metadata':base_md
  }

  if args.get_events:
    #Check that the file exists in this directoy
    if not os.path.isfile(output['name']):
      raise Exception(f'Want events but no file exists of name {output["name"]}')


    #get events from file
    events = get_events_for_md.get_events(output['name'])
    ##Put in metadta
    get_events_for_md.place_events(events, output['metadata'])

  if args.parent is not None:

    ##Get md from parent
    if args.parent_as_json:
      results = inherit_metadata.inherit_json(args.parent)
    else:
      results = inherit_metadata.inherit(args.parent)

    #place the inherited info in the output
    output['metadata'] |= results['metadata']

    #place the parent info
    output['parents'] = results['parents']

  ## Write the output
  output_json = json.dumps(output, indent=2)
  with open(args.json, 'w') as outfile:
    outfile.write(output_json)
