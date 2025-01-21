# merging scripts

H. Schellman, August 2024

## main script submitMerge.py

~~~
python submitMerge.py --help
usage: submitMerge.py [-h] [--detector DETECTOR] [--input_dataset INPUT_DATASET] [--chunk CHUNK]
                      [--nfiles NFILES] [--skip SKIP] [--run RUN] [--destination DESTINATION]
                      [--input_data_tier INPUT_DATA_TIER] [--output_data_tier OUTPUT_DATA_TIER]
                      [--output_file_format OUTPUT_FILE_FORMAT] [--output_namespace OUTPUT_NAMESPACE]
                      [--file_type FILE_TYPE] [--application APPLICATION] [--input_version INPUT_VERSION]
                      [--merge_version MERGE_VERSION] [--debug] [--maketarball] [--usetarball USETARBALL]
                      [--uselar] [--lar_config LAR_CONFIG] [--merge_stage MERGE_STAGE]
                      [--project_tag PROJECT_TAG] [--direct_parentage] [--inherit_config]
                      [--output_datasetName OUTPUT_DATASETNAME] [--campaign CAMPAIGN]

Merge root files

optional arguments:
  -h, --help            show this help message and exit
  --detector DETECTOR   detector id [hd-protodune]
  --input_dataset INPUT_DATASET
                        metacat dataset as input
  --chunk CHUNK         number of files/merge this step, should be < 100
  --nfiles NFILES       number of files to merge total
  --skip SKIP           number of files to skip before doing nfiles
  --run RUN             run number
  --destination DESTINATION
                        destination directory
  --input_data_tier INPUT_DATA_TIER
                        input data tier [root-tuple-virtual]
  --output_data_tier OUTPUT_DATA_TIER
                        output data tier
  --output_file_format OUTPUT_FILE_FORMAT
                        output file_format [None]
  --output_namespace OUTPUT_NAMESPACE
                        output namespace [None]
  --file_type FILE_TYPE
                        input detector or mc, default=detector
  --application APPLICATION
                        merge application name [inherits]
  --input_version INPUT_VERSION
                        software version of files to merge (required)
  --merge_version MERGE_VERSION
                        software version for merged file [inherits]
  --debug               make very verbose
  --maketarball         make a tarball of source
  --usetarball USETARBALL
                        full path for existing tarball
  --uselar              use lar instead of hadd or tar
  --lar_config LAR_CONFIG
                        fcl file to use with lar when making tuples, required with --uselar
  --merge_stage MERGE_STAGE
                        stage of merging, final for last step
  --project_tag PROJECT_TAG
                        tag to describe the project you are doing
  --direct_parentage    parents are the files you are merging, not their parents
  --inherit_config      inherit config file - use for hadd stype merges
  --output_datasetName OUTPUT_DATASETNAME
                        optional name of output dataset this will go into
  --campaign CAMPAIGN   campaign for the merge, default is campaign of the parents
~~~

the `--run` and `--workflow` options create a query from DETECTOR, FILE_TYPE, DATA_TIER, VERSION

the --input_dataset option uses an existing metacat dataset and does not build its own query. 

example of submissions split up within a run

~~~
python submitMerge.py --run $RUN --input_version=$INPUT_VERSION --skip=$SKIP --chunk=$CHUNK --nfiles=$NFILES\
 --file_type=$FILETYPE --detector=$DETECTOR --input_data_tier=$INPUT_DATA_TIER --output_data_tier=$OUTPUT_DATA_TIER  \
 --output_file_format=$OUTPUT_FILE_FORMAT --output_namespace=$OUTPUT_NAMESPACE --merge_stage=$STAGE --inherit_config --maketar
~~~

** See the `examples/README.md` and scripts for examples**


example of using lar to create Cafs. 

here $MERGE_VERSION is the dunesw version you are running to do the caf creation

