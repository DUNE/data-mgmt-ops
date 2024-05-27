from MetaChecker_clean import get_metacat_query_results, mc_client, only_check_start_end_times, only_check_subruns, do_update_metadata
from argparse import ArgumentParser as ap


if __name__ == '__main__':
  parser = ap()
  parser.add_argument('--mql', type=str, help='MQL Query', required=True)
  parser.add_argument('--dry_run', action='store_true')
  parser.add_argument('--verbose', '-v', action='store_true')
  args = parser.parse_args()

  def vprint(*line):
    if args.verbose: print(*line)
    else: pass

  results = get_metacat_query_results(mc_client=mc_client, testquery=args.mql)
  to_update = []
  for i, f in enumerate(results):
    if not args.verbose:
      if (not i % 1000): print(f'{i}', end='\r')
    vprint(f['fid'])
    
    vprint('Checking start end times')
    update_times = only_check_start_end_times(mc_client, f['fid'], f['metadata'], args.verbose)
    vprint(update_times)
    vprint('Start time:', f['metadata']['core.start_time'], type(f['metadata']['core.start_time']))
    vprint('End time:', f['metadata']['core.end_time'], type(f['metadata']['core.end_time']))

    vprint()
    vprint('Checking subruns')
    update_subruns = only_check_subruns(mc_client, f['fid'], f['metadata'], args.verbose)
    vprint(update_subruns)
    vprint(f['metadata']['core.runs_subruns'])

    to_update.append((f['fid'], f['metadata']))
    if update_subruns or update_times:
      if args.dry_run:
        vprint('Will update', f['metadata'])
      else:
        do_update_metadata(mc_client, f['fid'], f['metadata'])
