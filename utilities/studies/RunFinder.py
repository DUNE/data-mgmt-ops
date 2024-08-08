
''' work a given workflow brute force find runs'''

import sys
import os
import json
import csv
import datetime

from TypeChecker import TypeChecker

from metacat.webapi import MetaCatClient

from TimeUtil import unix_to_timestamp

mc_client = MetaCatClient(os.getenv("METACAT_SERVER_URL"))
    
def RunFinder(workflow):
    runs = {}
    query="files where dune.workflow['workflow_id']=%s and core.data_tier=full-reconstructed and dune.output_status=confirmed"%workflow
    try:
        result = mc_client.query(query,with_metadata=True)
    except:
        print("query failed")
    results = list(result)
    nfiles = len(results)
    for r in results:
        newruns = r["metadata"]["core.runs"]
        for s in newruns:
            if s not in runs:
                runs[s]=0
            runs[s]+=1
                
    #print (runs)
    return runs,nfiles

if __name__ == '__main__':
    index = []
    fieldnames = ["workflow","count","runs"]
    
    if len(sys.argv) < 2:
        print ("need to give me a workflow number")
        sys.exit(1)
    wfmin = int(sys.argv[1])
    wfmax = wfmin
    if len(sys.argv) > 2:

        wfmax = int(sys.argv[2])
    for wf in range(wfmin, wfmax+1):

        data = {"workflow":wf}
        data["runs"],data["count"] = RunFinder(wf)
        if data["count"]> 0: index.append(data)
        print (data)

    outname = "WorkflowMap_%d_%d.json"%(wfmin,wfmax)
    f = open(outname,'w')
    json.dump(index,f,indent=4)
    f.close()
    
    newfile = outname.replace(".json",".csv")
    with open(newfile, 'w', newline='') as csvfile:
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        writer.writeheader()
        for workflow in index:
            writer.writerow(workflow)
    


