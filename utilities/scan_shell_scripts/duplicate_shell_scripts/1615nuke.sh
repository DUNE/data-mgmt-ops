#!/bin/bash
for file in `cat 1615.badreco2ana`
do
    python heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $file run
    rucio detach fardet-vd:fardet-vd-reco2ana_ritm1780305_nu_numu2nue_nue2nutau_fhc_skip5000_limit5000_1615 $file
    rucio attach fardet-vd:duplicatesreco2ana1615 $file

done
for file in `cat 1615.badpandora`
do
    python heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $file run
    rucio detach  fardet-vd:fardet-vd-pandora_ritm1780305_nu_numu2nue_nue2nutau_fhc_skip5000_limit5000_1615 $file
    rucio attach fardet-vd:duplicatespandora1615 $file
done
for file in `cat 1615.badvalidation`
do 
    python heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $file run
    rucio detach fardet-vd:fardet-vd-validation_ritm1780305_nu_numu2nue_nue2nutau_fhc_skip5000_limit5000_1615 $file
    rucio attach fardet-vd:duplicatesvalidation1615 $file
done
for file in `cat 1615.badreco2`
do
    python heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $file run
    rucio detach fardet-vd:fardet-vd-reco2_ritm1780305_nu_numu2nue_nue2nutau_fhc_skip5000_limit5000_1615 $file
    rucio attach fardet-vd:duplicates1615 $file
done
