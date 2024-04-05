#!/bin/bash
#parent queries for HD
# HD NU FHC
metacat query 'children(files from higuera:fardet-hd__fd_mc_2023a__mc__hit-reconstructed__prodgenie_nu_dune10kt_1x2x6.fcl__v09_78_01d01__preliminary)' > nu_all_children
# HD ANU RHC
metacat query 'children(files from higuera:fardet-hd__fd_mc_2023a__mc__hit-reconstructed__prodgenie_anu_dune10kt_1x2x6.fcl__v09_78_01d01__preliminary)' > anu_all_children
# HD NUE FHC
metacat query 'children(files from higuera:fardet-hd__fd_mc_2023a__mc__hit-reconstructed__prodgenie_nue_dune10kt_1x2x6.fcl__v09_78_01d01__preliminary)' > nue_all_children
#HD ANUE RHC
metacat query 'children(files from higuera:fardet-hd__fd_mc_2023a__mc__hit-reconstructed__prodgenie_anue_dune10kt_1x2x6.fcl__v09_78_01d01__preliminary)' > anue_all_children
#HD NUTAU FHC
metacat query 'children(files from higuera:fardet-hd__fd_mc_2023a__mc__hit-reconstructed__prodgenie_nutau_dune10kt_1x2x6.fcl__v09_78_01d01__preliminary )' > nutau_all_children
#HD ANUTAU_RHC
metacat query 'children(files from higuera:fardet-hd__fd_mc_2023a__mc__hit-reconstructed__prodgenie_anutau_dune10kt_1x2x6.fcl__v09_78_01d01__preliminary)' > anutau_all_children
