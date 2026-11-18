import sys
import os
import argparse
import json
import hashlib

from rucio.client import Client
from rucio.common.exception import DataIdentifierNotFound

client = Client(account=os.getenv("USER"))

# Most Linux filesystems cap a single file name at 255 bytes (NAME_MAX).
# Rucio container names can be longer than that, so the log name is shortened.
MAX_FILENAME_BYTES = 255


def make_log_filename(container_name, suffix='_rucio_rules.log'):
    """
    Build a log file name from the container name that fits within the
    filesystem's file name limit.

    If container_name + suffix fits, it is used unchanged. Otherwise the
    container name is truncated and a short hash of the full name is appended,
    so the name stays unique and readable.
    """
    filename = container_name + suffix
    if len(filename.encode('utf-8')) <= MAX_FILENAME_BYTES:
        return filename

    digest = hashlib.sha1(container_name.encode('utf-8')).hexdigest()[:10]
    tail = '__' + digest + suffix
    keep = MAX_FILENAME_BYTES - len(tail.encode('utf-8'))
    prefix = container_name.encode('utf-8')[:keep].decode('utf-8', 'ignore')
    return prefix + tail


def add_replication_rule(container_name, scope, rse, copies=1):
    """
    Adds replication rules for datasets within a specified Rucio container.

    This function queries a Rucio container for all contained datasets and
    attempts to add a replication rule for each one to a specified RSE
    The function logs each attempt, including successes and failures,
    to a specified output file and prints them to the console.

    Parameters:
    - container_name (str): The name of the Rucio container containing the datasets.
    - scope (str): The scope of the Rucio container.
    - rse (str): The RSE expression where the data should be replicated.
    - copies (int, optional): The number of copies to replicate. Defaults to 1.
    """
   
    output_file = make_log_filename(container_name)
    with open(output_file, 'w') as file:  # Open a file to log the outputs
        # Record the full container name, since the file name may be shortened
        file.write(f"Container: {scope}:{container_name}\n")
        file.write(f"RSE: {rse}\n")
        try:
            # Get all contents of the container
            contents = client.list_content(scope=scope, name=container_name)

            # Iterate through the contents
            for content in contents:
                did = {'scope': content['scope'], 'name': content['name']}
                # Add rule only if the content type is dataset
                if content['type'] == 'DATASET':
                    try:
                        # Adding replication rule
                        rule_id = client.add_replication_rule([did], copies, rse)
                        output = f"Rule added with ID: {rule_id[0]} for {did}"
                        print(output)
                        file.write(output + '\n')  # Write to file
                    except Exception as e:
                        error_msg = f"Failed to add rule for {did}: {str(e)}"
                        print(error_msg)
                        file.write(error_msg + '\n')
        except DataIdentifierNotFound:
            error_msg = f"The container {container_name} not found in scope {scope}"
            print(error_msg)
            file.write(error_msg + '\n')
        except Exception as e:
            error_msg = f"An error occurred: {str(e)}"
            print(error_msg)
            file.write(error_msg + '\n')

if __name__ == "__main__":

    parser = argparse.ArgumentParser()
    parser.add_argument('--container', type=str, default=None, help='container name')
    parser.add_argument('--scope',  type=str, default=None, help='scope or metacat namespace')
    parser.add_argument('--rse',  type=str, default=None, help='target RSE')

 
    args = parser.parse_args()
    if args.container is None:
        print("provide info")
        sys.exit(1)
 
    add_replication_rule(args.container, args.scope, args.rse) 
