# example of an interactive merge from a list - using hadd - can use undeclared files
export SKIP=0
export CHUNK=2
export NFILES=9
export DETECTOR=fardet-hd
export FILE_TYPE=mc
export OUTPUT_DATA_TER=root-tuple
export OUTPUT_FILE_FORMAT=root
export OUTPUT_NAMESPACE="usertests"

# THELIST contains a list of paths to the root files.
# this writes to the local disk - do not run in app area.
export THELIST=examples/test.txt
python mergeRoot.py --listfile=$THELIST --copylocal --output_data_tier=$OUTPUT_DATA_TIER \
 --output_file_format=$OUTPUT_FILE_FORMAT --output_namespace=$OUTPUT_NAMESPACE --file_type=$FILE_TYPE \
  --chunk=$CHUNK --nfiles=$NFILES --skip=$SKIP --inherit_config --destination=local --merge_stage=final # --debug 
