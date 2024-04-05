#!/bin/bash
metacat query 'files from dune:all where core.data_tier="full-reconstructed" and dune.workflow["workflow_id"]=1599' | sort > 1599mcfiles.sort
rucio list-files fardet-hd:fardet-hd-reco2_ritm1780305_nue_fhc_skip0_limit5000_1599 | grep root | awk ' { print $2 } ' | sort > 1599ruciofiles.sort
metacat query 'files from dune:all where core.data_tier="full-reconstructed" and dune.workflow["workflow_id"]=1600' | sort > 1600mcfiles.sort
rucio list-files fardet-hd:fardet-hd-reco2_ritm1780305_nue_fhc_skip5000_limit5000_1600 | grep root | awk ' { print $2 } ' | sort > 1600ruciofiles.sort
metacat query 'files from dune:all where core.data_tier="full-reconstructed" and dune.workflow["workflow_id"]=1601' | sort > 1601mcfiles.sort
rucio list-files fardet-hd:fardet-hd-reco2_ritm1780305_nue_fhc_skip10000_limit5000_1601 | grep root | awk ' { print $2 } ' | sort > 1601ruciofiles.sort
metacat query 'files from dune:all where core.data_tier="full-reconstructed" and dune.workflow["workflow_id"]=1602' | sort > 1602mcfiles.sort
rucio list-files fardet-hd:fardet-hd-reco2_ritm1780305_nue_fhc_skip15000_end_1602 | grep root | awk ' { print $2 } ' | sort > 1602ruciofiles.sort
metacat query 'files from dune:all where core.data_tier="full-reconstructed" and dune.workflow["workflow_id"]=1604' | sort > 1604mcfiles.sort
rucio list-files fardet-hd:fardet-hd-reco2_ritm1780305_anue_rhc_skip0_limit5000_1604 | grep root | awk ' { print $2 } ' | sort > 1604ruciofiles.sort
metacat query 'files from dune:all where core.data_tier="full-reconstructed" and dune.workflow["workflow_id"]=1606' | sort > 1606mcfiles.sort
rucio list-files fardet-hd:fardet-hd-reco2_ritm1780305_anue_rhc_skip5000_limit5000_1606 | grep root | awk ' { print $2 } ' | sort > 1606ruciofiles.sort
metacat query 'files from dune:all where core.data_tier="full-reconstructed" and dune.workflow["workflow_id"]=1608' | sort > 1608mcfiles.sort
rucio list-files fardet-hd:fardet-hd-reco2_ritm1780305_anue_rhc_skip10000_limit5000_1608 | grep root | awk ' { print $2 } ' | sort > 1608ruciofiles.sort
metacat query 'files from dune:all where core.data_tier="full-reconstructed" and dune.workflow["workflow_id"]=1609' | sort > 1609mcfiles.sort
rucio list-files fardet-hd:fardet-hd-reco2_ritm1780305_anue_rhc_skip15000_end_1609 | grep root | awk ' { print $2 } ' | sort > 1609ruciofiles.sort

