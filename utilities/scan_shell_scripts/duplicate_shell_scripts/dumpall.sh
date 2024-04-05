#!/bin/bash
ruciods=$1
workflowid=$2
datatier=$3
fileformat=$4
suffix=$5
runtype=`echo $ruciods | cut -f1 -d':'`
echo "Workflow ${workflowid}: Rucio Data set ${ruciods}"
metacat query files from dune:all where core.run_type=${runtype} and core.data_tier=${datatier} and core.file_format=${fileformat} and dune.workflow[\"workflow_id\"]=${workflowid} | sort | uniq -c > ${workflowid}${datatier}${fileformat}metacat_24mar.uniq
rucio list-files $ruciods| awk ' { print $2 } ' | sort | grep  ${suffix} | uniq -c  > ${workflowid}${datatier}${fileformat}rucio_24mar.uniq
metacatcount=`wc -l ${workflowid}${datatier}${fileformat}metacat_24mar.uniq | awk '{ print $1 }'`
ruciocount=`wc -l  ${workflowid}${datatier}${fileformat}rucio_24mar.uniq | awk ' { print $1  }'`
echo "Metacat count ${metacatcount}  Rucio Count ${ruciocount}"
diff ${workflowid}${datatier}${fileformat}metacat_24mar.uniq  ${workflowid}${datatier}${fileformat}rucio_24mar.uniq | grep '^>' | awk ' { print $3 } ' > ${workflowid}${datatier}${fileformat}rucioonly_24mar
rucioonlycount=`wc -l ${workflowid}${datatier}${fileformat}rucioonly_24mar | awk ' { print $1 }'`
diff ${workflowid}${datatier}${fileformat}metacat_24mar.uniq  ${workflowid}${datatier}${fileformat}rucio_24mar.uniq | grep '^<' | awk ' { print $3 } ' > ${workflowid}${datatier}${fileformat}metacatonly_24mar
metacatonlycount=`wc -l ${workflowid}${datatier}${fileformat}metacatonly_24mar | awk ' { print $1 } '`
echo "Metacat only count ${metacatonlycount} Rucio only count ${rucioonlycount}"
if [ "${datatier}" == "root-tuple-virtual" ] 
then
    cat ${workflowid}${datatier}${fileformat}rucio_24mar.uniq | sed -e 's/_ana//' > ${workflowid}${datatier}${fileformat}rucio_24mar.uniq.compare
    cat ${workflowid}${datatier}${fileformat}metacat_24mar.uniq | sed -e 's/_ana//' > ${workflowid}${datatier}${fileformat}metacat_24mar.uniq.compare
fi
if [ "${datatier}" == "pandora-info" ] 
then
  if  [ "${fileformat}" == "binary" ] 
  then
     cat ${workflowid}${datatier}${fileformat}rucio_24mar.uniq | sed -e 's/_Pandora_Events.pndr/.root/' > ${workflowid}${datatier}${fileformat}rucio_24mar.uniq.compare
     cat ${workflowid}${datatier}${fileformat}metacat_24mar.uniq | sed -e 's/_Pandora_Events.pndr/.root/' > ${workflowid}${datatier}${fileformat}metacat_24mar.uniq.compare
  elif     [ "${fileformat}" == "root" ]
  then 
         cat ${workflowid}${datatier}${fileformat}rucio_24mar.uniq | sed -e 's/_Validation//' > ${workflowid}${datatier}${fileformat}rucio_24mar.uniq.compare
         cat ${workflowid}${datatier}${fileformat}metacat_24mar.uniq | sed -e 's/_Validation//' > ${workflowid}${datatier}${fileformat}metacat_24mar.uniq.compare   
  fi
fi
