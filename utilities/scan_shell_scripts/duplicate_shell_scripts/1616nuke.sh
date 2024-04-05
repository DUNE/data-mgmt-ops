#!/bin/bash
for file in `cat 1616.badreco2ana`
do
    python heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $file run
    rucio detach fardet-vd:fardet-vd-reco2ana_ritm1780305_nu_numu2nue_nue2nutau_fhc_skip10000_limit5000_1616 $file
    rucio attach fardet-vd:duplicatesreco2ana1616 $file

done
for file in `cat 1616.badpandora`
do
    python heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $file run
    rucio detach  fardet-vd:fardet-vd-pandora_ritm1780305_nu_numu2nue_nue2nutau_fhc_skip10000_limit5000_1616 $file
    rucio attach fardet-vd:duplicatespandora1616 $file
done
for file in `cat 1616.badvalidation`
do 
    python heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $file run
    rucio detach fardet-vd:fardet-vd-validation_ritm1780305_nu_numu2nue_nue2nutau_fhc_skip10000_limit5000_1616 $file
    rucio attach fardet-vd:duplicatesvalidation1616 $file
done
for file in `cat 1616.badreco2`
do
    python heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $file run
    rucio detach fardet-vd:fardet-vd-reco2_ritm1780305_nu_numu2nue_nue2nutau_fhc_skip10000_limit5000_1616 $file
    rucio attach fardet-vd:duplicates1616 $file
done
