import os
import sys
import argparse
import json
import requests
from metacat.webapi import MetaCatClient
from rucio.client.replicaclient import ReplicaClient
from rucio.common.exception import DataIdentifierNotFound

USER = os.getenv("USER")
metacat = MetaCatClient('https://metacat.fnal.gov:9443/dune_meta_prod/app', timeout=800)
replica = ReplicaClient(account=USER)

def get_files_from_metacat(query: str = None):
    """
    Retrieve a list of file names either from a MetaCat query or a local JSON file.

    Args:
        query (str): A MetaCat query string. If provided, files will be queried from MetaCat.
    Returns:
        List[str]: List of file names extracted from the source.
    """
    if query:
        files = list(metacat.query(query, with_metadata=False))
        return [f['name'] for f in files]
    else:
        raise ValueError("Provide either a MetaCat query or a JSON file path.")

def check_missing_rucio_replicas(file_list, scope, batch_size=1000):
    """
    Efficiently check which files are missing from Rucio by using batch list_replicas calls.

    Args:
        file_list (List[str]): List of file names to check.
        scope (str): Rucio scope.
        batch_size (int): Number of files to query per batch.

    Returns:
        List[str]: List of files not found or with no PFNs.
    """
    missing_files = []
    total_files = len(file_list)

    for i in range(0, total_files, batch_size):
        batch = file_list[i:i + batch_size]
        dids = [{'scope': scope, 'name': fname} for fname in batch]

        try:
            # list_replicas returns a generator
            for r in replica.list_replicas(dids):
                if not r.get('pfns'):  # No physical replicas found
                    missing_files.append(r['name'])
        except DataIdentifierNotFound:
            # If the entire batch failed, fallback to per-file check
            for fname in batch:
                try:
                    reps = replica.list_replicas([{'scope': scope, 'name': fname}])
                    if not any(r.get('pfns') for r in reps):
                        missing_files.append(fname)
                except DataIdentifierNotFound:
                    missing_files.append(fname)

    return missing_files

def build_dashboard_link(workflow_id: int, state: str):
    """
    Construct the DUNE dashboard link for viewing files by workflow.

    Args:
        workflow_id (int): The workflow ID number.
        stage_id (int): The stage ID (default: 1).
        state (str): File state filter (default: "notfound").

    Returns:
        str: Formatted URL pointing to the DUNE dashboard.
    """
    return DUNE_DASHBOARD_URL.format(workflow_id=workflow_id,state=state)

def get_files_from_dashboard(workflow_id: int, states: list, stage_id: int = 1):
    """
    Fetch and parse the list of file DIDs from the DUNE dashboard for a given workflow and multiple states.

    Args:
        workflow_id (int): The workflow ID to query.
        states (List[str]): List of file states (e.g., ['notfound', 'transferred']).
        stage_id (int): The stage ID to filter on (default: 1).

    Returns:
        List[str]: Combined list of file DIDs from all specified states.

    Raises:
        RuntimeError: If any dashboard request fails or format is unexpected.
    """
    all_files = []

    for state in states:
        RAL_url = (
            "https://justin.dune.hep.ac.uk/dashboard/"
            f"?method=download-file-states&workflow_id={workflow_id}"
            f"&stage_id={stage_id}&state={state}&format=json"
        )

        response = requests.get(RAL_url)
        if response.status_code != 200:
            raise RuntimeError(f"Failed to fetch JSON for state '{state}'. Status: {response.status_code}")

        data = response.json()
        if not isinstance(data, list):
            raise RuntimeError(f"Unexpected JSON format for state '{state}'")

        state_files = [entry["file_did"] for entry in data if "file_did" in entry]
        all_files.extend(state_files)

    return all_files

def main():
    """
    Parse command-line arguments, retrieve files, check Rucio replicas,
    and fetch justIN dashboard.
    """
    parser = argparse.ArgumentParser(description="Check MetaCat files against Rucio and fetch justIN dashboard.")
    parser.add_argument('--query', type=str, help="MetaCat query string to retrieve files.")
    parser.add_argument('--scope', type=str, help="scope/namespace.")
    parser.add_argument('--workflow', type=int, help="Workflow ID to fetch file list from DUNE dashboard.")
    parser.add_argument('--state', nargs='+', type=str, default=["notfound"], help="List of workflow states to fetch (e.g. notfound unallocated)")
    args = parser.parse_args()

    # Get files
    files = get_files_from_metacat(query=args.query)
    print(f"[INFO] Files retrieved from metacat: {len(files)}")
    if files:
        outputs_path = f"/pnfs/dune/scratch/users/{USER}/output_files_in_metacat_{args.workflow}.txt"
        with open(outputs_path, "w") as f:
            for fname in files:
                f.write(fname+"\n")
    # Check missing replicas
    missing = check_missing_rucio_replicas(files, args.scope)
    print(f"[INFO] Missing in Rucio: {len(missing)}")
    # Write missing files to output
    if missing: 
        retire_path = f"/pnfs/dune/scratch/users/{USER}/files_to_retire_{args.workflow}.txt"
        with open(retire_path, "w") as f:
            for fname in missing:
                f.write(fname + "\n")
        print(f"[INFO] Files with no replica  written to: {args.output}")

    # If workflow ID is provided, fetch and print files from dashboard
    if args.workflow:
        for state in args.state:
            state_files = get_files_from_dashboard(args.workflow, states=[state])

            # Save per-state file
            dashboard_path = f"/pnfs/dune/scratch/users/{USER}/to_recover_{args.workflow}_{state}.txt"
            with open(dashboard_path, "w") as df:
                for did in state_files:
                    df.write(did + "\n")

            print(f"[INFO] Files in dashboard (workflow {args.workflow}, state='{state}'): {len(state_files)}")
            print(f"[INFO] → Saved to: {dashboard_path}")
    total_files = len(files)-len(missing)
    print(f"[INFO] Total good files {total_files}")
if __name__ == "__main__":
    main()

