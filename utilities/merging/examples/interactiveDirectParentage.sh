# example of an interactive merge from a list - this version expects that the files you are running over are already declared
export SKIP=0
export CHUNK=2
export NFILES=4
export DETECTOR=fardet-hd
export FILE_TYPE=mc
export OUTPUT_DATA_TIER=root-tuple
export OUTPUT_FILE_FORMAT="root"
export OUTPUT_NAMESPACE="usertests"
export THELIST=examples/test.txt

# THELIST contains a list of paths to the root files.
# this writes to the local disk - do not run in app area.

python mergeRoot.py --listfile=$THELIST  --file_type=$FILE_TYPE  --chunk=$CHUNK --nfiles=$NFILES --skip=$SKIP \
 --destination=local  --output_data_tier=$OUTPUT_DATA_TIER  --output_file_format=$OUTPUT_FILE_FORMAT \
 --output_namespace=$OUTPUT_NAMESPACE --merge_stage=direct-test  --direct_parentage --inherit_config #--debug
