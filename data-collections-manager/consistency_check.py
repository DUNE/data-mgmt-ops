import sys
import os
import json
import argparse
from datetime import datetime
from itertools import chain
from rucio.client import Client
from metacat.webapi import MetaCatClient

rucio_client = Client(account=os.getenv("USER"))
metacat_client = MetaCatClient('https://metacat.fnal.gov:9443/dune_meta_prod/app', timeout=1000)

def fetch_metacat_dids(metacat_client, namespace, batch_size=5000):
    """
    Fetch all files from MetaCat using batch to avoid timeouts
    """
    metacat_files = {}
    offset = 0
    query = f"files where namespace={namespace}"                                         
    print(f"  Fetching MetaCat ")

    start_time = datetime.now()
    # DB was indexed, it was suggested no to include batch_size
    try:
        batch = list(metacat_client.query(query)) 

    except Exception as e:
        elapsed = datetime.now() - start_time
        print(f"  [{datetime.now().isoformat()}] Error querying MetaCat after {elapsed}: {e}")
        batch = [] 
    for file_info in batch:
                file_name = file_info['name']
                created_at = file_info['created_timestamp']
                metacat_files[file_name] = {
                   'created_at': datetime.fromtimestamp(created_at).isoformat(),
                   'rucio_check': False,
                   'metacat_check': True
                }

    print(f"    Retrieved {len(batch)} files (cumulative: {len(metacat_files)})") 
    
    return metacat_files
def do_did_consistency(namespace):
    """
    Check consistency of all DIDs (files) between Rucio and MetaCat
    """
    results = []
    
    print(f"Fetching DIDs from Rucio for scope: {namespace}")
    # Get all files from Rucio for this scope
    rucio_dids = {}
    datasets = rucio_client.list_dids(scope=namespace, filters={'type': 'DATASET'}, long=True)
    containers = rucio_client.list_dids(scope=namespace, filters={'type': 'CONTAINER'}, long=True)
    files = rucio_client.list_dids(scope=namespace, filters={'type': 'FILE'}, long=True) 
    for did in chain(files, datasets, containers):
        did_name = did['name']
        rucio_dids[did_name] = {
            'created_at': did.get('created_at'),
            'bytes': did.get('bytes'),
            'rucio_check': True,
            'metacat_check': False,
            'did_type': did.get('did_type')
        }
    print(f"Found {len(rucio_dids)} DIDs in Rucio")
    
    print(f"Fetching files from MetaCat for namespace: {namespace}")
    # Get all files from MetaCat for this namespace

    metacat_files = {}
    metacat_files = fetch_metacat_dids(metacat_client, namespace)
    print(f"Found {len(metacat_files)} DIDs in MetaCat")
    
    # Combine results - files in both systems
    all_dids = set(rucio_dids.keys()) | set(metacat_files.keys())
    
    for did_name in all_dids:
        entry = {
            'name': did_name,
            'scope': namespace,
            'type': rucio_dids.get(did_name, {}).get('did_type'),
            'created_at': None,
            'rucio_check': did_name in rucio_dids,
            'metacat_check': did_name in metacat_files
        }
        
        # Use Rucio creation date if available, otherwise MetaCat
        if did_name in rucio_dids:
            entry['created_at'] = str(rucio_dids[did_name].get('created_at', ''))
            entry['bytes'] = rucio_dids[did_name].get('bytes')
        elif did_name in metacat_files:
            entry['created_at'] = str(metacat_files[did_name].get('created_at', ''))
        
        results.append(entry)
    
    # Generate summary statistics
    summary = {
        'namespace': namespace,
        'type': 'DID',
        'total_count': len(all_dids),
        'in_both': sum(1 for r in results if r['rucio_check'] and r['metacat_check']),
        'rucio_only': sum(1 for r in results if r['rucio_check'] and not r['metacat_check']),
        'metacat_only': sum(1 for r in results if not r['rucio_check'] and r['metacat_check']),
        'timestamp': datetime.now().isoformat()
    }

    # Breakdown by DID type (FILE, DATASET, CONTAINER, None for metacat-only)
    did_types = set(r['type'] for r in results)
    by_type = {}
    for dtype in sorted(did_types, key=lambda x: (x is None, str(x))):
        type_results = [r for r in results if r['type'] == dtype]
        label = dtype if dtype else 'UNKNOWN'
        by_type[label] = {
            'total': len(type_results),
            'in_both': sum(1 for r in type_results if r['rucio_check'] and r['metacat_check']),
            'rucio_only': sum(1 for r in type_results if r['rucio_check'] and not r['metacat_check']),
            'metacat_only': sum(1 for r in type_results if not r['rucio_check'] and r['metacat_check']),
        }
    summary['by_type'] = by_type

    return {'summary': summary, 'details': results}


