import os
import json
import argparse
from rucio.client import Client
from rucio.client.accountclient import AccountClient
from rucio.client.rseclient import RSEClient

# Initialize the Rucio client
rseclient = RSEClient()
acc_client = AccountClient()

def get_rse_info():
    """
    Print detail info of each RSE only under dunepro
    """
    info = []
    rse_list = rseclient.list_rses()
    for r in rse_list:
        rse_att = rseclient.list_rse_attributes(r['rse'])
        rse_usage = rseclient.get_rse_usage(r['rse'])
        rse_acc_lim = acc_client.get_account_limits('dunepro', r['rse'], 'local') 
        rse_acc_usage = acc_client.get_local_account_usage('dunepro', r['rse']) 
        rse_lim = rseclient.get_rse_limits(r['rse'])
        # Quota is a policy limit which the system applies to an account
        # For storage accounting, Rucio accounts will only be accounted for the files they set replication rules on. 
        # The accounting is based on the replicas an account requested, not on the actual amount of physical replicas in the system
        acc_free = -999.0
        acc_lim = -999.0
        dunepro = False
        if rse_acc_lim[r['rse']]:
            acc_lim = rse_acc_lim[r['rse']]
            dunepro = True
        for acc in rse_acc_usage:
            acc_free = acc['bytes_remaining']
        date = ""
        files = -999
        total = -999.0
        decommissioned = False
        if 'decommissioned' in rse_att:
            decommissioned = rse_att['decommissioned'] 
        for u in rse_usage:
            if u['rse'] == r['rse'] and u['source'] == 'rucio':
                usage = u['used']
                date = json.dumps(u['updated_at'].strftime("%Y-%m-%d"))
                files = u['files']

        _info = {
            "name": r['rse'],
            "type": r['rse_type'],
            "account_lim": acc_lim/1.0e9,
            "account_free": acc_free/1.0e9,
            "rse_usage": usage/1.0e9,
            "nfiles": files,
            "date": date,
            "dunepro": dunepro,
            "decommissioned": decommissioned 
        }
        info.append(_info)
    return info

if __name__ == "__main__":

    parser = argparse.ArgumentParser()
    parser.add_argument('--out_put_file', type=str, help='name of the json file containing the information')
    args = parser.parse_args()

    info = get_rse_info()
    json = json.dumps(info)
    f = open(args.out_put_file, 'w')
    f.write(json)
    f.close()
