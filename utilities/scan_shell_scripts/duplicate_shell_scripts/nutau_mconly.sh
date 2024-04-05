#!/bin/bash
metacat query 'files from dune:all where core.data_tier="full-reconstructed" and dune.workflow["workflow_id"]=1581' | sort > 1581mcfiles.sort
rucio list-files fardet-hd:fardet-hd-reco2_ritm1780305_nutau_fhc_skip0_limit5000_1581 | grep root | awk ' { print $2 } ' | sort > 1581ruciofiles.sort
metacat query 'files from dune:all where core.data_tier="full-reconstructed" and dune.workflow["workflow_id"]=1582' | sort > 1582mcfiles.sort
rucio list-files fardet-hd:fardet-hd-reco2_ritm1780305_nutau_fhc_skip5000_limit5000_1582 | grep root | awk ' { print $2 } ' | sort > 1582ruciofiles.sort
metacat query 'files from dune:all where core.data_tier="full-reconstructed" and dune.workflow["workflow_id"]=1584' | sort > 1584mcfiles.sort
rucio list-files fardet-hd:fardet-hd-reco2_ritm1780305_nutau_fhc_skip10000_limit5000_1584 | grep root | awk ' { print $2 } ' | sort > 1584ruciofiles.sort
metacat query 'files from dune:all where core.data_tier="full-reconstructed" and dune.workflow["workflow_id"]=1594' | sort > 1594mcfiles.sort
rucio list-files fardet-hd:fardet-hd-reco2_ritm1780305_nutau_fhc_skip15000_end_1594 | grep root | awk ' { print $2 } ' | sort > 1594ruciofiles.sort
metacat query 'files from dune:all where core.data_tier="full-reconstructed" and dune.workflow["workflow_id"]=1586' | sort > 1586mcfiles.sort
rucio list-files fardet-hd:fardet-hd-reco2_ritm1780305_anutau_rhc_skip0_limit5000_1586 | grep root | awk ' { print $2 } ' | sort > 1586ruciofiles.sort
metacat query 'files from dune:all where core.data_tier="full-reconstructed" and dune.workflow["workflow_id"]=1587' | sort > 1587mcfiles.sort
rucio list-files fardet-hd:fardet-hd-reco2_ritm1780305_anutau_rhc_skip5000_limit5000_1587 | grep root | awk ' { print $2 } ' | sort > 1587ruciofiles.sort
metacat query 'files from dune:all where core.data_tier="full-reconstructed" and dune.workflow["workflow_id"]=1588' | sort > 1588mcfiles.sort
rucio list-files fardet-hd:fardet-hd-reco2_ritm1780305_anutau_rhc_skip10000_limit5000_1588 | grep root | awk ' { print $2 } ' | sort > 1588ruciofiles.sort
metacat query 'files from dune:all where core.data_tier="full-reconstructed" and dune.workflow["workflow_id"]=1595' | sort > 1595mcfiles.sort
rucio list-files fardet-hd:fardet-hd-reco2_ritm1780305_anutau_rhc_skip15000_end_1595 | grep root | awk ' { print $2 } ' | sort > 1595ruciofiles.sort

