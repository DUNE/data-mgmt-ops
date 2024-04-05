#!/bin/bash
  for did in `cat 1569allmcfiles`
  do 
     python ../heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $did run
  done
