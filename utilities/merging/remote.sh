#!/bin/sh
echo '#cmd: 	cd $INPUT_TAR_DIR_LOCAL'
cd $INPUT_TAR_DIR_LOCAL

# export DETECTOR='hd-protodune'
# export CHUNK=50
# export SKIP=0
# export NFILES=1000
# export DATA_TIER='root-tuple-virtual'
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


echo 'python $INPUT_TAR_DIR_LOCAL/mergeRoot.py  --detector=$DETECTOR --chunk=$CHUNK --nfiles $NFILES\
                --file_type=$FILETYPE \
                --skip=$SKIP --run=$RUN \
                --data_tier=$DATA_TIER\
                --version=$VERSION\
                --merge_version=$MERGE_VERSION \
                --destination=local\
                --debug'

time python $INPUT_TAR_DIR_LOCAL/mergeRoot.py  --detector=$DETECTOR --chunk=$CHUNK --nfiles $NFILES\
                --file_type=$FILETYPE \
                --skip=$SKIP --run=$RUN \
                --data_tier=$DATA_TIER \
                --version=$VERSION \
                --merge_version=$MERGE_VERSION \
                --destination=local\
                >& local.log


echo "run returned " $?

cat local.log
mv local.log run_${RUN}_${SKIP}_${CHUNK}_${DATA_TIER}.log
ls 
echo "ifdh cp -D run_${RUN}_${SKIP}_${CHUNK}_${DATA_TIER}.log $DESTINATION"
ifdh cp -D run_${RUN}_${SKIP}_${CHUNK}_${DATA_TIER}.log $DESTINATION
ifdh cp -D *.json $DESTINATION
ifdh cp -D *.root $DESTINATION 
echo '#cmd: 	ls -lrt'
ls -lrt



