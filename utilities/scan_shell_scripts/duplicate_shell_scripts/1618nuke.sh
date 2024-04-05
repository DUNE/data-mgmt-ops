#!/bin/bash
#for file in `cat 1618.badreco2ana`
#do
#    python heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $file run
#    rucio detach fardet-vd:fardet-vd-reco2ana_ritm1780305_anu_numu2nue_nue2nutau_rhc_skip0_limit5000_1618 $file
#    rucio attach fardet-vd:duplicatesreco2ana1618 $file
#
#done
#for file in `cat 1618.badpandora`
#do
#    python heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $file run
#    rucio detach  fardet-vd:fardet-vd-pandora_ritm1780305_anu_numu2nue_nue2nutau_rhc_skip0_limit5000_1618 $file
#    rucio attach fardet-vd:duplicatespandora1618 $file
#done
for file in `cat 1618.badvalidation`
do 
    python heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $file run
    rucio detach fardet-vd:fardet-vd-validation_ritm1780305_anu_numu2nue_nue2nutau_rhc_skip0_limit5000_1618 $file
    rucio attach fardet-vd:duplicatesvalidation1618 $file
done
for file in `cat 1618.badreco2`
do
    python heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $file run
    rucio detach fardet-vd:fardet-vd-reco2_ritm1780305_anu_numu2nue_nue2nutau_rhc_skip0_limit5000_1618 $file
    rucio attach fardet-vd:duplicates1618 $file
done
