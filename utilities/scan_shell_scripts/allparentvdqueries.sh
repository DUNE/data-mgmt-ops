#!/bin/bash
# if all is right each parent file should be listed exactly 3 times
# fardet-vd nu FHC
metacat query 'parents(children(files from higuera:fardet-vd__fd_mc_2023a__mc__hit-reconstructed__prodgenie_nu_dunevd10kt_1x8x6_3view_30deg.fcl__v09_75_03d00__preliminary))' >  vdnu_all_parents
# fardet-vd anu RHC
metacat query 'parents(children(files from higuera:fardet-vd__fd_mc_2023a__mc__hit-reconstructed__prodgenie_anu_dunevd10kt_1x8x6_3view_30deg.fcl__v09_75_03d00__preliminary))' > vdanu_all_parents
#fardet-vd nue FHC (numu2nue)
metacat query 'parents(children(files from higuera:fardet-vd__fd_mc_2023a__mc__hit-reconstructed__prodgenie_nu_numu2nue_nue2nutau_dunevd10kt_1x8x6_3view_30deg.fcl__v09_75_03d00__preliminary))' > vdnue_all_parents
#fardet-vd nue RHC (numu2nue)
metacat query 'parents(children(files from higuera:fardet-vd__fd_mc_2023a__mc__hit-reconstructed__prodgenie_anu_numu2nue_nue2nutau_dunevd10kt_1x8x6_3view_30deg.fcl__v09_75_03d00__preliminary))' > vdanue_all_parents
#fardet-vd nutau FHC
metacat query 'parents(children(files from higuera:fardet-vd__fd_mc_2023a__mc__hit-reconstructed__prodgenie_nu_numu2nutau_nue2numu_dunevd10kt_1x8x6_3view_30deg.fcl__v09_75_03d00__preliminary))'  > vdnutau_all_parents
#fardet-vd anutau RHC
metacat query 'parents(children(files from higuera:fardet-vd__fd_mc_2023a__mc__hit-reconstructed__prodgenie_anu_numu2nutau_nue2numu_dunevd10kt_1x8x6_3view_30deg.fcl__v09_75_03d00__preliminary))' > vdanutau_all_parents

