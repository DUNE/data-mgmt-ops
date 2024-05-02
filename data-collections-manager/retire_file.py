import sys
import os
import argparse
import json

from metacat.webapi import MetaCatClient

def retire(query):
    """
    Retire files based on a given query.

    This function queries a metadata catalog for files matching the specified query, 
    prompts the user to confirm retirement of the found files, and then retires each file by marking
    it as retired in the metadata catalog.

    Parameters:
    - query (str): The query string used to search for files in the metadata catalog.

    Notes:
    - The user is prompted to confirm the retirement process after being shown the number of files.
    """
    files = list(metacat.query(query))
    n_files = len(files)
    input(f"Do you want to continue? {n_files} files are going to be retired. Press Enter to continue with the process...")

    for f in files:
        print(f['name'])
        metacat.retire_file(name=f['name'], namespace=f['namespace'])


if __name__ == "__main__":
    # This block will run if the script is executed directly.
    # It initializes the parser and processes command line arguments.
    metacat = MetaCatClient('https://metacat.fnal.gov:9443/dune_meta_prod/app')
    parser = argparse.ArgumentParser()
    parser.add_argument('--query', type=str, default=None, help='Metacat query e.g. "files where x=y"')
    args = parser.parse_args()
    if args.query is None:
        print("provide query")
        sys.exit(1)
 
    retire(args.query) 
