#!/bin/bash
#for file in `cat 1622.badreco2ana`
#do
#    python heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $file run
#    rucio detach fardet-vd:fardet-vd-reco2ana_ritm1780305_nu_numu2nutau_nue2numu_fhc_skip0_limit5000_1622 $file
#    rucio attach fardet-vd:duplicatesreco2ana1622 $file
#
#done
#for file in `cat 1622.badpandora`
#do
#    python heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $file run
#    rucio detach  fardet-vd:fardet-vd-pandora_ritm1780305_nu_numu2nutau_nue2numu_fhc_skip0_limit5000_1622 $file
#    rucio attach fardet-vd:duplicatespandora1622 $file
#done
for file in `cat 1622.badvalidation`
do 
    python heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $file run
    rucio detach fardet-vd:fardet-vd-validation_ritm1780305_nu_numu2nutau_nue2numu_fhc_skip0_limit5000_1622 $file
    rucio attach fardet-vd:duplicatesvalidation1622 $file
done
for file in `cat 1622.badreco2`
do
    python heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $file run
    rucio detach fardet-vd:fardet-vd-reco2_ritm1780305_nu_numu2nutau_nue2numu_fhc_skip0_limit5000_1622 $file
    rucio attach fardet-vd:duplicates1622 $file
done
