#!/bin/bash
mydataset=$1
. ~/mcruciosam/profile.sh
# usage retire_full_rucio_dataset.sh <rucio_dataset_name>
rucio list-files $mydataset | grep -v Total | grep -v '+\-\-\-' | grep -v SCOPE:NAME| awk ' { print $2}'  > ruciofilelist.$mydataset
ruciofilelist=`rucio list-files $mydataset | grep -v Total | grep -v '+\-\-\-' | grep -v SCOPE:NAME| awk ' { print $2}'  `

for file in $ruciofilelist 
do
        python3 ~/mcruciosam/st_retire_metacat.py $file
        rucio detach $mydataset $file
        rucio erase $file
        samfilename=`echo $file | cut -f2 -d':'`
        samweb retire-file $samfilename
done

echo "all done"
rucio list-rules $mydataset
myrule=`rucio list-rules $mydataset | grep -v ID | grep -v '^\-\-\-\-' | awk '{ print $1 }'`
echo "if the rule shows [0/0/0] then"
echo "rucio update-rule $myrule --stuck --lock false"
echo "rucio delete-rule $myrule"
echo "rucio erase $mydataset"
echo " and clear metacat datasets as appropriate"
metacat dataset show $mydataset

