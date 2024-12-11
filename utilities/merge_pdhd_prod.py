from metacat.webapi import MetaCatClient
mc = MetaCatClient()

from rucio.client.replicaclient import ReplicaClient
rc = ReplicaClient()

from argparse import ArgumentParser as ap

def query_wf(args, w, tier='full-reconstructed', run=None, md=False):
    query = (
        f'files where dune.workflow["workflow_id"] in ({",".join(w)}) '
        f'and core.data_tier={tier} '
        'and dune.output_status=confirmed '
        'and core.data_stream in (physics, cosmics)'
    )
    if run is not None:
        query += f' and core.runs={run}'
    # print(query)
    return mc.query(
        query,
        with_metadata=md,
    )

def get_runs(args):
    with open(args.i, 'r') as f:
        lines = f.readlines()
    lines = [l.strip() for l in lines]
    
    all_runs = {}
    all_wfs = {}

    for w in lines:
        print('Getting', w)
        res = query_wf(args, [w], tier='root-tuple-virtual', md=True)
        for f in res:
            run = str(f['metadata']['core.runs'][0])
            if w not in all_runs:
                all_runs[w] = []
            if run not in all_wfs:
                all_wfs[run] = []
            
            all_runs[w].append(run)
            all_wfs[run].append(w)

    output = [
        f'{w}:' + ','.join(set(runs)) + '\n'
        for w,runs in all_wfs.items()
    ]
    with open(args.o, 'w') as fout:
        fout.writelines(output)

def get_paths(args):
    with open(args.i, 'r') as f:
        lines = f.readlines()
    lines = [l.strip().split(':') for l in lines if l[0] != '#']
    runs_to_workflows = {l[0]:l[1].split(',') for l in lines}
    import math
    for r,wfs in runs_to_workflows.items():
        res = query_wf(args, wfs, run=r, tier='root-tuple-virtual')
        
        files = [r for r in res]
        nsplits = math.ceil(len(files)/1000)
        splits = [files[i::nsplits] for i in range(nsplits)]

        print(r, len(files))
        print(r, [len(s) for s in splits])
        
        with open(args.o + f'_{r}_paths.txt', 'w') as fout:
            print('Writing to', fout.name)
            for i, split in enumerate(splits):
                print('\tSplit', i/len(splits), f'[{len(split)}]')
                reps = rc.list_replicas([{'scope':'hd-protodune-det-reco', 'name':f['name']} for f in split],
                                        rse_expression='DUNE_US_FNAL_DISK_STAGE')
                for r in reps:
                    if len(list(r['pfns'].keys())) == 0:
                        print('\tWarning: skipping file with no pfn')
                        continue
                    fout.write(list(r['pfns'].keys())[0] + '\n')



if __name__ == '__main__':

    parser = ap(description='check by run or workflow')
    parser.add_argument('routine', type=str, choices=[
        'get_runs', 'get_paths',
    ])
    parser.add_argument("-i", help='File containing input -- either workflwos, or map of run:[workflows]', type=str)
    parser.add_argument('--debug', help='make very verbose', action='store_true')
    parser.add_argument('-o', type=str, default=None)
    args = parser.parse_args()

    routines = {
        'get_runs':get_runs,
        'get_paths':get_paths,
    }
    routines[args.routine](args)
