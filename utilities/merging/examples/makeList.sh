# make a list to merge from an output directory
ls ${MERGING}/$1/*.root > $1.txt
export THELIST=$1.txt
