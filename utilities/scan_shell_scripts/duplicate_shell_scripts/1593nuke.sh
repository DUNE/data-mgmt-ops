#!/bin/bash
for file in `cat 1593.badreco2ana`
do
    python heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $file run
    rucio detach fardet-vd:fardet-vd-reco2ana_ritm1780305_nu_fhc_skip15000_end_1593 $file
    rucio attach fardet-vd:duplicatesreco2ana1593 $file

done
for file in `cat 1593.badpandora`
do
    python heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $file run
    rucio detach fardet-vd:fardet-vd-pandora_ritm1780305_nu_fhc_skip15000_end_1593 $file
    rucio attach fardet-vd:duplicatespandora1593 $file
done
for file in `cat 1593.badvalidation`
do 
    python heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $file run
    rucio detach fardet-vd:fardet-vd-validation_ritm1780305_nu_fhc_skip15000_end_1593 $file
    rucio attach fardet-vd:duplicatesvalidation1593 $file
done
for file in `cat 1593.badreco2`
do
    python heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $file run
    rucio detach fardet-vd:fardet-vd-reco2_ritm1780305_nu_fhc_skip15000_end_1593 $file
    rucio attach fardet-vd:duplicates1593 $file
done
