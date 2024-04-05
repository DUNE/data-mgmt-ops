#!/bin/bash
# note it is preferred to call this for the child files first (reco2ana, pandora, validation) and finally reco2.
dataset=$1
workflow=$2
datatier=$3
format=$4
suffix=$5
metacat query files from dune:all where core.data_tier=${datatier} and core.file_format=${format} and dune.workflow[\"workflow_id\"]=${workflow}  | sort > ${workflow}mcfiles.${datatier}.${format}.sort
echo "total metacat files in ${workflow}mcfiles.${datatier}.${format}.sort"
mccount=`wc -l ${workflow}mcfiles.${datatier}.${format}.sort | awk '{ print $1 }'`
echo $mccount
if [ $mccount -eq 0 ] 
then
    echo "no metacat files found"
    exit 1
fi
rucio list-files ${dataset} | grep ${suffix}  | awk ' { print $2 } ' | sort > ${workflow}ruciofiles.${datatier}.${format}.sort
echo "total rucio files in ${workflow}ruciofiles.${datatier}.${format}.sort"
ruciocount=`wc -l ${workflow}ruciofiles.${datatier}.${format}.sort | awk ' { print $1 }'`
echo $ruciocount
if [ $ruciocount -eq 0 ]
then
    echo "no rucio files found"
    exit 1
fi
diff ${workflow}mcfiles.${datatier}.${format}.sort ${workflow}ruciofiles.${datatier}.${format}.sort | grep '^<' | sed -e 's/< //' > ${workflow}mconlyfiles.${datatier}.${format}
echo "those only in metacat--removing them from metacat"
wc -l ${workflow}mconlyfiles.${datatier}.${format}
diff ${workflow}mcfiles.${datatier}.${format}.sort ${workflow}ruciofiles.${datatier}.${format}.sort | grep '^>' | sed -e 's/> //' > ${workflow}rucioonlyfiles.${datatier}.${format}
echo "those only in rucio (should be zero)"
wc -l ${workflow}rucioonlyfiles.${datatier}.${format}
#remove the metacat only files
for did in `cat ${workflow}mconlyfiles.${datatier}.${format}`
do
   python ~/mcruciosam/heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $did run
done
