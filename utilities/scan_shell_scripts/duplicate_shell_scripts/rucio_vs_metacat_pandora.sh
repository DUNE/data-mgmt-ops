#!/bin/bash
myruciodataset=$1
myworkflow=$2
rucio list-files $myruciodataset | awk ' { print $2 }' | grep -v Total | grep -v SCOPE:NAME > ${myruciodataset}.files
myruciofiles=`cat $myruciodataset.files`
metacat query 'files from dune:all where core.data_tier in ("pandora-info","pandora_info") and core.file_format="binary" and dune.workflow["workflow_id"]'=${myworkflow} > metacatpandora${myworkflow}.files
mymetacatfiles=`cat metacatpandora${myworkflow}.files`
# do a count
nummetacatfiles=`wc -l metacatpandora${myworkflow}.files`
numruciofiles=`wc -l ${myruciodataset}.files`
echo "$nummetacatfiles $numruciofiles"
for file in $mymetacatfiles
do 
 myreplicas=`rucio list-file-replicas $file  | grep -v '\-\-\-' | grep -v SCOPE`
 myrc=$?
 echo " myrc $myreplicas"
 if [ $myrc -eq 0 ] 
 then
   echo "$file" >> ${myworkflow}pandora.mcplusreplica
   mcr=0
 else
   echo "$file" >> ${myworkflow}pandora.mcnoreplica
   mcr=-1
 fi
 myruciods=`grep $file $myruciodataset.files`
 myrcdsrc=$?
 if [ $myrcdsrc -eq 0 ]
 then
    echo "$file" >> ${myworkflow}pandora.mcplusruciods
    mcrcdsrc=0
    if [ $mcr -eq 0 ] 
    then
       echo "$file" >> ${myworkflow}pandora.mcplusruciodsplusreplica
    else
       echo "$file" >>${myworkflow}pandora.mcplusruciodsnoreplica
    fi
 else 
    echo "$file" >> ${myworkflow}pandora.mcnoruciods
    mcrcdsrc=-1
    if [ $mcr -eq 0 ]
    then 
      echo "$file" >> ${myworkflow}pandora.mcnoruciodsplusreplica
    else
      echo "$file" >> ${myworkflow}pandora.mcnoruciodsnoreplica
    fi
 fi
done

   
