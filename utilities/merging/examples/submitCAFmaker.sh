# example batch submission for running lar on a dataset to make cafs
export INPUT_DATASET="fardet-vd:fardet-vd__full-reconstructed__v09_81_00d02__reco2_dunevd10kt_nu_1x8x6_3view_30deg_geov3__prodgenie_nu_dunevd10kt_1x8x6_3view_30deg__out1__v2_official"
export FCL=cafmaker_dunevd10kt_1x8x6_3view_30deg_runreco-nuenergy_geov3.fcl
export MERGE_VERSION=v09_91_02d01
export THEDATE=`date +%Y%m%dT%H%M%S`
export OUTPUT_DATA_TIER="root-tuple"
export OUTPUT_FILE_FORMAT="root"
export OUTPUT_NAMESPACE="usertests"


export SKIP=0  # start at the begining 
export CHUNK=20 # merge 20 files at once - you want to adjust this. 
export NFILES=50 # place a small limit for testing, you can raise this a lot. if more need to be done you need to bump up skip to the previous NFILES
export DETECTOR=fardet-vd
export FILE_TYPE=mc
export DESTINATION=${DSCRATCH}/merging/${DETECTOR}_${SKIP}_${NFILES}_${FCL}_${THEDATE}
python submitMerge.py --input_dataset=$INPUT_DATASET --file_type=$FILE_TYPE --detector=$DETECTOR \
 --merge_version=$MERGE_VERSION --uselar --lar_config=$FCL --chunk=$CHUNK --nfiles=$NFILES \
  --maketar --skip=$SKIP --output_data_tier=$OUTPUT_DATA_TIER  --output_file_format=$OUTPUT_FILE_FORMAT \
  --output_namespace=$OUTPUT_NAMESPACE --destination=$DESTINATION --debug --merge_stage=makecaf \
  --project_tag="fdvd-makecaf-nuenergy" --campaign="special-caf-Oct-24"
