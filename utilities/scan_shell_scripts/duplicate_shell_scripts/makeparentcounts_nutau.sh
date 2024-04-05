#!/bin/bash
metacat query 'parents(children( files from higuera:fardet-hd__fd_mc_2023a__mc__hit-reconstructed__prodgenie_nutau_dune10kt_1x2x6.fcl__v09_78_01d01__preliminary skip 0 limit 5000))' | sort | uniq -c > 1581parentcounts
metacat query 'parents(children( files from higuera:fardet-hd__fd_mc_2023a__mc__hit-reconstructed__prodgenie_nutau_dune10kt_1x2x6.fcl__v09_78_01d01__preliminary skip 5000 limit 5000))' | sort | uniq -c > 1582parentcounts
metacat query 'parents(children( files from higuera:fardet-hd__fd_mc_2023a__mc__hit-reconstructed__prodgenie_nutau_dune10kt_1x2x6.fcl__v09_78_01d01__preliminary skip 10000 limit 5000))' | sort | uniq -c > 1584parentcounts
metacat query 'parents(children( files from higuera:fardet-hd__fd_mc_2023a__mc__hit-reconstructed__prodgenie_nutau_dune10kt_1x2x6.fcl__v09_78_01d01__preliminary skip 15000 ))' | sort | uniq -c > 1594parentcounts
metacat query 'parents(children( files from higuera:fardet-hd__fd_mc_2023a__mc__hit-reconstructed__prodgenie_anutau_dune10kt_1x2x6.fcl__v09_78_01d01__preliminary skip 0 limit 5000))' | sort | uniq -c > 1586parentcounts
metacat query 'parents(children( files from higuera:fardet-hd__fd_mc_2023a__mc__hit-reconstructed__prodgenie_anutau_dune10kt_1x2x6.fcl__v09_78_01d01__preliminary skip 5000 limit 5000))' | sort | uniq -c > 1587parentcounts
metacat query 'parents(children( files from higuera:fardet-hd__fd_mc_2023a__mc__hit-reconstructed__prodgenie_anutau_dune10kt_1x2x6.fcl__v09_78_01d01__preliminary skip 10000 limit 5000 ))' | sort | uniq -c  > 1588parentcounts
metacat query 'parents(children( files from higuera:fardet-hd__fd_mc_2023a__mc__hit-reconstructed__prodgenie_anutau_dune10kt_1x2x6.fcl__v09_78_01d01__preliminary skip 15000 ))' | sort | uniq -c  > 1595parentcounts
