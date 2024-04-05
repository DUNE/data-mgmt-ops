#!/bin/bash
ruciofiles=`rucio list-content fardet-hd:fardet-hd_1196 --short`
for file in $ruciofiles
do
  scope=`echo $file | cut -f1 -d':'`
    name=`echo $file | cut -f2 -d':'`
    pfn=`rucio list-file-replicas $file | grep -v ADLER32 | awk '{ print $12 }'`
#    echo $pfn
    samloc=`echo $pfn | sed -e 's%root://fndca1.fnal.gov:1094/pnfs/fnal.gov/usr/%dcache:/pnfs/%'`
    finalsamloc=`echo $samloc | cut -f1,2,3,4,5,6,7,8 -d'/'`
    echo $finalsamloc
    samweb add-file-location $name $finalsamloc
done
