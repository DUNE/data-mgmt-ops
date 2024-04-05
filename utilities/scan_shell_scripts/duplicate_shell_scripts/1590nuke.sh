#!/bin/bash
#for file in `cat 1590.badreco2ana`
#do
#    python heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $file run
#    rucio detach fardet-vd:fardet-vd-reco2ana_ritm1780305_nu_fhc_skip5000_limit5000_1590 $file
#    rucio attach fardet-vd:duplicatesreco2ana1590 $file
#
#done
#for file in `cat 1590.badpandora`
#do
#    python heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $file run
#    rucio detach fardet-vd:fardet-vd-pandora_ritm1780305_nu_fhc_skip5000_limit5000_1590 $file
#    rucio attach fardet-vd:duplicatespandora1590 $file
#done
#for file in `cat 1590.badvalidation`
#do 
#    python heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $file run
#    rucio detach fardet-vd:fardet-vd-validation_ritm1780305_nu_fhc_skip5000_limit5000_1590 $file
#    rucio attach fardet-vd:duplicatesvalidation1590 $file
#done
for file in `cat 1590.badreco2`
do
    python heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $file run
    rucio detach fardet-vd:fardet-vd-reco2_ritm1780305_nu_fhc_skip5000_limit5000_1590 $file
    rucio attach fardet-vd:duplicates1590 $file
done
