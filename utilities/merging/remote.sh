#!/bin/sh
## the environmentals in this file for job parameters will be replaced with real values in the submitMerge command

echo '#cmd: 	cd $INPUT_TAR_DIR_LOCAL'
cd $INPUT_TAR_DIR_LOCAL

# export DETECTOR='hd-protodune'
# export CHUNK=50
# export SKIP=0
# export NFILES=1000
# export INPUT_DATA_TIER='root-tuple-virtual'
# export RUN=28023

export USER=$USERNAME  # help fix not having user defined? 

echo '#cmd: 	echo "in code directory"'
echo "in code directory"

echo '#cmd: 	pwd'
pwd

echo '#cmd: 	ls -lt '
ls -lt 


#echo '#cmd: 	export GFAL_PLUGIN_DIR=/usr/lib64/gfal2-plugins'
#export GFAL_PLUGIN_DIR=/usr/lib64/gfal2-plugins

#echo '#cmd: 	export GFAL_CONFIG_DIR=/etc/gfal2.d'
#export GFAL_CONFIG_DIR=/etc/gfal2.d

echo '#cmd: 	ls'
ls


echo '#cmd: $INPUT_TAR_DIR_LOCAL/setup_remote.sh'
source $INPUT_TAR_DIR_LOCAL/setup_remote.sh

echo '#cmd: 	echo "after setup";pwd'
echo "after setup";pwd

echo '#cmd: 	echo "go to scratch dir and run it"'
echo "go to scratch dir and run it"

echo '#cmd: 	cd $_CONDOR_SCRATCH_DIR'
cd $_CONDOR_SCRATCH_DIR


echo " python $INPUT_TAR_DIR_LOCAL/mergeRoot.py --detector=$DETECTOR --nfiles=$NFILES --chunk=$CHUNK --file_type=$FILETYPE --run=$RUN --skip=$SKIP --input_data_tier=$INPUT_DATA_TIER  --output_data_tier=$OUTPUT_DATA_TIER  --output_file_format=$OUTPUT_FILE_FORMAT --merge_version=$MERGE_VERSION --destination=local --merge_stage=$STAGE --version=$VERSION $DIRECT_PARENTAGE --datasetName=${DATASETNAME} --campaign=$CAMPAIGN  >& local.log"


time python $INPUT_TAR_DIR_LOCAL/mergeRoot.py --detector=$DETECTOR --nfiles=$NFILES --chunk=$CHUNK --file_type=$FILETYPE --run=$RUN --skip=$SKIP --input_data_tier=$INPUT_DATA_TIER 
 --output_data_tier=$OUTPUT_DATA_TIER  --output_file_format=$OUTPUT_FILE_FORMAT --merge_version=$MERGE_VERSION --destination=local --merge_stage=$STAGE --version=$VERSION $DIRECT_PARENTAGE --datasetName=${DATASETNAME} --campaign=$CAMPAIGN >& local.log

export retcode=$?
echo "run returned " retcode

cat local.log
# mv local.log run_$RUN_$SKIP_$CHUNK_$INPUT_DATA_TIER.log
# ls 
echo "ifdh cp run_$RUN_$SKIP_$CHUNK_$INPUT_DATA_TIER.log $DESTINATION"
ls -lrt local.log
ifdh cp local.log $DESTINATION/run_$RUN_$SKIP_$CHUNK_$INPUT_DATA_TIER.log
ifdh cp -D *.json $DESTINATION
ifdh cp -D *.root $DESTINATION 
echo '#cmd: 	ls -lrt'
ls -lrt




