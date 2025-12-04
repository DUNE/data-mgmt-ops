Last login: Thu Dec  4 10:46:10 on ttys000
ah84@FKWL2K9VYK ~ % dune12
                              NOTICE TO USERS

       This  is a Federal computer (and/or it is directly connected to a
       Fermilab local network system) that is the property of the United
       States Government.  It is for authorized use only.  Users (autho-
       rized or unauthorized) have no explicit or  implicit  expectation
       of privacy.

       Any  or  all uses of this system and all files on this system may
       be intercepted, monitored, recorded,  copied, audited, inspected,
       and  disclosed  to authorized site, Department of Energy  and law
       enforcement personnel, as  well as authorized officials of  other
       agencies,  both  domestic and foreign.  By using this system, the
       user consents to such interception, monitoring, recording,  copy-
       ing,  auditing,  inspection,  and disclosure at the discretion of
       authorized site or Department of Energy personnel.

       Unauthorized or improper use of this system may result in  admin-
       istrative  disciplinary  action and civil and criminal penalties.
       By continuing to use this system you indicate your  awareness  of
       and  consent to these terms and conditions of use.  LOG OFF IMME-
       DIATELY if you do not agree to  the  conditions  stated  in  this
       warning.

       Fermilab  policy  and  rules for computing, including appropriate
       use, may be found at http://www.fnal.gov/cd/main/cpolicy.html
Last login: Wed Dec  3 15:39:14 2025 from 168.5.13.134
                           === Autokernel Notice ===                            

   This machine is scheduled to automatically reboot into the newest released   
  kernel version during our regularly scheduled third-Wednesday downtime.  If   
    this is a problem, please contact your CS Liaison and ask them to open a    
                  ticket with SSI in Service Now.  Thank you!                   
------------------------------------------------------------------------------
                     ..::Powered by SCF-SSI::..                      

   Hostname: dunegpvm12.fnal.gov         OS Release: Alma Linux 9.7            
         IP: 131.225.161.72                  Subnet: 255.255.255.0             

     Kernel: 5.14.0-611.5.1                    Arch: x86_64                    
        RAM: 11.43 GiB                         Swap: 2.00 GiB                  
      Cores: 4                              Virtual: kvm                       

 SSH Logins: 2                             Load Avg: 1.15 0.75 0.36            

       Help: https://ssiwiki.fnal.gov/wiki/Interactive_Server_Facility         
------------------------------------------------------------------------------
c<dunegpvm12.fnal.gov> cd /exp/dune/app/users/higuera/
<dunegpvm12.fnal.gov> ls
atmo_test  data_manager   DQM           dunereco_dev.tar  justin_logs     old_stuff  opticks_sim  test
CNN        data-mgmt-ops  dunereco_dev  justin            my_duneana.tar  opticks    srcs
<dunegpvm12.fnal.gov> cd data-mgmt-ops/data-collections-manager/
<dunegpvm12.fnal.gov> ls
add_rule.py           dcm_scopes_info_old.py      get_names.sh                     retire_file.py
atmo1_reco_bad.npy    dcm_scopes_info.py          get_parent_datasets.py           run_update_meta.sh
attach_pair.sh        dcm_scopes_unique_did.py    get_rucio_datasets.py            run_workflow_report.sh
check_files_list.py   detach_file_by_lookup.py    log                              temp_validator.py
check_meta.py         detach_file_no              log_ds                           throughput.py
check_replicas.py     detach_new.sh               oldcompare.py                    unique_rucio.py
compare.py            detach.sh                   old.py                           unretire.sh
container.py          did_rules_report.py         plot_event_rates.py              update_metadata.py
dataset_metacat.sh    fetch_justIN_dashboard.py   quick_validator.py               workflow_report.py
data_set_replicas.py  fetch_official_datasets.py  README.md
dataset_validator.py  find_dark_data.py           refactored_CollectionCreator.py
dcm_rucio_rses.py     get_datasets.py             retire_atmo_files.py
<dunegpvm12.fnal.gov> vi get_rucio_datasets.py 
<dunegpvm12.fnal.gov> vi get_parent_datasets.py 
<dunegpvm12.fnal.gov> ls
add_rule.py           dcm_scopes_info_old.py      get_names.sh                     retire_file.py
atmo1_reco_bad.npy    dcm_scopes_info.py          get_parent_datasets.py           run_update_meta.sh
attach_pair.sh        dcm_scopes_unique_did.py    get_rucio_datasets.py            run_workflow_report.sh
check_files_list.py   detach_file_by_lookup.py    log                              temp_validator.py
check_meta.py         detach_file_no              log_ds                           throughput.py
check_replicas.py     detach_new.sh               oldcompare.py                    unique_rucio.py
compare.py            detach.sh                   old.py                           unretire.sh
container.py          did_rules_report.py         plot_event_rates.py              update_metadata.py
dataset_metacat.sh    fetch_justIN_dashboard.py   quick_validator.py               workflow_report.py
data_set_replicas.py  fetch_official_datasets.py  README.md
dataset_validator.py  find_dark_data.py           refactored_CollectionCreator.py
dcm_rucio_rses.py     get_datasets.py             retire_atmo_files.py
<dunegpvm12.fnal.gov> vi get_rucio_datasets.py 
<dunegpvm12.fnal.gov> vi get_rucio_datasets.py 
<dunegpvm12.fnal.gov> vi get_rucio_datasets.py 

import argparse
from rucio.client import Client

# Initialize Rucio client
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
