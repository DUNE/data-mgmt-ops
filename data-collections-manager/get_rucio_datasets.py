import argparse
from rucio.client import Client
client = Client()

def get_parent_did(did):
    """
    Retrieve the parent DID (must be a dataset) of the given file DID.
    
    Parameters:
        did (str): The DID of the file.
    
    Returns:
        str: The parent dataset DID if found, otherwise None.
    """
    scope, name = did.split(':')  # Split scope and name
    try:
        for parent in client.list_parent_dids(scope, name):
            if parent['type'] == 'DATASET':  # Ensure the parent is a dataset
                return f"{parent['scope']}:{parent['name']}"
    except Exception as e:
        print(f"Error retrieving parent for {did}: {e}")
    return None

def process_dids(input_file, output_file):
    """
    Read DIDs from a file, get unique parent DIDs, and save them to an output file.
    
    Parameters:
        input_file (str): Path to the text file containing file DIDs.
        output_file (str): Path to the output text file to store unique parent DIDs.
    """
    parent_DIDs_list = set()  # Use a set to store unique values

    with open(input_file, 'r') as file:
        for line in file:
            did = line.strip()  # Remove whitespace/newlines
            print(did)
            if did:
                parent_did = get_parent_did(did)
                if parent_did:
                    parent_DIDs_list.add(parent_did)  # Store only unique entries

    # Write unique parent DIDs to the output file
    with open(output_file, 'w') as out_file:
        for parent_did in sorted(parent_DIDs_list):  # Sort for better readability
            out_file.write(parent_did + '\n')

    print(f"Saved {len(parent_DIDs_list)} unique parent DIDs to {output_file}")

# Setup argument parsing
if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Retrieve unique parent dataset DIDs from a list of file DIDs in Rucio.")
    parser.add_argument("input_file", help="Path to the text file containing file DIDs.")
    parser.add_argument("output_file", help="Path to the output file to save unique parent DIDs.")
    args = parser.parse_args()

    # Run processing
    process_dids(args.input_file, args.output_file)
