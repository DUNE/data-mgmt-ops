# example submission for using Lar to merge files
export DATASET="schellma:mc.fardet-hd.le_mc_2024a.v09_91_04d00.hit-reconstructed.prodmarley_nue_es_flat_dune10kt_1x2x6.fcl.mergetest"
export FCL=artcat.fcl
export MERGE_VERSION=v09_91_02d01
export THEDATE=`date +%F-%H.%M.%S`
export TAG=supernova


export SKIP=0  # start at the begining 
export CHUNK=10 # merge 100 files at once
export NFILES=50 # place a small limit for testing, you can raise this a lot. if more need to be done you need to bump up skip to the previous NFILES
export DETECTOR=fardet-hd
export FILE_TYPE=mc
export DESTINATION=${DSCRATCH}/merging/${DETECTOR}_${TAG}_${SKIP}_${NFILES}_${FCL}_${THEDATE}
python mergeRoot.py --dataset=$DATASET --file_type=$FILE_TYPE --detector=$DETECTOR \
 --merge_version=$MERGE_VERSION --uselar --lar_config=fcl/$FCL --chunk=$CHUNK --nfiles=$NFILES \
  --skip=$SKIP --destination=$DESTINATION --debug --merge_stage=mergeLar --direct_parentage
