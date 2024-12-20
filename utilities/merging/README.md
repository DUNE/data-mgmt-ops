# merging scripts

H. Schellman, August 2024

## main script submitMerge.py

~~~
usage: submitMerge.py [-h] [--detector DETECTOR] [--input_dataset DATASET] [--chunk CHUNK] [--nfiles NFILES] [--skip SKIP] [--run RUN]
                      [--destination DESTINATION] [--input_data_tier DATA_TIER] [--file_type FILE_TYPE] [--application APPLICATION]
                      [--input_version VERSION] [--merge_version MERGE_VERSION] [--debug] [--maketar] [--usetarball USETAR] [--uselar]
                      [--lar_config LAR_CONFIG] [--merge_stage MERGE_STAGE] [--project_tag PROJECT_TAG]

Merge root files

options:
  -h, --help            show this help message and exit
  --detector DETECTOR   detector id [hd-protodune]
  --input_dataset DATASET     metacat dataset
  --chunk CHUNK         number of files/merge this step, should be < 100
  --nfiles NFILES       number of files to merge total
  --skip SKIP           number of files to skip before doing nfiles
  --run RUN             run number
  --destination DESTINATION
                        destination directory
  --input_data_tier DATA_TIER
                        input data tier [root-tuple-virtual]
  --file_type FILE_TYPE
                        input detector or mc, default=detector
  --application APPLICATION
                        merge application name [inherits]
  --input_version VERSION     software version of files to merge (required)
  --merge_version MERGE_VERSION
                        software version for merged file [inherits]
  --debug               make very verbose
  --maketar             make a tarball
  --usetarball USETAR       full path for existing tarball
  --uselar              use lar instead of hadd
  --lar_config LAR_CONFIG
                        fcl file to use with lar when making tuples, required with --uselar
  --merge_stage MERGE_STAGE
                        stage of merging, final for last step
  --project_tag PROJECT_TAG
                        tag to describe the project you are doing
~~~

the `--run` and `--workflow` options create a query from DETECTOR, FILE_TYPE, DATA_TIER, VERSION

the --input_dataset option uses an existing metacat dataset and does not build its own query. 

example of submissions split up within a run

~~~
python submitMerge.py --run=28023 --chunk=50 --input_data_tier="root-tuple-virtual" --detector="hd-protodune" --input_version=v09_91_02d01 --file_type=detector --maketar --nfiles=2000 --skip=0 --project_tag=hd-keepup-tuples# first 2000
python submitMerge.py --run=28023 --chunk=50 --input_data_tier="root-tuple-virtual" --detector="hd-protodune" --input_version=v09_91_02d01 --file_type=detector --maketar --nfiles=2000 --skip=2000 --project_tag=pdhd-keepup-tuples # next 2000
....
~~~

** See the `examples/README.md` and scripts for examples**


example of using lar to create Cafs. 

here $MERGE_VERSION is the dunesw version you are running to do the caf creation

~~~
python submitMerge.py --input_dataset=$INPUT_DATASET --file_type=$FILE_TYPE --detector=$DETECTOR --merge_version=$MERGE_VERSION --uselar --lar_config=$FCL --chunk=$CHUNK --nfiles=$NFILES  --maketar --skip=$SKIP --destination=$DESTINATION --project_tag=fdvd-make-caf--debug
~~~

currently the lar version only works with datasets. 


### remote and local scripts
`setup_local.sh`  use this to set up useful local parameters

`remote.sh`, `remote_lar.sh` and `remote_dataset.sh` scripts that run on the remote system

`setup_remote.sh`, `setup_lar.sh` set up the remote environment

### depends on:

- CheckConfiguration.py
- CheckSum.py
- MakeTarball.py
- mergeMetaCat.py
- mergeRoot.py
- TimeUtil.py
- TypeChecker.py

## Interactive Merge mergeRoot.py

`submitMerge.py` actually runs `mergeRoot.py` on the remote node but you can also run it interactively

`mergeRoot.py` interactive with the `--listfile` can be used as the last step to hadd those last tuples together without having to declare the intermediate files to metacat/rucio and then get them back.

arguments are similar to `submitMerge.py`

~~~
usage: mergeRoot.py [-h] [--listfile LISTFILE] [--workflow WORKFLOW] [--detector DETECTOR] [--chunk CHUNK] [--nfiles NFILES]
                    [--skip SKIP] [--run RUN] [--input_dataset DATASET] [--destination DESTINATION] [--input_data_tier DATA_TIER]
                    [--file_type FILE_TYPE] [--test] [--application APPLICATION] [--input_version VERSION] [--merge_version MERGE_VERSION]
                    [--debug] [--uselar] [--lar_config LAR_CONFIG] [--merge_stage MERGE_STAGE] 

Merge Data - need to choose run, workflow, dataset or listfile

options:
  -h, --help            show this help message and exit
  --listfile LISTFILE   file containing a list of files to merge, they must have json in the same director
  --workflow WORKFLOW   workflow id to merge
  --detector DETECTOR   detector id [hd-protodune]
  --chunk CHUNK         number of files/merge
  --nfiles NFILES       number of files to merge total
  --skip SKIP           number of files to skip before doing nfiles
  --run RUN             run number
  --input_dataset DATASET     dataset
  --destination DESTINATION
                        destination directory
  --input_data_tier DATA_TIER
                        input data tier [root-tuple-virtual]
  --file_type FILE_TYPE
                        input detector or mc, default=detector
  --test                write to test area
  --application APPLICATION
                        merge application name [inherits]
  --input_version VERSION     software version for input query
  --merge_version MERGE_VERSION
                        software version for merge [inherits]
  --debug               make very verbose
  --uselar              use lar instead of hadd
  --lar_config LAR_CONFIG
                        fcl file to use with lar when making tuples, required with --uselar
  --merge_stage MERGE_STAGE
                        stage of merging, final for last step
~~~


after your jobs run and you have all your output files you can do:

~~~
ls ${MERGING}/$1/*.root > $1.txt
export THELIST=$1.txt
~~~

and then something like this: 

# example of an interactive merge from a list
export SKIP=0
export CHUNK=10
export NFILES=200
export DETECTOR=fardet-hd
export FILE_TYPE=mc

# THELIST contains a list of paths to the root files.
# this writes to the local disk - do not run in app area.

python mergeRoot.py --listfile=$THELIST  --file_type=$FILE_TYPE  --chunk=$CHUNK --nfiles=$NFILES --skip=$SKIP --destination=local --merge_stage=final 



