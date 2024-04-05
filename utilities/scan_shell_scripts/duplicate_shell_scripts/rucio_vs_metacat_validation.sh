#!/bin/bash
myruciodataset=$1
myworkflow=$2
rucio list-files $myruciodataset | awk ' { print $2 }' | grep -v Total | grep -v SCOPE:NAME > ${myruciodataset}.files
myruciofiles=`cat $myruciodataset.files`
metacat query 'files from dune:all where core.data_tier in ("pandora-info","pandora_info") and core.file_format="root" and dune.workflow["workflow_id"]'=$myworkflow  > metacatvalidation${myworkflow}.files
mymetacatfiles=`cat metacatvalidation${myworkflow}.files`
# do a count
nummetacatfiles=`wc -l metacatvalidation${myworkflow}.files`
numruciofiles=`wc -l ${myruciodataset}.files`
echo "$nummetacatfiles $numruciofiles"
for file in $mymetacatfiles
do 
 myreplicas=`rucio list-file-replicas $file  | grep -v '\-\-\-' | grep -v SCOPE`
 myrc=$?
 echo " myrc $myreplicas"
 if [ $myrc -eq 0 ] 
 then
   echo "$file" >> ${myworkflow}validation.mcplusreplica
   mcr=0
 else
   echo "$file" >> ${myworkflow}validation.mcnoreplica
   mcr=-1
 fi
 myruciods=`grep $file $myruciodataset.files`
 myrcdsrc=$?
 if [ $myrcdsrc -eq 0 ]
 then
    echo "$file" >> ${myworkflow}validation.mcplusruciods
    mcrcdsrc=0
    if [ $mcr -eq 0 ] 
    then
       echo "$file" >> ${myworkflow}validation.mcplusruciodsplusreplica
    else
       echo "$file" >>${myworkflow}validation.mcplusruciodsnoreplica
    fi
 else 
    echo "$file" >> ${myworkflow}validation.mcnoruciods
    mcrcdsrc=-1
    if [ $mcr -eq 0 ]
    then 
      echo "$file" >> ${myworkflow}validation.mcnoruciodsplusreplica
    else
      echo "$file" >> ${myworkflow}validation.mcnoruciodsnoreplica
    fi
 fi
done

   
