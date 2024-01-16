import os
import json
import argparse
from rucio.client import Client
from rucio.client.accountclient import AccountClient

# Initialize the Rucio client
client = Client(account='dunepro')
acc_client = AccountClient()


def get_rse_info():
    """
    Print detail info of each RSE only under dunepro
    """
    info = []
    rse_list = client.list_rses()
    rses = acc_client.get_local_account_usage(account='dunepro')
    for r, rl in zip(rses, rse_list):
        date = json.dumps(rl['updated_at'].strftime("%Y-%m-%d"))
        _info = {
            "name": r['rse'],
            "type": rl['rse_type'],
            "total": r['bytes_limit']/1.0e9,
            "usage": r['bytes']/1.0e9,
            "free": r['bytes_remaining']/1.0e9,
            "nfiles": r['files'],
            "date": date
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
