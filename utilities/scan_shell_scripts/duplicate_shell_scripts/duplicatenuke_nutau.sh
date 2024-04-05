#!/bin/bash
multiples=`grep -v '^      1' 1581parentcounts | awk ' { print $2 }'`
for did in $multiples
do
    children=`metacat file show $did -l | tail -3 | grep -v children | awk ' { print $1 } '`
    for child in $children
    do
        python3 heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $child run
        rucio detach fardet-hd:fardet-hd-reco2_ritm1780305_nutau_fhc_skip0_limit5000_1581 $child
        rucio attach fardet-hd:duplicates1581 $child
        childrecoana=`echo $child | sed -e 's/reco2.root/reco2_ana.root/'`
        rucio detach fardet-hd:fardet-hd-reco2ana_ritm1780305_nutau_fhc_skip0_limit5000_1581 $childrecoana
        rucio attach fardet-hd:duplicatesreco2ana1581 $childrecoana
    done
done
multiples=`grep -v '^      1' 1582parentcounts | awk ' { print $2 }'`
for did in $multiples
do
    children=`metacat file show $did -l | tail -3 | grep -v children | awk ' { print $1 } '`
    for child in $children
    do
        python3 heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $child run
        rucio detach fardet-hd:fardet-hd-reco2_ritm1780305_nutau_fhc_skip5000_limit5000_1582 $child
        rucio attach fardet-hd:duplicates1582 $child
        childrecoana=`echo $child | sed -e 's/reco2.root/reco2_ana.root/'`
        rucio detach fardet-hd:fardet-hd-reco2ana_ritm1780305_nutau_fhc_skip5000_limit5000_1582 $childrecoana
        rucio attach fardet-hd:duplicatesreco2ana1582 $childrecoana
    done
done
multiples=`grep -v '^      1' 1584parentcounts | awk ' { print $2 }'`
for did in $multiples
do
    children=`metacat file show $did -l | tail -3 | grep -v children | awk ' { print $1 } '`
    for child in $children
    do
        python3 heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $child run
        rucio detach fardet-hd:fardet-hd-reco2_ritm1780305_nutau_fhc_skip10000_limit5000_1584 $child
        rucio attach fardet-hd:duplicates1584 $child
        childrecoana=`echo $child | sed -e 's/reco2.root/reco2_ana.root/'`
        rucio detach fardet-hd:fardet-hd-reco2ana_ritm1780305_nutau_fhc_skip10000_limit5000_1584 $childrecoana
        rucio attach fardet-hd:duplicatesreco2ana1584 $childrecoana
    done
done
multiples=`grep -v '^      1' 1594parentcounts | awk ' { print $2 }'`
for did in $multiples
do
    children=`metacat file show $did -l | tail -3 | grep -v children | awk ' { print $1 } '`
    for child in $children
    do
        python3 heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $child run
        rucio detach fardet-hd:fardet-hd-reco2_ritm1780305_nutau_fhc_skip15000_end_1594 $child
        rucio attach fardet-hd:duplicates1594 $child
        childrecoana=`echo $child | sed -e 's/reco2.root/reco2_ana.root/'`
        rucio detach fardet-hd:fardet-hd-reco2ana_ritm1780305_nutau_fhc_skip15000_end_1594 $childrecoana
        rucio attach fardet-hd:duplicatesreco2ana1594 $childrecoana

    done
done
multiples=`grep -v '^      1' 1586parentcounts | awk ' { print $2 }'`
for did in $multiples
do
    children=`metacat file show $did -l | tail -3 | grep -v children | awk ' { print $1 } '`
    for child in $children
    do
        python3 heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $child run
        rucio detach fardet-hd:fardet-hd-reco2_ritm1780305_anutau_rhc_skip0_limit5000_1586 $child
        rucio attach fardet-hd:duplicates1586 $child
        childrecoana=`echo $child | sed -e 's/reco2.root/reco2_ana.root/'`
        rucio detach fardet-hd:fardet-hd-reco2ana_ritm1780305_anutau_rhc_skip0_limit5000_1586 $childrecoana
        rucio attach fardet-hd:duplicatesreco2ana1586 $childrecoana

    done
done
multiples=`grep -v '^      1' 1587parentcounts | awk ' { print $2 }'`
for did in $multiples
do
    children=`metacat file show $did -l | tail -3 | grep -v children | awk ' { print $1 } '`
    for child in $children
    do
        python3 heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $child run
        rucio detach fardet-hd:fardet-hd-reco2_ritm1780305_anutau_rhc_skip5000_limit5000_1587 $child
        rucio attach fardet-hd:duplicates1587 $child
        childrecoana=`echo $child | sed -e 's/reco2.root/reco2_ana.root/'`
        rucio detach fardet-hd:fardet-hd-reco2ana_ritm1780305_anutau_rhc_skip5000_limit5000_1587 $childrecoana
        rucio attach fardet-hd:duplicatesreco2ana1587 $childrecoana

    done
done
multiples=`grep -v '^      1' 1588parentcounts | awk ' { print $2 }'`
for did in $multiples
do
    children=`metacat file show $did -l | tail -3 | grep -v children | awk ' { print $1 } '`
    for child in $children
    do
        python3 heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $child run
        rucio detach fardet-hd:fardet-hd-reco2_ritm1780305_anutau_rhc_skip10000_limit5000_1588 $child
        rucio attach fardet-hd:duplicates1588 $child
        childrecoana=`echo $child | sed -e 's/reco2.root/reco2_ana.root/'`
        rucio detach fardet-hd:fardet-hd-reco2ana_ritm1780305_anutau_rhc_skip10000_limit5000_1588 $childrecoana
        rucio attach fardet-hd:duplicatesreco2ana1588 $childrecoana

    done
done
multiples=`grep -v '^      1' 1595parentcounts | awk ' { print $2 }'`
for did in $multiples
do
    children=`metacat file show $did -l | tail -3 | grep -v children | awk ' { print $1 } '`
    for child in $children
    do
        python3 heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $child run
        rucio detach fardet-hd:fardet-hd-reco2_ritm1780305_anutau_rhc_skip15000_end_1595 $child
        rucio attach fardet-hd:duplicates1595 $child
        childrecoana=`echo $child | sed -e 's/reco2.root/reco2_ana.root/'`
        rucio detach fardet-hd:fardet-hd-reco2ana_ritm1780305_anutau_rhc_skip15000_end_1595 $childrecoana
        rucio attach fardet-hd:duplicatesreco2ana1595 $childrecoana

    done
done
