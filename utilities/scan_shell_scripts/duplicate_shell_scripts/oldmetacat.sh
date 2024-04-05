#!/bin/bash
workflowid=1500
while  [ $workflowid -lt 1580 ] 
  do
     metacat query files from dune:all where dune.campaign='fd_mc_2023a_reco2' and dune.workflow[\"workflow_id\"]=${workflowid} > ${workflowid}allmcfiles
     let workflowid=$workflowid+1
  done


