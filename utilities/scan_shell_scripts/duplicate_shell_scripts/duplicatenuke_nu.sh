#!/bin/bash
multiples=`grep -v '^      1' 1631parentcounts | awk ' { print $2 }'`
for did in $multiples
do
    children=`metacat file show $did -l | tail -3 | grep -v children | awk ' { print $1 } '`
    for child in $children
    do
        python3 heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $child run
        rucio detach fardet-hd:fardet-hd-reco2_ritm1780305_nu_fhc_skip12000_limit5000_1631 $child
        rucio attach fardet-hd:duplicates1631 $child
    done
done
multiples=`grep -v '^      1' 1632parentcounts | awk ' { print $2 }'`
for did in $multiples
do
    children=`metacat file show $did -l | tail -3 | grep -v children | awk ' { print $1 } '`
    for child in $children
    do
        python3 heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $child run
        rucio detach fardet-hd:fardet-hd-reco2_ritm1780305_nu_fhc_skip17000_end_1632 $child
        rucio attach fardet-hd:duplicates1632 $child
    done
done
multiples=`grep -v '^      1' 1633parentcounts | awk ' { print $2 }'`
for did in $multiples
do
    children=`metacat file show $did -l | tail -3 | grep -v children | awk ' { print $1 } '`
    for child in $children
    do
        python3 heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $child run
        rucio detach fardet-hd:fardet-hd-reco2_ritm1780305_anu_rhc_skip0_limit5000_1633 $child
        rucio attach fardet-hd:duplicates1633 $child
    done
done
multiples=`grep -v '^      1' 1596parentcounts | awk ' { print $2 }'`
for did in $multiples
do
    children=`metacat file show $did -l | tail -3 | grep -v children | awk ' { print $1 } '`
    for child in $children
    do
        python3 heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $child run
        rucio detach fardet-hd:fardet-hd-reco2_ritm1780305_anu_rhc_skip5000_limit5000_1596 $child
        rucio attach fardet-hd:duplicates1596 $child
    done
done
multiples=`grep -v '^      1' 1597parentcounts | awk ' { print $2 }'`
for did in $multiples
do
    children=`metacat file show $did -l | tail -3 | grep -v children | awk ' { print $1 } '`
    for child in $children
    do
        python3 heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $child run
        rucio detach fardet-hd:fardet-hd-reco2_ritm1780305_anu_rhc_skip10000_limit5000_1597 $child
        rucio attach fardet-hd:duplicates1597 $child
    done
done
multiples=`grep -v '^      1' 1598parentcounts | awk ' { print $2 }'`
for did in $multiples
do
    children=`metacat file show $did -l | tail -3 | grep -v children | awk ' { print $1 } '`
    for child in $children
    do
        python3 heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $child run
        rucio detach fardet-hd:fardet-hd-reco2_ritm1780305_nu_fhc_skip15000_end_1598 $child
        rucio attach fardet-hd:duplicates1598 $child
    done
done
