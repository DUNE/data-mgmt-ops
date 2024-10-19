# submit a job to merge keepup outputs from a single run as a test
# these are used to create a dataaset
export RUN=28005
export VERSION=v09_91_02d01  # this is used to chose the files to merge
export DETECTOR=hd-protodune
export FILETYPE=detector
export DATATIER="root-tuple-virtual"

# these say how the merging will be done 
export SKIP=0
export CHUNK=5
export NFILES=12
export STAGE=testing

python mergeRoot.py --run $RUN --version $VERSION --skip=$SKIP --chunk=$CHUNK --nfiles=$NFILES\
 --file_type=$FILETYPE --detector=$DETECTOR --data_tier=$DATATIER --merge_stage=$STAGE --destination=local
