#!/bin/bash
for file in `cat 1616rucioonlyreco2ana` ; do rucio detach fardet-vd:fardet-vd-reco2ana_ritm1780305_nu_numu2nue_nue2nutau_fhc_skip10000_limit5000_1616 $file ; rucio attach  fardet-vd:duplicatesreco2ana1616 $file  ; done
for file in `cat 1617rucioonlyreco2ana` ; do rucio detach fardet-vd:fardet-vd-reco2ana_ritm1780305_nu_numu2nue_nue2nutau_fhc_skip15000_end $file ; rucio attach  fardet-vd:duplicatesreco2ana1617 $file ; done
