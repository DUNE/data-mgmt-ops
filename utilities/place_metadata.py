import json
from argparse import ArgumentParser as ap

def make_md_from_args(args):
  md = {
    'core.file_format':args.file_format,
    'core.application.name':args.app_name,
    'core.application.family':args.app_family,
    'core.application.version':args.app_version,
    'core.data_tier':args.data_tier,
  }

  if args.start_time is not None:
    md['core.start_time'] = args.start_time
    md['core.end_time'] = args.end_time
  return md

def base_args(parser):
  parser.add_argument('--start_time', default=None,)
  parser.add_argument('--end_time', default=None,)
  parser.add_argument('--file_format', type=str)
  parser.add_argument('--app_family', type=str)
  parser.add_argument('--app_name', type=str)
  parser.add_argument('--app_version', type=str)
  parser.add_argument('--data_tier', type=str)

if __name__ == '__main__':
  parser = ap()
  parser.add_argument('--json', '-j', type=str, help='Output JSON file')
  base_args(parser)
  args = parser.parse_args()
