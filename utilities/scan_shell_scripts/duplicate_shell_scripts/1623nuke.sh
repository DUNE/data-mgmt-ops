#!/bin/bash
#for file in `cat 1623.badreco2ana`
#do
#    python heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $file run
#    rucio detach fardet-vd:fardet-vd-reco2ana_ritm1780305_nu_numu2nutau_nue2numu_fhc_skip5000_limit5000_1623 $file
#    rucio attach fardet-vd:duplicatesreco2ana1623 $file
#
#done
#for file in `cat 1623.badpandora`
#do
#    python heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $file run
#    rucio detach  fardet-vd:fardet-vd-pandora_ritm1780305_nu_numu2nutau_nue2numu_fhc_skip5000_limit5000_1623 $file
#    rucio attach fardet-vd:duplicatespandora1623 $file
#done
for file in `cat 1623.badvalidation`
do 
    python heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $file run
    rucio detach fardet-vd:fardet-vd-validation_ritm1780305_nu_numu2nutau_nue2numu_fhc_skip5000_limit5000_1623 $file
    rucio attach fardet-vd:duplicatesvalidation1623 $file
done
for file in `cat 1623.badreco2`
do
    python heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $file run
    rucio detach fardet-vd:fardet-vd-reco2_ritm1780305_nu_numu2nutau_nue2numu_fhc_skip5000_limit5000_1623 $file
    rucio attach fardet-vd:duplicates1623 $file
done
