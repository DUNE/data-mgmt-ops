# example interactive script for using Lar to merge files with Lar output
export OUTPUT_DATASETNAME="schellma:mc.fardet-hd.le_mc_2024a.v09_91_04d00.hit-reconstructed.prodmarley_nue_es_flat_dune10kt_1x2x6.fcl.mergetest"
export FCL=artcat.fcl
export MERGE_VERSION=v09_91_02d01
export THEDATE=`date +%Y%m%dT%H%M%S`
export TAG=supernova
export OUTPUT_DATA_TIER="hit-reconstructed"
export OUTPUT_FILE_FORMAT="artroot"
export OUTPUT_NAMESPACE="usertests"
export THEFILELIST="examples/fdhd_marley_cc_04363.txt"


export SKIP=0  # start at the begining 
export CHUNK=50 # merge 100 files at once
export NFILES=200 # place a small limit for testing, you can raise this a lot. if more need to be done you need to bump up skip to the previous NFILES
export DETECTOR=fardet-hd
export FILE_TYPE=mc
export DESTINATION=${DSCRATCH}/merging/${DETECTOR}_${TAG}_${SKIP}_${NFILES}_${FCL}_${THEDATE}
export DESTINATION=${PWD} # test locally
python mergeRoot.py --listfile=$THEFILELIST \
 --merge_version=$MERGE_VERSION --uselar --lar_config=fcl/$FCL --chunk=$CHUNK --nfiles=$NFILES \
  --skip=$SKIP --output_data_tier=$OUTPUT_DATA_TIER  --output_file_format=$OUTPUT_FILE_FORMAT \
  --output_namespace=$OUTPUT_NAMESPACE --destination=$DESTINATION --debug --merge_stage=mergeLar \
  --output_datasetName=$OUTPUT_DATASETNAME
