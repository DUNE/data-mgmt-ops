#!/bin/bash
multiples=`grep -v '^      1' 1599parentcounts | awk ' { print $2 }'`
for did in $multiples
do
    children=`metacat file show $did -l | tail -3 | grep -v children | awk ' { print $1 } '`
    for child in $children
    do
        python3 heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $child run
        rucio detach fardet-hd:fardet-hd-reco2_ritm1780305_nue_fhc_skip0_limit5000_1599 $child
        rucio attach fardet-hd:duplicates1599 $child
        childrecoana=`echo $child | sed -e 's/reco2.root/reco2_ana.root/'`
        rucio detach fardet-hd:fardet-hd-reco2ana_ritm1780305_nue_fhc_skip0_limit5000_1599 $childrecoana
        rucio attach fardet-hd:duplicatesreco2ana1599 $childrecoana
    done
done
multiples=`grep -v '^      1' 1600parentcounts | awk ' { print $2 }'`
for did in $multiples
do
    children=`metacat file show $did -l | tail -3 | grep -v children | awk ' { print $1 } '`
    for child in $children
    do
        python3 heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $child run
        rucio detach fardet-hd:fardet-hd-reco2_ritm1780305_nue_fhc_skip5000_limit5000_1600 $child
        rucio attach fardet-hd:duplicates1600 $child
        childrecoana=`echo $child | sed -e 's/reco2.root/reco2_ana.root/'`
        rucio detach fardet-hd:fardet-hd-reco2ana_ritm1780305_nue_fhc_skip5000_limit5000_1600 $childrecoana
        rucio attach fardet-hd:duplicatesreco2ana1600 $childrecoana
    done
done
multiples=`grep -v '^      1' 1601parentcounts | awk ' { print $2 }'`
for did in $multiples
do
    children=`metacat file show $did -l | tail -3 | grep -v children | awk ' { print $1 } '`
    for child in $children
    do
        python3 heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $child run
        rucio detach fardet-hd:fardet-hd-reco2_ritm1780305_nue_fhc_skip10000_limit5000_1601 $child
        rucio attach fardet-hd:duplicates1601 $child
        childrecoana=`echo $child | sed -e 's/reco2.root/reco2_ana.root/'`
        rucio detach fardet-hd:fardet-hd-reco2ana_ritm1780305_nue_fhc_skip10000_limit5000_1601 $childrecoana
        rucio attach fardet-hd:duplicatesreco2ana1601 $childrecoana
    done
done
multiples=`grep -v '^      1' 1602parentcounts | awk ' { print $2 }'`
for did in $multiples
do
    children=`metacat file show $did -l | tail -3 | grep -v children | awk ' { print $1 } '`
    for child in $children
    do
        python3 heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $child run
        rucio detach fardet-hd:fardet-hd-reco2_ritm1780305_nue_fhc_skip15000_end_1602 $child
        rucio attach fardet-hd:duplicates1602 $child
        childrecoana=`echo $child | sed -e 's/reco2.root/reco2_ana.root/'`
        rucio detach fardet-hd:fardet-hd-reco2ana_ritm1780305_nue_fhc_skip15000_end_1602 $childrecoana
        rucio attach fardet-hd:duplicatesreco2ana1602 $childrecoana

    done
done
multiples=`grep -v '^      1' 1604parentcounts | awk ' { print $2 }'`
for did in $multiples
do
    children=`metacat file show $did -l | tail -3 | grep -v children | awk ' { print $1 } '`
    for child in $children
    do
        python3 heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $child run
        rucio detach fardet-hd:fardet-hd-reco2_ritm1780305_anue_rhc_skip0_limit5000_1604 $child
        rucio attach fardet-hd:duplicates1604 $child
        childrecoana=`echo $child | sed -e 's/reco2.root/reco2_ana.root/'`
        rucio detach fardet-hd:fardet-hd-reco2ana_ritm1780305_anue_rhc_skip0_limit5000_1604 $childrecoana
        rucio attach fardet-hd:duplicatesreco2ana1604 $childrecoana

    done
done
multiples=`grep -v '^      1' 1606parentcounts | awk ' { print $2 }'`
for did in $multiples
do
    children=`metacat file show $did -l | tail -3 | grep -v children | awk ' { print $1 } '`
    for child in $children
    do
        python3 heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $child run
        rucio detach fardet-hd:fardet-hd-reco2_ritm1780305_anue_rhc_skip5000_limit5000_1606 $child
        rucio attach fardet-hd:duplicates1606 $child
        childrecoana=`echo $child | sed -e 's/reco2.root/reco2_ana.root/'`
        rucio detach fardet-hd:fardet-hd-reco2ana_ritm1780305_anue_rhc_skip5000_limit5000_1606 $childrecoana
        rucio attach fardet-hd:duplicatesreco2ana1606 $childrecoana

    done
done
multiples=`grep -v '^      1' 1608parentcounts | awk ' { print $2 }'`
for did in $multiples
do
    children=`metacat file show $did -l | tail -3 | grep -v children | awk ' { print $1 } '`
    for child in $children
    do
        python3 heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $child run
        rucio detach fardet-hd:fardet-hd-reco2_ritm1780305_anue_rhc_skip10000_limit5000_1608 $child
        rucio attach fardet-hd:duplicates1608 $child
        childrecoana=`echo $child | sed -e 's/reco2.root/reco2_ana.root/'`
        rucio detach fardet-hd:fardet-hd-reco2ana_ritm1780305_anue_rhc_skip10000_limit5000_1608 $childrecoana
        rucio attach fardet-hd:duplicatesreco2ana1608 $childrecoana

    done
done
multiples=`grep -v '^      1' 1609parentcounts | awk ' { print $2 }'`
for did in $multiples
do
    children=`metacat file show $did -l | tail -3 | grep -v children | awk ' { print $1 } '`
    for child in $children
    do
        python3 heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $child run
        rucio detach fardet-hd:fardet-hd-reco2_ritm1780305_anue_rhc_skip15000_end_1609 $child
        rucio attach fardet-hd:duplicates1609 $child
        childrecoana=`echo $child | sed -e 's/reco2.root/reco2_ana.root/'`
        rucio detach fardet-hd:fardet-hd-reco2ana_ritm1780305_anue_rhc_skip15000_end_1609 $childrecoana
        rucio attach fardet-hd:duplicatesreco2ana1609 $childrecoana

    done
done
