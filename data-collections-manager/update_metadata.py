import sys
import json
import argparse
from metacat.webapi import MetaCatClient

def update_meta(query, metadata):
    """
    Updates the metadata for files returned by a given query.
    
    This function first retrieves a list of files based on the specified query.
    The user is then prompted to confirm the update operation, indicating the number
    of files that will be affected. For each file, its name is printed out.
    Parameters:
    - query (str): A query string used to search for files whose metadata needs updating.
    - metadata (dict): A dictionary containing the metadata to be applied to each file.
    """
    
    files = list(metacat.query(query))
    n_files = len(files)
    print('replace this metadata ',metadata)
    input(f"Do you want to continue? {n_files} files are going to be modified. Press Enter to continue with the process...")

    for f in files:
        print(f['name'])
        metacat.update_file(metadata=metadata, name=f['name'], namespace=f['namespace'])

if __name__ == "__main__":
    """
    Main script execution block.
    
    Initializes a MetaCatClient for interacting with a metadata catalog. Parses command line arguments
    for a query string and a JSON file containing metadata. The script performs an update of metadata
    for files matching the query after user confirmation.
    """
    metacat = MetaCatClient('https://metacat.fnal.gov:9443/dune_meta_prod/app')
    parser = argparse.ArgumentParser()
    parser.add_argument('--query', type=str, default=None, help='Metacat query e.g. "files where x=y"')
    parser.add_argument('--json', type=str, help='json file with metadata to be updated')
    args = parser.parse_args()

    if args.json is None or args.query is None:
        print("no json file, no query ...bye ")
        sys.exit(1)

    f = open(args.json, 'r')
    if f:
        metadata = json.load(f)
     
    update_meta(args.query, metadata) 
