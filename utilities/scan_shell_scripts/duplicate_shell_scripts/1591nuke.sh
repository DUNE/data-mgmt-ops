#!/bin/bash
for file in `cat 1591.badreco2ana`
do
    python heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $file run
    rucio detach fardet-vd:fardet-vd-reco2ana_ritm1780305_nu_fhc_skip10000_limit5000_1591 $file
    rucio attach fardet-vd:duplicatesreco2ana1591 $file

done
for file in `cat 1591.badpandora`
do
    python heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $file run
    rucio detach fardet-vd:fardet-vd-pandora_ritm1780305_nu_fhc_skip10000_limit5000_1591 $file
    rucio attach fardet-vd:duplicatespandora1591 $file
done
for file in `cat 1591.badvalidation`
do 
    python heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $file run
    rucio detach fardet-vd:fardet-vd-validation_ritm1780305_nu_fhc_skip10000_limit5000_1591 $file
    rucio attach fardet-vd:duplicatesvalidation1591 $file
done
for file in `cat 1591.badreco2`
do
    python heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $file run
    rucio detach fardet-vd:fardet-vd-reco2_ritm1780305_nu_fhc_skip10000_limit5000_1591 $file
    rucio attach fardet-vd:duplicates1591 $file
done
