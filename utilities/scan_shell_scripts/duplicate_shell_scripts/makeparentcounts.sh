#!/bin/bash
metacat query 'parents(children( files from higuera:fardet-hd__fd_mc_2023a__mc__hit-reconstructed__prodgenie_nue_dune10kt_1x2x6.fcl__v09_78_01d01__preliminary skip 10000 limit 5000))' | sort | uniq -c > 1601parentcounts
metacat query 'parents(children( files from higuera:fardet-hd__fd_mc_2023a__mc__hit-reconstructed__prodgenie_nue_dune10kt_1x2x6.fcl__v09_78_01d01__preliminary skip 15000 ))' | sort | uniq -c > 1602parentcounts
metacat query 'parents(children( files from higuera:fardet-hd__fd_mc_2023a__mc__hit-reconstructed__prodgenie_anue_dune10kt_1x2x6.fcl__v09_78_01d01__preliminary skip 0 limit 5000))' | sort | uniq -c > 1604parentcounts
metacat query 'parents(children( files from higuera:fardet-hd__fd_mc_2023a__mc__hit-reconstructed__prodgenie_anue_dune10kt_1x2x6.fcl__v09_78_01d01__preliminary skip 5000 limit 5000))' | sort | uniq -c > 1606parentcounts
metacat query 'parents(children( files from higuera:fardet-hd__fd_mc_2023a__mc__hit-reconstructed__prodgenie_anue_dune10kt_1x2x6.fcl__v09_78_01d01__preliminary skip 10000 limit 5000 ))' | sort | uniq -c  > 1608parentcounts
metacat query 'parents(children( files from higuera:fardet-hd__fd_mc_2023a__mc__hit-reconstructed__prodgenie_anue_dune10kt_1x2x6.fcl__v09_78_01d01__preliminary skip 15000 ))' | sort | uniq -c  > 1609parentcounts
