#!/bin/bash
#for file in `cat 1627.badreco2ana`
#do
#    python heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $file run
#    rucio detach fardet-vd:fardet-vd-reco2ana_ritm1780305_anu_numu2nutau_nue2numu_rhc_skip5000_limit5000_1627 $file
#    rucio attach fardet-vd:duplicatesreco2ana1627 $file
#
#done
#for file in `cat 1627.badpandora`
#do
#    python heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $file run
#    rucio detach  fardet-vd:fardet-vd-pandora_ritm1780305_anu_numu2nutau_nue2numu_rhc_skip5000_limit5000_1627 $file
#    rucio attach fardet-vd:duplicatespandora1627 $file
#done
for file in `cat 1627.badvalidation`
do 
    python heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $file run
    rucio detach fardet-vd:fardet-vd-validation_ritm1780305_anu_numu2nutau_nue2numu_rhc_skip5000_limit5000_1627 $file
    rucio attach fardet-vd:duplicatesvalidation1627 $file
done
for file in `cat 1627.badreco2`
do
    python heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $file run
    rucio detach fardet-vd:fardet-vd-reco2_ritm1780305_anu_numu2nutau_nue2numu_rhc_skip5000_limit5000_1627 $file
    rucio attach fardet-vd:duplicates1627 $file
done
