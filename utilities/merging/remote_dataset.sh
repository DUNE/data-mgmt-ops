#!/bin/sh
echo '#cmd: 	cd $INPUT_TAR_DIR_LOCAL'

## the environmentals in this file for job parameters will be replaced with real values in the submitMerge command

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


echo "python $INPUT_TAR_DIR_LOCAL/mergeRoot.py --detector=$DETECTOR --nfiles $NFILES --chunk=$CHUNK --file_type=$FILETYPE --skip=$SKIP --input_dataset=$INPUT_DATASET --input_data_tier=$INPUT_DATA_TIER  --output_data_tier=$OUTPUT_DATA_TIER  --output_file_format=$OUTPUT_FILE_FORMAT --output_namespace=$OUTPUT_NAMESPACE --input_version=$VERSION --merge_version=$MERGE_VERSION --destination=local --merge_stage=$STAGE --output_datasetName=${OUTPUT_DATASETNAME} $DIRECT_PARENTAGE  $INHERIT_CONFIG --campaign=$CAMPAIGN >& local.log"

time python $INPUT_TAR_DIR_LOCAL/mergeRoot.py --detector=$DETECTOR --nfiles $NFILES --chunk=$CHUNK --file_type=$FILETYPE --skip=$SKIP --input_dataset=$INPUT_DATASET --input_data_tier=$INPUT_DATA_TIER  --output_data_tier=$OUTPUT_DATA_TIER  --output_file_format=$OUTPUT_FILE_FORMAT  --output_namespace=$OUTPUT_NAMESPACE --input_version=$VERSION --merge_version=$MERGE_VERSION --destination=local --merge_stage=$STAGE --output_datasetName=${OUTPUT_DATASETNAME} $DIRECT_PARENTAGE $INHERIT_CONFIG --campaign=$CAMPAIGN >& local.log


echo "run returned " $?

cat local.log
mv local.log merged_$SKIP_$CHUNK_$TIMESTAMP.log
ls 
echo "ifdh cp -D merged_$SKIP_$CHUNK_$TIMESTAMP.log $DESTINATION"
ifdh cp -D merged_$SKIP_$CHUNK_$TIMESTAMP.log $DESTINATION
echo '#cmd: 	ls -lrt'
ifdh cp -D *.root $DESTINATION
ifdh cp -D *.json $DESTINATION
ls -lrt



