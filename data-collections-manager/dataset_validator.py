import os
import sys
import argparse

from metacat.webapi import MetaCatClient
from rucio.client.client import Client

client = Client(account=os.getenv("USER"))
def validator(dataset):

    # why metacat.get_dataset_files does not provide provenance? 
    # report this 
    data = metacat.get_dataset_files(dataset, with_metadata=True)
    files = metacat.get_files(data, with_metadata=True, with_provenance=True)
    input_files = []
    duplicates = []
    no_replicas = []
    n_files = len(list(files))
    print(f'Analyzing {n_files} files')
    idx = 0
    for f in files:
        replicas = list(client.list_replicas([{'scope': f['namespace'], 'name': f['name']}]))
        if f['metadata']['dune.output_status'] != 'confirmed':
           continue
        if not any(replicas):
           no_replicas.append(f['name'])
        if f['parents']:
            for parent in f['parents']:
                if parent['fid'] in input_files:
                    duplicates.append(f['name'])
                else:
                    input_files.append(parent['fid'])

        else:
            print("check this file is missing provenance")
            print(f['name'])
        idx +=1

    print(f'This is the number of confirmed files: {idx}')
    print(f'This is the list of files with no replicas: {no_replicas}')
    print(f'This is the list of duplicate files: {duplicates}')
def setup():

    parser = argparse.ArgumentParser()
    parser.add_argument('--dataset', type=str, default=None, help='namescope:name dataset to check')
    args = parser.parse_args()

    if args.dataset is None:
        print("no dataset")
        sys.exit(1)
 
    return args.dataset

if __name__ == "__main__":
    metacat = MetaCatClient('https://metacat.fnal.gov:9443/dune_meta_prod/app')
    dataset = setup()
    validator(dataset)   
