# just does set up for a merge

export DATASET="fardet-vd:fardet-vd__full-reconstructed__v09_81_00d02__reco2_dunevd10kt_nu_1x8x6_3view_30deg_geov3__prodgenie_nu_dunevd10kt_1x8x6_3view_30deg__out1__v2_official"

export FCL=cafmaker_dunevd10kt_1x8x6_3view_30deg_runreco-nuenergy_geov3.fcl
export MERGE_VERSION=v09_91_02d01
export THEDATE=`date +%F-%H.%M.%S`



export SKIP=0
export CHUNK=100
export NFILES=10000
export DETECTOR=fardet-vd
export FILE_TYPE=mc
export DESTINATION=${DSCRATCH}/merging/caf_${SKIP}_${NFILES}_${FCL}_${THEDATE}

# use subonly to do the actual merge. 
#python submitMerge.py --dataset=$DATASET --file_type=$FILE_TYPE --detector=$DETECTOR --merge_version=$MERGE_VERSION --uselar --lar_config=$FCL --chunk=$CHUNK --nfiles=$NFILES  --maketar --skip=$SKIP --destination=$DESTINATION --debug --merge_stage=makecaf
