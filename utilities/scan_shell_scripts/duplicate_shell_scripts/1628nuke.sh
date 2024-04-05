#!/bin/bash
#for file in `cat 1628.badreco2ana`
#do
#    python heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $file run
#    rucio detach fardet-vd:fardet-vd-reco2ana_ritm1780305_anu_numu2nutau_nue2numu_rhc_skip10000_limit5000_1628 $file
#    rucio attach fardet-vd:duplicatesreco2ana1628 $file
#
#done
#for file in `cat 1628.badpandora`
#do
#    python heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $file run
#    rucio detach  fardet-vd:fardet-vd-pandora_ritm1780305_anu_numu2nutau_nue2numu_rhc_skip10000_limit5000_1628 $file
#    rucio attach fardet-vd:duplicatespandora1628 $file
#done
for file in `cat 1628.badvalidation`
do 
    python heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $file run
    rucio detach fardet-vd:fardet-vd-validation_ritm1780305_anu_numu2nutau_nue2numu_rhc_skip10000_limit5000_1628 $file
    rucio attach fardet-vd:duplicatesvalidation1628 $file
done
for file in `cat 1628.badreco2`
do
    python heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $file run
    rucio detach fardet-vd:fardet-vd-reco2_ritm1780305_anu_numu2nutau_nue2numu_rhc_skip10000_limit5000_1628 $file
    rucio attach fardet-vd:duplicates1628 $file
done
