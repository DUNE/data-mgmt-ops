"""
Rucio Data Information Collector

This script collects information about replication rules and related
data for given datasets from the Rucio system.
It generates a JSON file containing the collected information.

"""

from rucio.client.replicaclient import ReplicaClient
from rucio.client.ruleclient import RuleClient
from rucio.client.client import Client
from rucio.client.didclient import DIDClient
from rucio.client.scopeclient import ScopeClient
import json
import datetime
import argparse
import sys

did_client = DIDClient()
rule_client = RuleClient()
client = Client(account="dunepro")
scope_client = ScopeClient()


def get_info(scope, datasets):
    """
    Get replication rule information for specified datasets.
    Args:
        scope (str): The Rucio scope.
        datasets (list): List of dataset names.
    Returns:
        list: List of dictionaries containing replication rule information for each dataset.
    """
    info = []
    if scope is not None:
        scopes = [scope]

    for scope in scopes:
        for mdata in rule_client.list_replication_rules({'scope': scope}):
            if datasets:
                # check a given dataset/container
                if not mdata['name'] in datasets:
                    continue
            if mdata['state'] != 'OK':
                continue
            files = did_client.list_files(scope, mdata['name'])
            total_size = 0
            n_files = 0
            for file_info in files:
                total_size += file_info['bytes']
                n_files += 1
            _info = {
                "scope": scope,
                "dataset": mdata['name'],
                "catalog": "rucio",
                "did": mdata["id"],
                "did_type": mdata["did_type"],
                "site": mdata["rse_expression"],
                "created_at": mdata["created_at"].strftime("%Y-%m-%d %H:%M:%S"),
                "updated_at": mdata["updated_at"].strftime("%Y-%m-%d %H:%M:%S"),
                "size": total_size/1.0e9, #  convert to GB
                "n_files": n_files
            } 
            info.append(_info)
    return info

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument('--scope', type=str, help='If scope is not specify, it would look at every scope in rucio')
    parser.add_argument('--datasets_file', type=str, help='file with datasets list')
    parser.add_argument('--out_put_file', default='test.sjon', type=str, help='name of the json file containing the information')
    args = parser.parse_args()
    scope = args.scope
    if not scope:
        print("must provide a scope")
        sys.exit(0)
    datasets = []
    if args.datasets_file:
        with open(args.datasets_file) as file:
            while line := file.readline():
                d = line.replace('\n', '')
                datasets.append(d)

    info = get_info(scope, datasets)
    json = json.dumps(info)
    f = open(args.out_put_file, 'w')
    f.write(json)
    f.close()
