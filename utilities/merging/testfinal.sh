#export DATASET="fardet-hd:fardet-hd__full-reconstructed__v09_85_00d00__reco2_atmos_dune10kt_1x2x6_geov5__prodgenie_atmnu_max_weighted_randompolicy_dune10kt_1x2x6__out1__v1_official"
export DATASET="fardet-vd:fardet-vd__full-reconstructed__v09_81_00d02__reco2_dunevd10kt_nu_1x8x6_3view_30deg_geov3__prodgenie_nu_dunevd10kt_1x8x6_3view_30deg__out1__v2_official"
#export FCL=cafmaker_atmos_dune10kt_1x2x6_runreco-nuenergy-nuangular_geov5.fcl
#export FCL=cafmaker_dunevd10kt_1x8x6_3view_30deg_runreco-nuenergy_geov3.fcl
export MERGE_VERSION=v09_91_02d01

#source setup_lar.sh

export SKIP=0
export CHUNK=10000
export NFILES=10000
export DETECTOR=fardet-vd
export FILE_TYPE=mc
#python mergeRoot.py --dataset=$DATASET --detector=fardet-vd --merge_version=$MERGE_VERSION --uselar --lar_config=$FCL --chunk=50 --nfiles=100 --destination=local --debug >& lar.log 
python mergeRoot.py --listfile=$THELIST  --file_type=$FILE_TYPE  --chunk=$CHUNK --nfiles=$NFILES --skip=$SKIP --destination=local 
