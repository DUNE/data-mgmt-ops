#!/bin/bash
# this is meant to split up a all_children file into reco2, Pandora, and validation
nutype=$1
grep 'reco2.root' ${nutype}_all_children > ${nutype}_all_reco2
grep 'Events.pndr' ${nutype}_all_children > ${nutype}_all_pandora
grep 'Validation.root' ${nutype}_all_children > ${nutype}_all_validation

cat ${nutype}_all_reco2 | sort > ${nutype}_all_reco2.compare
cat ${nutype}_all_pandora | sed -e 's/_Pandora_Events.pndr/.root/' | sort > ${nutype}_all_pandora.compare
cat ${nutype}_all_validation | sed -e 's/_Validation//' | sort > ${nutype}_all_validation.compare

diff ${nutype}_all_reco2.compare ${nutype}_all_pandora.compare | grep '^<' | sed -e 's/< //' > ${nutype}_rp_reco2only
diff ${nutype}_all_reco2.compare ${nutype}_all_pandora.compare | grep '^>' | sed -e 's/> //' > ${nutype}_rp_pandoraonly
diff ${nutype}_all_reco2.compare ${nutype}_all_validation.compare | grep '^<' | sed -e 's/< //' > ${nutype}_rv_reco2only
diff ${nutype}_all_reco2.compare ${nutype}_all_validation.compare | grep '^>' | sed -e 's/> //' > ${nutype}_rv_validationonly
diff ${nutype}_all_pandora.compare ${nutype}_all_validation.compare | grep '^<' | sed -e 's/< //' > ${nutype}_pv_pandoraonly
diff ${nutype}_all_pandora.compare ${nutype}_all_validation.compare | grep '^>' | sed -e 's/> //' > ${nutype}_pv_validationonly

