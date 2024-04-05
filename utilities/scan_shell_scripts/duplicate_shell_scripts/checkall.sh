#!/bin/bash
ruciods=$1
workflowid=$2
datatier=$3
fileformat=$4
suffix=$5
runtype=`echo $ruciods | cut -f1 -d':'`
echo "Workflow ${workflowid}: Rucio Data set ${ruciods}"
metacatcount=`metacat query --summary count files from dune:all where core.run_type=${runtype} and core.data_tier=${datatier} and core.file_format=${fileformat} and dune.workflow[\"workflow_id\"]=${workflowid} | grep Files: | awk '{ print $2}'`
ruciocount=`rucio list-files $ruciods | grep 'Total files : ' | awk ' { print $4 } '`
echo "Metacat count ${metacatcount}  Rucio Count ${ruciocount}"


