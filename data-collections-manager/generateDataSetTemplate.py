''' use the metadata for a file to create a dataset template'''
import os, sys, json

import argparse

defname = "%core.file_type.%core.run_type.%dune.campaign.%core.application.version.%core.data_tier.%dune_mc.gen_fcl_filename.%deftag"

# list of fields that really seriously should be the same in any dataset

keep = [
    "core.application.family" ,
    "core.application.name" ,
    "core.application.version", 
    "core.data_stream" ,
    "core.data_tier",
    "core.file_format",
    "core.file_type",
    "core.group",
    "core.run_type",
    "dune.campaign",
    "dune.config_file",
    "dune.output_status",
    "dune.requestid",
    "dune_mc.electron_lifetime",
    "dune_mc.gen_fcl_filename",
    "dune_mc.generators",
    "dune_mc.geometry_version",
    "dune_mc.liquid_flow",
    "dune_mc.space_charge",
    "origin.applications.config_files",
    "namespace"
]

def cloneMD(mainmd,deftag,description,verbose=False):
    datasetmd = {}
    datasetmd["namespace"]=mainmd["namespace"]
    datasetmd["defname"]=defname
    datasetmd["deftag"]=deftag
    datasetmd["description"]=description
    md = mainmd["metadata"]
    for field,value in md.items():
        if field not in keep: 
            continue
        datasetmd[field]=value
    return datasetmd
    
if __name__ == "__main__":

    parser = argparse.ArgumentParser(description='use a file metadata as a dataset template')
    parser.add_argument("--json",type=str,help="path of a json file you want to make a dataset template from")
    parser.add_argument("--tag",type=str,help="tag to keep track of versions of dataset")
    parser.add_argument("--description",type=str,help="human-readable description")

    args = parser.parse_args()

    if not os.path.exists(args.json):
        print ("--json does not point to an existing file",args.json)
        sys.exit(1)
    f = open(args.json,'r')
    mainmd = json.load(f)
    f.close()
    datasetmd = cloneMD(mainmd,deftag=args.tag,description=args.description,verbose=False)

    print (json.dumps(datasetmd,indent=4))