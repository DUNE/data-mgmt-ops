#!/bin/bash
#for file in `cat 1621.badreco2ana`
#do
#    python heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $file run
#    rucio detach fardet-vd:fardet-vd-reco2ana_ritm1780305_anu_numu2nue_nue2nutau_rhc_skip15000_end_1621 $file
#    rucio attach fardet-vd:duplicatesreco2ana1621 $file
#
#done
#for file in `cat 1621.badpandora`
#do
#    python heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $file run
#    rucio detach  fardet-vd:fardet-vd-pandora_ritm1780305_anu_numu2nue_nue2nutau_rhc_skip15000_end_1621 $file
#    rucio attach fardet-vd:duplicatespandora1621 $file
#done
for file in `cat 1621.badvalidation`
do 
    python heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $file run
    rucio detach fardet-vd:fardet-vd-validation_ritm1780305_anu_numu2nue_nue2nutau_rhc_skip15000_end_1621 $file
    rucio attach fardet-vd:duplicatesvalidation1621 $file
done
for file in `cat 1621.badreco2`
do
    python heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $file run
    rucio detach fardet-vd:fardet-vd-reco2_ritm1780305_anu_numu2nue_nue2nutau_rhc_skip15000_end_1621 $file
    rucio attach fardet-vd:duplicates1621 $file
done
