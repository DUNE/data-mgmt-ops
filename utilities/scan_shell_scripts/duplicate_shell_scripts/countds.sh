#!/bin/bash
#set -x
while read line
do 
  ruleid=`echo ${line}  | awk '{  print $1 }'`
  did=`echo ${line} | awk '{ print $3 }'`
  status=`echo ${line} | awk '{ print $4} '`
  complete=`echo ${status} | cut -d'[' -f2 | sed -e 's/\]//' | cut -f1 -d '/'`
  repl=`echo ${status} | cut -d'[' -f2 | sed -e 's/\]//' | cut -f2 -d '/'`
  stuck=`echo ${status} | cut -d'[' -f2 | sed -e 's/\]//' | cut -f3 -d '/'`
  nfiles=`rucio list-files $did | grep 'Total files :' | awk '{ print $4 }'`
  let ruletotal=$complete+$repl+$stuck
#  echo "$did $nfiles $ruletotal"
  if [ $nfiles -ne $ruletotal ]
  then
     echo "$did $nfiles $ruletotal"
     rucio update-rule $ruleid --suspend
     rucio update-rule $ruleid --stuck
  fi
done
