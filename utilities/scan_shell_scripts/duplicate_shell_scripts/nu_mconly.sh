#!/bin/bash
metacat query 'files from dune:all where core.data_tier="full-reconstructed" and dune.workflow["workflow_id"]=1650' | sort > 1650mcfiles.sort
rucio list-files fardet-hd:fardet-hd-reco2_ritm1780305_nu_fhc_skip0_limit6000_1650 | grep root | awk ' { print $2 } ' | sort > 1650ruciofiles.sort
metacat query 'files from dune:all where core.data_tier="full-reconstructed" and dune.workflow["workflow_id"]=1638' | sort > 1638mcfiles.sort
rucio list-files fardet-hd:fardet-hd-reco2_ritm1780305_nu_fhc_skip6000_limit1000_ | grep root | awk ' { print $2 } ' | sort > 1638ruciofiles.sort
metacat query 'files from dune:all where core.data_tier="full-reconstructed" and dune.workflow["workflow_id"]=1630' | sort > 1630mcfiles.sort
rucio list-files fardet-hd:fardet-hd-reco2_ritm1780305_nu_fhc_skip7000_limit5000_1630 | grep root | awk ' { print $2 } ' | sort > 1630ruciofiles.sort
metacat query 'files from dune:all where core.data_tier="full-reconstructed" and dune.workflow["workflow_id"]=1631' | sort > 1631mcfiles.sort
rucio list-files fardet-hd:fardet-hd-reco2_ritm1780305_nu_fhc_skip12000_limit5000_1631 | grep root | awk ' { print $2 } ' | sort > 1631ruciofiles.sort
metacat query 'files from dune:all where core.data_tier="full-reconstructed" and dune.workflow["workflow_id"]=1632' | sort > 1632mcfiles.sort
rucio list-files fardet-hd:fardet-hd-reco2_ritm1780305_nu_fhc_skip17000_end_1632 | grep root | awk ' { print $2 } ' | sort > 1632ruciofiles.sort
metacat query 'files from dune:all where core.data_tier="full-reconstructed" and dune.workflow["workflow_id"]=1633' | sort > 1633mcfiles.sort
rucio list-files fardet-hd:fardet-hd-reco2_ritm1780305_anu_rhc_skip0_limit5000_1633 | grep root | awk ' { print $2 } ' | sort > 1633ruciofiles.sort
metacat query 'files from dune:all where core.data_tier="full-reconstructed" and dune.workflow["workflow_id"]=1596' | sort > 1596mcfiles.sort
rucio list-files fardet-hd:fardet-hd-reco2_ritm1780305_anu_rhc_skip5000_limit5000_1596 | grep root | awk ' { print $2 } ' | sort > 1596ruciofiles.sort
metacat query 'files from dune:all where core.data_tier="full-reconstructed" and dune.workflow["workflow_id"]=1597' | sort > 1597mcfiles.sort
rucio list-files fardet-hd:fardet-hd-reco2_ritm1780305_anu_rhc_skip10000_limit5000_1597 | grep root | awk ' { print $2 } ' | sort > 1597ruciofiles.sort
metacat query 'files from dune:all where core.data_tier="full-reconstructed" and dune.workflow["workflow_id"]=1598' | sort > 1598mcfiles.sort
rucio list-files fardet-hd:fardet-hd-reco2_ritm1780305_anu_rhc_skip15000_end_1598 | grep root | awk ' { print $2 } ' | sort > 1598ruciofiles.sort

