#!/bin/bash
myruciodataset=$1
myworkflow=$2
rucio list-files $myruciodataset | awk ' { print $2 }' | grep -v Total | grep -v SCOPE:NAME > ${myruciodataset}.files
myruciofiles=`cat $myruciodataset.files`
metacat query files from dune:all where core.data_tier="full-reconstructed" and dune.workflow[\"workflow_id\"]=$myworkflow > metacat${myworkflow}.files
mymetacatfiles=`cat metacat${myworkflow}.files`
# do a count
nummetacatfiles=`wc -l metacat${myworkflow}.files`
numruciofiles=`wc -l ${myruciodataset}.files`
echo "$nummetacatfiles $numruciofiles"
for file in $mymetacatfiles
do 
 myreplicas=`rucio list-file-replicas $file  | grep -v '\-\-\-' | grep -v SCOPE`
 myrc=$?
 echo " myrc $myreplicas"
 if [ $myrc -eq 0 ] 
 then
   echo "$file" >> ${myworkflow}.mcplusreplica
   mcr=0
 else
   echo "$file" >> ${myworkflow}.mcnoreplica
   mcr=-1
 fi
 myruciods=`grep $file $myruciodataset.files`
 myrcdsrc=$?
 if [ $myrcdsrc -eq 0 ]
 then
    echo "$file" >> ${myworkflow}.mcplusruciods
    mcrcdsrc=0
    if [ $mcr -eq 0 ] 
    then
       echo "$file" >> ${myworkflow}.mcplusruciodsplusreplica
    else
       echo "$file" >>${myworkflow}.mcplusruciodsnoreplica
    fi
 else 
    echo "$file" >> ${myworkflow}.mcnoruciods
    mcrcdsrc=-1
    if [ $mcr -eq 0 ]
    then 
      echo "$file" >> ${myworkflow}.mcnoruciodsplusreplica
    else
      echo "$file" >> ${myworkflow}.mcnoruciodsnoreplica
    fi
 fi
done

    


