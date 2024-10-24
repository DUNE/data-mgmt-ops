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

# this is a list of non-official scopes or deprecated scopes
no_duneofficial =['ivm.A', 'mcc11', 'mcc10', 'dune', 'user.jperry', 'user.illingwo',
                'user.bjwhite', 'user.timm', 'test', 'wyuantest', 'user.wyuan', 'testpro',
                'dc4', 'dc4-vd-coldbox-bottom', 'dc4-vd-coldbox-top', 'dc4-hd-protodune',
                'dc4-output', 'amcnab_test', 'dc4-test', 'calcuttj_test', 'dc4-interactive-tests',
                'neardet', 'lbne', 'justin-logs', 'justin-tutorial'] 

def get_info(scope, datasets):
    """
    Get replication rule information for specified scopes or all.
    Args:
        scope (str): The Rucio scope.
        datasets (list): List of dataset names.
    Returns:
        list: List of dictionaries containing replication rule information for each scope.
    """
    info = []
    if scope is not None:
        scopes = [scope]
    else:
        scopes = scope_client.list_scopes()
    for scope in scopes:
        if scope in no_duneofficial:
            continue
        for mdata in rule_client.list_replication_rules({'scope': scope, }):
            #this does not work if there is no dataset
            if datasets:
                # check a given dataset/container
                if not mdata['name'] in datasets:
                    continue
            if mdata['state'] == 'SUSPENDED':
                continue
            files = did_client.list_content(scope, mdata['name'])
            total_size = 0
            n_files = 0
            for file_info in files:
                if file_info['type']!= 'FILE':
                    continue
                total_size += file_info['bytes']
                n_files += 1
            _info = {
                "scope": scope,
                "dataset": mdata['name'],
                "status": mdata['state'],
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
    parser.add_argument('--output_file', default='test.json', type=str, help='name of the json file containing the information')
    args = parser.parse_args()
    scope = args.scope
    datasets = []
    if args.datasets_file:
        with open(args.datasets_file) as file:
            while line := file.readline():
                did = line.replace('\n', '')
                name =did.split(":")[1]
                datasets.append(name)
    info = get_info(scope, datasets)
    json = json.dumps(info)
    f = open(args.output_file, 'w')
    f.write(json)
    f.close()
