#!/bin/bash
for file in `ls tonuke.????allmcfiles`
do 
  for did in `cat $file`
  do 
     python ../heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $did run
  done
done
