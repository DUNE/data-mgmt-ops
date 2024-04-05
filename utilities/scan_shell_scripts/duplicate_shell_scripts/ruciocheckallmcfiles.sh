#!/bin/bash
for file in `ls ????allmcfiles`
do
    for did in `cat $file`
    do
       rucio list-file-replicas $did >>  replicas.$file
       ruciorc=$?
       if [ $ruciorc -ne 12 ] 
       then
           echo $did >> tonuke.$file
       fi
    done
done
