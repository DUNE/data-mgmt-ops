from MetaChecker_clean import get_metacat_query_results, mc_client, only_check_start_end_times, only_check_subruns, do_update_metadata
from argparse import ArgumentParser as ap
import time


def strip_metadata(metadata,
                   to_keep=[
                     'core.runs_subruns',
                     'core.start_time',
                     'core.end_time',
                   ]):
  results = {
    tk:metadata[tk] for tk in to_keep
  }
  return results

if __name__ == '__main__':
  parser = ap()
  parser.add_argument('--mql', type=str, help='MQL Query', required=True)
  parser.add_argument('--dry_run', action='store_true')
  parser.add_argument('--verbose', '-v', action='store_true')
  parser.add_argument('--check_every', type=int, default=1000)
  #parser.add_argument('--pause_every', type=int, default=300)
  args = parser.parse_args()

  def vprint(*line):
    if args.verbose: print(*line)
    else: pass

  results = get_metacat_query_results(mc_client=mc_client, testquery=args.mql)
  #to_update = []
  t0 = time.time()
  for i, f in enumerate(results):
    if (not i % args.check_every) and not args.verbose: 
      t1 = time.time()
      print(f'{i}, {t1 - t0:.2f}')#, end='\r')
      t0 = t1
    #if (i > 0 and not i % args.pause_every):
    #  print('Pausing')
    #  time.sleep(10)
    #  print('Done')
    vprint(f['fid'])
    
    vprint('Checking start end times')
    update_times = only_check_start_end_times(mc_client, f['fid'], f['metadata'],
                                              args.verbose)
    vprint(update_times)
    vprint('Start time:', f['metadata']['core.start_time'],
           type(f['metadata']['core.start_time']))
    vprint('End time:', f['metadata']['core.end_time'],
           type(f['metadata']['core.end_time']))

    vprint()
    vprint('Checking subruns')
    update_subruns = only_check_subruns(mc_client, f['fid'], f['metadata'],
                                        args.verbose)
    vprint(update_subruns)
    vprint(f['metadata']['core.runs_subruns'])

    #f['metadata'] = strip_metadata(f['metadata'])
    #print(f['metadata'])

    #to_update.append((f['fid'], f['metadata']))
    if update_subruns or update_times:
      if args.dry_run:
        vprint('Will update', f['metadata'])
      else:
        try:
          do_update_metadata(mc_client, f['fid'], f['metadata'])
        except Exception as err:
          raise Exception(f'Failed to parse file {i} from query') from err
