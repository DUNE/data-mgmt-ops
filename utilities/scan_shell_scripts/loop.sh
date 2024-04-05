#/bin/bash
for file in `cat ../../../nuetaumconlyfiles`
do
    for did in `cat ../../../$file` 
    do
      python MetaNuker_test.py $did run
    done
done