def do_dataset_consistency(namespace):
    """
    Check consistency of all datasets between Rucio and MetaCat
    """
    
    results = []
    
    print(f"Fetching datasets from Rucio for scope: {namespace}")
    # Get all datasets from Rucio for this scope
    rucio_datasets = {}
    datasets = rucio_client.list_dids(scope=namespace, filters={'type': 'DATASET'}, long=True)
    containers = rucio_client.list_dids(scope=namespace, filters={'type': 'CONTAINER'}, long=True)
    for did in chain(datasets, containers):
        dataset_name = did['name']
        rucio_datasets[dataset_name] = {
            'type': did.get('did_type'), 
            'created_at': did.get('created_at'),
            'bytes': did.get('bytes'),
            'length': did.get('length'),  # number of files
            'rucio_check': True,
            'metacat_check': False
        }
    
    print(f"Found {len(rucio_datasets)} datasets in Rucio")
    
    print(f"Fetching datasets from MetaCat for namespace: {namespace}")
    # Get all datasets from MetaCat for this namespace
    metacat_datasets = {}
    try:
        # Adjust based on MetaCat API
        for dataset_info in metacat_client.list_datasets(namespace_pattern=namespace):
            dataset_name = dataset_info['name']
            created_at = dataset_info['created_timestamp']
            metacat_datasets[dataset_name] = {
                'created_at': datetime.fromtimestamp(created_at).isoformat(),
                'rucio_check': False,
                'metacat_check': True
            }
    except Exception as e:
        print(f"Error fetching from MetaCat: {e}")
        metacat_datasets = {}
    
    print(f"Found {len(metacat_datasets)} datasets in MetaCat")
    
    # Combine results - datasets in both systems
    all_datasets = set(rucio_datasets.keys()) | set(metacat_datasets.keys())
    
    for dataset_name in all_datasets:
        entry = {
            'name': dataset_name,
            'scope': namespace, 
            'did' : namespace+":"+dataset_name,
            'type': None,
            'created_at': None,
            'rucio_check': dataset_name in rucio_datasets,
            'metacat_check': dataset_name in metacat_datasets
        }
        
        # Use Rucio creation date if available, otherwise MetaCat
        if dataset_name in rucio_datasets:
            entry['created_at'] = str(rucio_datasets[dataset_name].get('created_at', ''))
            entry['bytes'] = rucio_datasets[dataset_name].get('bytes')
            entry['length'] = rucio_datasets[dataset_name].get('length')
            entry['type'] = rucio_datasets[dataset_name].get('type')
        elif dataset_name in metacat_datasets:
            entry['created_at'] = str(metacat_datasets[dataset_name].get('created_at', ''))
            entry['type'] = 'DATASET' 
        results.append(entry)
    
    # Generate summary statistics
    summary = {
        'namespace': namespace,
        'type': 'DATASET',
        'total_count': len(all_datasets),
        'in_both': sum(1 for r in results if r['rucio_check'] and r['metacat_check']),
        'rucio_only': sum(1 for r in results if r['rucio_check'] and not r['metacat_check']),
        'metacat_only': sum(1 for r in results if not r['rucio_check'] and r['metacat_check']),
        'timestamp': datetime.now().isoformat()
    }
    
    return {'summary': summary, 'details': results}


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Check consistency between Rucio and MetaCat')
    parser.add_argument('--namespace', type=str, required=True, help='MetaCat namespace / Rucio scope')
    parser.add_argument('--object', type=str, required=True, choices=['did', 'dataset'], 
                        help='Check type: "did" for files or "dataset" for datasets')
    parser.add_argument('--output', type=str, default=None, 
                        help='Output JSON file path (default: consistency_<object>_<namespace>.json)')
    
    args = parser.parse_args()
    
    # Determine output filename
    if args.output is None:
        args.output = f"consistency_{args.object}_{args.namespace}_{datetime.now().strftime('%Y%m%d_%H%M%S')}.json"
    
    # Run appropriate consistency check
    print(f"\n{'='*60}")
    print(f"Starting {args.object.upper()} consistency check for namespace: {args.namespace}")
    print(f"{'='*60}\n")
    
    if args.object == 'did':
        result = do_did_consistency(args.namespace)
    elif args.object == 'dataset':
        result = do_dataset_consistency(args.namespace)
    else:
        print(f"Error: Invalid object type '{args.object}'. Use 'did' or 'dataset'")
        exit(1)
    
    # Write results to JSON file
    with open(args.output, 'w') as f:
        json.dump(result, f, indent=2)
    
    # Print summary
    print(f"\n{'='*60}")
    print("CONSISTENCY CHECK SUMMARY")
    print(f"{'='*60}")
    print(f"Namespace: {result['summary']['namespace']}")
    print(f"Type: {result['summary']['type']}")
    print(f"Total items: {result['summary']['total_count']}")
    print(f"In both catalogs: {result['summary']['in_both']}")
    print(f"Rucio only: {result['summary']['rucio_only']}")
    print(f"MetaCat only: {result['summary']['metacat_only']}")

    if 'by_type' in result['summary']:
        print(f"\n  {'Breakdown by DID type':}")
        print(f"  {'-'*50}")
        print(f"  {'Type':<12} {'Total':>8} {'Both':>8} {'Rucio':>8} {'MetaCat':>8}")
        print(f"  {'-'*50}")
        for dtype, counts in result['summary']['by_type'].items():
            print(f"  {dtype:<12} {counts['total']:>8} {counts['in_both']:>8} {counts['rucio_only']:>8} {counts['metacat_only']:>8}")
        print(f"  {'-'*50}")

    print(f"\nResults saved to: {args.output}")
    print(f"{'='*60}\n")
