#!/bin/bash
for file in `cat 1583.badreco2ana`
do
    python heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $file run
    rucio detach fardet-vd:fardet-vd-reco2ana_ritm1780305_nu_fhc_skip0_limit5000_1583 $file
    rucio attach fardet-vd:duplicatesreco2ana1583 $file

done
for file in `cat 1583.badpandora`
do
    python heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $file run
    rucio detach fardet-vd:fardet-vd-pandora_ritm1780305_nu_fhc_skip0_limit5000_1583 $file
    rucio attach fardet-vd:duplicatespandora1583 $file
done
for file in `cat 1583.badvalidation`
do 
    python heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $file run
    rucio detach fardet-vd:fardet-vd-validation_ritm1780305_nu_fhc_skip0_limit5000_1583 $file
    rucio attach fardet-vd:duplicatesvalidation1583 $file
done
for file in `cat 1583.badreco2`
do
    python heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $file run
    rucio detach fardet-vd:fardet-vd-reco2_ritm1780305_nu_fhc_skip0_limit5000_1583 $file
    rucio attach fardet-vd:duplicates1583 $file
done
