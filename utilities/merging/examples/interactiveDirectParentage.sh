# example of an interactive merge from a list
export SKIP=0
export CHUNK=2
export NFILES=4
export DETECTOR=fardet-hd
export FILE_TYPE=mc

# THELIST contains a list of paths to the root files.
# this writes to the local disk - do not run in app area.

python mergeRoot.py --listfile=$THELIST  --file_type=$FILE_TYPE  --chunk=$CHUNK --nfiles=$NFILES --skip=$SKIP \
--destination=local --merge_stage=final --direct_parentage --debug
