#!/bin/bash
for file in `cat 1610.badreco2ana`
do
    python heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $file run
    rucio detach fardet-vd:fardet-vd-reco2ana_ritm1780305_anu_rhc_skip0_limit5000_1610 $file
    rucio attach fardet-vd:duplicatesreco2ana1610 $file
done
for file in `cat 1610.badpandora`
do
    python heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $file run
    rucio detach fardet-vd:fardet-vd-pandora_ritm1780305_anu_rhc_skip0_limit5000_1610 $file
    rucio attach fardet-vd:duplicatespandora1610 $file
done
for file in `cat 1610.badvalidation`
do 
    python heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $file run
    rucio detach fardet-vd:fardet-vd-validation_ritm1780305_anu_rhc_skip0_limit5000_1610 $file
    rucio attach fardet-vd:duplicatesvalidation1610 $file
done
for file in `cat 1610.badreco2`
do
    python heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $file run
    rucio detach fardet-vd:fardet-vd-reco2_ritm1780305_anu_rhc_skip0_limit5000_1610 $file
    rucio attach fardet-vd:duplicates1610 $file
done
