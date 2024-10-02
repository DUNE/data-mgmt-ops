#!/bin/sh

echo " this is special for larsoft"
echo '#cmd: 	cd $INPUT_TAR_DIR_LOCAL'
cd $INPUT_TAR_DIR_LOCAL

export USER=$USERNAME  # help fix not having user defined? 

echo '#cmd: 	echo "in code directory"'
echo "in code directory"

echo '#cmd: 	pwd'
pwd

echo '#cmd: 	ls -lt '
ls -lt 


#_PLUGIN_DIR=/usr/lib64/gfal2-plugins'
export GFAL_PLUGIN_DIR=/usr/lib64/gfal2-plugins

echo '#cmd: 	export GFAL_CONFIG_DIR=/etc/gfal2.d'
export GFAL_CONFIG_DIR=/etc/gfal2.d

echo '#cmd: 	ls'
ls


echo '#cmd: $INPUT_TAR_DIR_LOCAL/setup_lar.sh'
source $INPUT_TAR_DIR_LOCAL/setup_lar.sh

echo '#cmd: 	echo "after setup";pwd'
echo "after setup";pwd

which python


echo '#cmd: 	echo "go to scratch dir and run it"'
echo "go to scratch dir and run it"

echo '#cmd: 	cd $_CONDOR_SCRATCH_DIR'
cd $_CONDOR_SCRATCH_DIR

echo "env"

env > $SKIP_$NFILES_env.txt

echo 'python $INPUT_TAR_DIR_LOCAL/mergeRoot.py \
                --detector=${DETECTOR} \
                --chunk=${CHUNK} \
                --nfiles=${NFILES} \
                --file_type=$FILETYPE \
                --skip=$SKIP \
                --dataset=$DATASET \
                --data_tier=$DATA_TIER \
                --version=$VERSION \
                --merge_version=$MERGE_VERSION \
                --destination=local \
                --uselar \
                 --direct_parentage=$DIRECT_PARENTAGE \
                --lar_config=${LARCONFIG} '

time python $INPUT_TAR_DIR_LOCAL/mergeRoot.py --detector=${DETECTOR} --chunk=${CHUNK} \ 
--nfiles=${NFILES} --file_type=$FILETYPE --skip=$SKIP --dataset=$DATASET --data_tier=$DATA_TIER \ 
--version=$VERSION --merge_version=$MERGE_VERSION --destination=local --uselar --lar_config=${LARCONFIG}\
 --merge_stage=$STAGE  --direct_parentage=$DIRECT_PARENTAGE \>& local.log


echo "run returned " $?

cat local.log
mv local.log merged_${SKIP}_${CHUNK}_${TIMESTAMP}.log
ls 
echo "ifdh cp -D merged_${SKIP}_${CHUNK}_${TIMESTAMP}.log $DESTINATION"
ifdh cp -D merged_${SKIP}_${CHUNK}_${TIMESTAMP}.log $DESTINATION
echo '#cmd: 	ls -lrt'
ifdh cp -D *.root $DESTINATION
ifdh cp -D *.json $DESTINATION
ifdh cp -D *_env.txt  $DESTINATION
ls -lrt



