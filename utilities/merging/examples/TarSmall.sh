# example submission for using Lar to merge files
export DATASET="schellma:mc.fardet-vd.le_mc_2024a.v09_91_04d00.hit-reconstructed.prodmarley_nue_cc_flat_dunevd10kt_1x8x14_3view_30deg.fcl.storagetest"
#export FCL=artcat.fcl
#export MERGE_VERSION=v09_91_02d01
export THEDATE=`date +%Y%m%dT%H%M%S`
export TAG=atmnu_max_weighted_randompolicy


export SKIP=0  # start at the begining 
export CHUNK=10 # merge 100 files at once
export NFILES=50 # place a small limit for testing, you can raise this a lot. if more need to be done you need to bump up skip to the previous NFILES
export DETECTOR=fardet-hd
export FILE_TYPE=mc
export DESTINATION=${DSCRATCH}/merging/tar_${DETECTOR}_${TAG}_${SKIP}_${NFILES}_${THEDATE}
export DESTINATION=local
python mergeRoot.py --dataset=$DATASET --file_type=$FILE_TYPE --detector=$DETECTOR \
 --merge_version=tar --maketar --chunk=$CHUNK --nfiles=$NFILES \
  --skip=$SKIP --debug --destination=$DESTINATION --merge_stage=final --direct_parentage
