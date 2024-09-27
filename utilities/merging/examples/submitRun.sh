# submit a job to merge keepup outputs from a single run
# these are used to create a dataaset
export RUN=28542
export VERSION=v09_91_02d01  # this is used to chose the files to merge
export DETECTOR=hd-protodune
export FILETYPE=detector
export DATATIER="root-tuple-virtual"

# these say how the merging will be done 
export SKIP=0
export CHUNK=100
export NFILES=3000
export STAGE=stage1

python submitMerge.py --run $RUN --version $VERSION --skip=$SKIP --chunk=$CHUNK --nfiles=$NFILES\
 --file_type=$FILETYPE --detector=$DETECTOR --data_tier=$DATATIER --merge_stage=$STAGE --maketar
