# just does a submission


export THEDATE=`date +%F-%H.%M.%S`
export DESTINATION=${DSCRATCH}/merging/caf_${SKIP}_${NFILES}_${FCL}_${THEDATE}

python submitMerge.py --dataset=$DATASET --file_type=$FILE_TYPE --detector=$DETECTOR --merge_version=$MERGE_VERSION --uselar --lar_config=$FCL --chunk=$CHUNK --nfiles=$NFILES  --maketar --skip=$SKIP --destination=$DESTINATION --debug --merge_stage=makecaf
