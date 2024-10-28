# example submission for using Lar to merge files
#export DATASET="schellma:mc.fardet-vd.le_mc_2024a.v09_91_04d00.hit-reconstructed.prodmarley_nue_cc_flat_dunevd10kt_1x8x14_3view_30deg.fcl.storagetest"
#export FCL=artcat.fcl
#export MERGE_VERSION=v09_91_02d01
export THEDATE=`date +%Y%m%dT%H%M%S`
export TAG=test-tar


export SKIP=2 # start at the begining 
export CHUNK=3 # merge 100 files at once
export NFILES=30 # place a small limit for testing, you can raise this a lot. if more need to be done you need to bump up skip to the previous NFILES
export DETECTOR=fardet-hd
export FILE_TYPE=mc
export DESTINATION=${DSCRATCH}/merging/tar_${DETECTOR}_${TAG}_${SKIP}_${NFILES}_${THEDATE}
export DESTINATION=local
export LISTFILE=examples/testlist.txt
python mergeRoot.py --listfile=$LISTFILE --file_type=$FILE_TYPE --detector=$DETECTOR \
  --maketar --chunk=$CHUNK --nfiles=$NFILES \
  --skip=$SKIP --debug --destination=$DESTINATION --merge_stage=final --direct_parentage
