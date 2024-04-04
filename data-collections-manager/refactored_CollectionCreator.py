"""
Refactored CollectionCreator.py
author H. Schellman
modified by A. Higuera
for dunepro use only
"""
import sys
import os
import argparse
import json

from metacat.webapi import MetaCatClient


def make_name(tags):
    """
    Constructs a formatted name string (dataset name) based on specified metadata tags.
    Args:
        tags (dict): A dictionary containing metadata tags. Keys are tag names, and values
                     are the corresponding metadata values.
    Returns:
        str: A formatted name string constructed from the metadata tags.
    Notes:
        - The 'order' list defines the specific sequence of tags to be used in constructing the name.
        - Tags not present in the 'order' list or with None values are not included in the name.
        - This function is specifically designed for a set of metadata tags
    """
    order = ["core.run_type", "dune.campaign", "core.data_tier", "core.application.version",
             "dune.config_file", "dune_mc.gen_fcl_filename", "core.data_stream", "deftag"]
    name = ""
    for i in order:
        if i in tags and tags[i] is not None:
            new = tags[i]
            if i == "deftag":
                new = tags[i]
            name += new
            name += "__"
    name = name[:-2]
    name = name.replace('.fcl', '')
    return name


def makequery(meta, remove_from_query):
    """
    Constructs a query string based on the provided metadata.
    Args:
        meta (dict): A dictionary containing metadata key-value pairs.
        remove_from_query (list): A list of parameters to be removed in the query
    Returns:
        str: A query string constructed based on the provided metadata. The format of the query
        is 'files where key1=value1 and key2=value2 ...', excluding any keys with None values
        or without a period in the key name.
    Notes:
        - The function assumes that the input dictionary contains valid keys and values for
          constructing a query.
        - The function will skip keys that are None or do not contain a period.
        - String values containing a hyphen are enclosed in single quotes in the query.
    """
    query = "files where"
    for item in meta.keys():
        if item in remove_from_query:
            continue
        if "comment" in item:
            continue
        if meta[item] is None:
            continue
        if "." not in item:
            if "namespace" not in item:
               continue
        val = meta[item]
        if type(val) == str and "-" in val and "'" not in val:
            val = "\'%s\'" % val
        query += " "+item+"="+str(val)
        query += " and"
    query = query[:-4]
    return query


def makedataset(query, name, meta):
    """
    Creates a dataset in MetaCat using the provided query, name, and metadata.
    This function prepares metadata for dataset creation and then either creates a new dataset
    in MetaCat or reports if the dataset already exists.
    The dataset is created in the same namespace as the data it contains and is owned by 'dunepro'.
    Args:
        query (str): The query string used to define the dataset.
        name (str): The name of the dataset.
        meta (dict): The metadata dictionary for the dataset.
    Note:
        It assumes that the provided metadata contains a key 'core.run_type'
        used for namespace determination as agreed in the data management meeting on 2023/12/19.
    """
    cleanmeta = meta.copy()
    # move dataset creation flags into dataset....
    for x in meta.keys():
        if "." not in x:
            cleanmeta["datasetpar."+x] = meta[x]
            if x in cleanmeta:
                cleanmeta.pop(x)

    for x in meta.keys():
        if x not in cleanmeta:
            continue

        if meta[x] is None:
            if x in cleanmeta:
                cleanmeta.pop(x)
        else:
            cleanmeta[x] = meta[x]

    if os.getenv("USER") == "dunepro":
        namespace  = cleanmeta['core.run_type']
    else:
        namespace = os.getenv("USER")

    did = "%s:%s" % (namespace, name)
    test = metacat.get_dataset(did)

    if test is None:
        metacat.create_dataset(did, files_query=query,
                               description=query,
                               metadata=cleanmeta,
                               frozen=True)
    else:
        print("dataset already exist")

    print(f"MetaCat dataset: {did}")

def convert_size(size):
    """Converts a file size to a human-readable format with appropriate units."""
    for unit in ['B', 'KB', 'MB', 'GB', 'TB']:
        if size < 1024:
            return f"{size:.3f} {unit}"
        size /= 1024
    return f"{size:.3f} TB"  # Handles extremely large sizes


def print_summary(results):
    """Prints a summary of the results including the number of files and total size."""
    nfiles = len(results)
    total_size = sum(f.get("size", 0) for f in results)
    readable_size = convert_size(total_size)
    print(f"Files:       {nfiles}")
    print(f"Total size:  {readable_size}")


def setup():
    """
    Sets up the command-line argument parser and processes the arguments for the script.
    This function uses argparse to create a parser for command-line options. It defines several arguments:
    The function checks if the `--json` argument is provided and if the specified file exists.
    If the file does not exist, the script exits with an error message. If the file exists, it reads the
    metadata tags from the JSON file.
    Returns:
        tuple: A tuple containing the data description tags from the JSON file and the test mode flag.
    """
    parser = argparse.ArgumentParser()
    parser.add_argument('--json', type=str, default=None, help='filename for a json list of parameters to and')
    parser.add_argument('--min_time', type=str, help='min time range (inclusive) YYYY-MM-DD UTC')
    parser.add_argument('--max_time', type=str, help='end time range (inclusive) YYYY-MM-DD UTC')
    parser.add_argument('--deftag', type=str, default="test", help='tag to distinguish different runs of this script, default is test')
    parser.add_argument('--remove_from_query', type=lambda s: s.split(','), default=[], help='remove parameter(s) from query, parsed as list')
    parser.add_argument('--test', type=bool, default=False, const=True, nargs="?", help='do in test mode')
    xtratags = ["min_time", "max_time", "deftag"]
    args = parser.parse_args()

    if args.json is None:
        print("no json file, cannot generate a dataset")
        sys.exit(1)
    else:
        # read the data description tags from json file
        if not os.path.exists(args.json):
            print(args.json, 'does not exist, quitting')
            sys.exit(1)
        f = open(args.json, 'r')
        if f:
            metadata = json.load(f)
            for tag in xtratags:
                argis = tag
                val = getattr(args, argis)
                metadata[tag] = val
                if type(val) == 'str' and "-" in val:
                    metadata[tag] = "\'%s\'" % (val)

        return metadata, args

if __name__ == "__main__":
    # This block will run if the script is executed directly.
    # It initializes the parser and processes command line arguments.
    metacat = MetaCatClient('https://metacat.fnal.gov:9443/dune_meta_prod/app')
    metadata, args = setup()
    thequery = makequery(metadata, args.remove_from_query)
    dataset_name = make_name(metadata)
    metacat_files = list(metacat.query(thequery))
    if not metacat_files:
        print("===> MetaCat query return 0 files")
    print("MetaCat query \"", thequery, "\"\n")
    print(dataset_name)
    print_summary(metacat_files)
    if not args.test:
        makedataset(thequery, dataset_name, metadata)
