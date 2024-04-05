#!/bin/bash
#for file in `cat 1613.badreco2ana`
#do
#    python heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $file run
#    rucio detach fardet-vd:fardet-vd-reco2ana_ritm1780305_anu_rhc_skip15000_end_1613 $file
#    rucio attach fardet-vd:duplicatesreco2ana1613 $file
#done
#for file in `cat 1613.badpandora`
#do
#    python heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $file run
#    rucio detach fardet-vd:fardet-vd-pandora_ritm1780305_anu_rhc_skip15000_end_1613 $file
#    rucio attach fardet-vd:duplicatespandora1613 $file
#done
#for file in `cat 1613.badvalidation`
#do 
#    python heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $file run
#    rucio detach fardet-vd:fardet-vd-validation_ritm1780305_anu_rhc_skip15000_end_1613 $file
#    rucio attach fardet-vd:duplicatesvalidation1613 $file
#done
for file in `cat 1613.badreco2`
do
    python heidi_util/data-mgmt-ops/utilities/MetaNuker_test.py $file run
    rucio detach fardet-vd:fardet-vd-reco2_ritm1780305_anu_rhc_skip15000_end_1613 $file
    rucio attach fardet-vd:duplicates1613 $file
done