~~~
python submitMerge.py --input_dataset=$INPUT_DATASET --file_type=$FILE_TYPE --detector=$DETECTOR \
 --merge_version=$MERGE_VERSION --uselar --lar_config=$FCL --chunk=$CHUNK --nfiles=$NFILES \
  --maketar --skip=$SKIP --output_data_tier=$OUTPUT_DATA_TIER  --output_file_format=$OUTPUT_FILE_FORMAT \
  --output_namespace=$OUTPUT_NAMESPACE --destination=$DESTINATION --debug --merge_stage=makecaf \
  --project_tag="fdvd-makecaf-nuenergy" --campaign="special-caf-Oct-24"
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
usage: mergeRoot.py [-h] [--listfile LISTFILE] [--workflow WORKFLOW] [--detector DETECTOR] [--chunk CHUNK]
                    [--nfiles NFILES] [--skip SKIP] [--run RUN] [--input_dataset INPUT_DATASET]
                    [--destination DESTINATION] [--input_data_tier INPUT_DATA_TIER]
                    [--output_data_tier OUTPUT_DATA_TIER] [--output_file_format OUTPUT_FILE_FORMAT]
                    [--output_namespace OUTPUT_NAMESPACE] [--file_type FILE_TYPE] [--test]
                    [--application APPLICATION] [--input_version INPUT_VERSION]
                    [--merge_version MERGE_VERSION] [--debug] [--uselar] [--lar_config LAR_CONFIG]
                    [--merge_stage MERGE_STAGE] [--direct_parentage]
                    [--output_datasetName OUTPUT_DATASETNAME] [--mergetar] [--copylocal]
                    [--campaign CAMPAIGN] [--inherit_config]

Merge Data - need to choose run, workflow, dataset or listfile

optional arguments:
  -h, --help            show this help message and exit
  --listfile LISTFILE   file containing a list of files to merge, they must have json in the same directory
  --workflow WORKFLOW   workflow id to merge
  --detector DETECTOR   detector id [hd-protodune]
  --chunk CHUNK         number of files/merge
  --nfiles NFILES       number of files to merge total
  --skip SKIP           number of files to skip before doing nfiles
  --run RUN             run number
  --input_dataset INPUT_DATASET
                        input dataset
  --destination DESTINATION
                        destination directory
  --input_data_tier INPUT_DATA_TIER
                        input data tier [root-tuple-virtual]
  --output_data_tier OUTPUT_DATA_TIER
                        output data tier [None]
  --output_file_format OUTPUT_FILE_FORMAT
                        output file_format [None]
  --output_namespace OUTPUT_NAMESPACE
                        output namespace [None]
  --file_type FILE_TYPE
                        input detector or mc, default=detector
  --test                write to test area
  --application APPLICATION
                        merge application name [inherits]
  --input_version INPUT_VERSION
                        software version for input query
  --merge_version MERGE_VERSION
                        software version for merge [inherits]
  --debug               make very verbose
  --uselar              use lar instead of hadd
  --lar_config LAR_CONFIG
                        fcl file to use with lar when making tuples, required with --uselar
  --merge_stage MERGE_STAGE
                        stage of merging, final for last step
  --direct_parentage    parents are the files you are merging, not their parents
  --output_datasetName OUTPUT_DATASETNAME
                        optional name of output dataset this will go into
  --mergetar            make a gzipped tar file
  --copylocal           copy files to local cache from remote
  --campaign CAMPAIGN   campaign for the merge, default is campaign of the parents
  --inherit_config      inherit config file - use for hadd stype merges
~~~

Examples that only run interactively:

merge lar files using lar

  ~~~
  python mergeRoot.py --listfile=$THELIST --output_data_tier=$OUTPUT_DATA_TIER \
    --output_file_format=$OUTPUT_FILE_FORMAT  \
    --output_namespace=$OUTPUT_NAMESPACE --input_version=$VERSION \
    --uselar --lar_config=fcl/$FCL  --chunk=$CHUNK --nfiles=$NFILES \
    --skip=$SKIP --destination=$DESTINATION --debug --merge_stage=mergeLar \
    --inherit_config --output_datasetName=$OUT_DATASET
  ~~~

merge any files using tar

  ~~~
  python mergeRoot.py --listfile=$LISTFILE --file_type=$FILE_TYPE --detector=$DETECTOR \
    --mergetar  --chunk=$CHUNK --nfiles=$NFILES  \
    --skip=$SKIP --output_data_tier=$OUTPUT_DATA_TIER  --output_file_format=$OUTPUT_FILE_FORMAT \
    --output_namespace=$OUTPUT_NAMESPACE --destination=$DESTINATION \
    --debug --merge_stage=final --direct_parentage --inherit_config #--copylocal  disable for now
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

python mergeRoot.py --listfile=$THELIST --copylocal --output_data_tier=$OUTPUT_DATA_TIER \
 --output_file_format=$OUTPUT_FILE_FORMAT --output_namespace=$OUTPUT_NAMESPACE \ 
 --file_type=$FILE_TYPE  --chunk=$CHUNK --nfiles=$NFILES --skip=$SKIP --inherit_config \ 
 --destination=local --merge_stage=final --debug 

