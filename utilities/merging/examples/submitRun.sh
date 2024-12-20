# example to submit a job to merge keepup outputs from a single run
# 
export RUN=28005
export VERSION=v09_91_02d01  # this is used to chose the files to merge
export DETECTOR=hd-protodune
export FILETYPE=detector
export INPUT_DATA_TIER="root-tuple-virtual"
export OUTPUT_DATA_TIER="root-tuple"
export OUTPUT_FILE_FORMAT="root"
export INPUT_VERSION=v09_91_02d01
export OUTPUT_NAMESPACE="usertests"

# these say how the merging will be done 
export SKIP=0
export CHUNK=50
export NFILES=100
export STAGE=testing

python submitMerge.py --run $RUN --input_version=$INPUT_VERSION --skip=$SKIP --chunk=$CHUNK --nfiles=$NFILES\
 --file_type=$FILETYPE --detector=$DETECTOR --input_data_tier=$INPUT_DATA_TIER --output_data_tier=$OUTPUT_DATA_TIER  \
 --output_file_format=$OUTPUT_FILE_FORMAT --output_namespace=$OUTPUT_NAMESPACE --merge_stage=$STAGE --maketar
