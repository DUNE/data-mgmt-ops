# example submission for using Lar to merge files
# export DATASET="schellma:mc.fardet-hd.le_mc_2024a.v09_91_04d00.hit-reconstructed.prodmarley_nue_es_flat_dune10kt_1x2x6.fcl.mergetest"
export FCL=artcat.fcl
export MERGE_VERSION=v09_91_02d01
export THEDATE=`date +%Y%m%dT%H%M%S`
export TAG=supernova
# VD
#export THELIST=4319_input.list
#export OUT_DATASET=fardet-vd:fardet-vd__hit-reconstructed__v09_91_04d00__standard_reco1_dunevd10kt_1x8x14_3view_30deg__prodmarley_nue_cc_flat_dunevd10kt_1x8x14_3view_30deg__out1__official 
# HD
export WFID=fdhd_marley_cc_04363.txt
export THELIST=examples/${WFID}
export OUT_DATASET=usertests:fardet-hd__hit-reconstructed__v09_91_04d00__reco1_supernova_dune10kt_1x2x6__prodmarley_nue_cc_flat_dune10kt_1x2x6__out1__official

export SKIP=0  # start at the begining 
export CHUNK=5 # merge 5 files at once
export NFILES=20 # place a small limit for testing, you can raise this a lot. if more need to be done you need to bump up skip to the previous NFILES


export OUTPUT_DATA_TIER=hit-reconstructed
export OUTPUT_NAMESPACE=usertests
export OUTPUT_FILE_FORMAT=artroot
export VERSION=v09_91_04d00
export DSCRATCH=/pnfs/dune/scratch/users/${USER}
#export DESTINATION=/exp/dune/data/users/epennacc/2024/merging/mergelar/le
export DESTINATION=${DSCRATCH}/merging/${DETECTOR}_${TAG}_${SKIP}_${NFILES}_${FCL}_${THEDATE}_${WFID}
export DESTINATION=local

python mergeRoot.py --listfile=$THELIST --output_data_tier=$OUTPUT_DATA_TIER \
  --output_file_format=$OUTPUT_FILE_FORMAT  \
  --output_namespace=$OUTPUT_NAMESPACE --input_version=$VERSION \
  --uselar --lar_config=fcl/$FCL  --chunk=$CHUNK --nfiles=$NFILES \
  --skip=$SKIP --destination=$DESTINATION --merge_stage=mergeLar --inherit_config --output_datasetName=$OUT_DATASET
