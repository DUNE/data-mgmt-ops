# merging scripts

H. Schellman, August 2024

## main script submitMerge.py

usage: submitMerge.py [-h] [--detector DETECTOR] [--dataset DATASET] [--chunk CHUNK]
                      [--nfiles NFILES] [--skip SKIP] [--run RUN]
                      [--destination DESTINATION] [--data_tier DATA_TIER]
                      [--file_type FILE_TYPE] [--application APPLICATION]
                      [--version VERSION] [--merge_version MERGE_VERSION] [--debug]
                      [--maketar] [--usetar USETAR] [--uselar]
                      [--lar_config LAR_CONFIG]

Merge root files

~~~
options:
  -h, --help            show this help message and exit
  --detector DETECTOR   detector id [hd-protodune]
  --dataset DATASET     metacat dataset
  --chunk CHUNK         number of files/merge
  --nfiles NFILES       number of files to merge total
  --skip SKIP           number of files to skip before doing nfiles
  --run RUN             run number
  --destination DESTINATION
                        destination directory
  --data_tier DATA_TIER
                        input data tier [root-tuple-virtual]
  --file_type FILE_TYPE
                        input detector or mc, default=detector
  --application APPLICATION
                        merge application name [inherits]
  --version VERSION     software version of files to merge (required for run/workflow)
  --merge_version MERGE_VERSION
                        software version for merged file [inherits]
  --debug               make very verbose
  --maketar             make a tarball
  --usetar USETAR       full path for existing tarball
  --uselar              use lar instead of hadd
  --lar_config LAR_CONFIG
                        fcl file to use with lar when making tuples, required with
                        --uselar
~~~

the `--run` and `--workflow` options create a query from DETECTOR, FILE_TYPE, DATA_TIER, VERSION

the --dataset option uses an existing metacat dataset and does not build its own query. 

example of submissions split up within a run

~~~
python submitMerge.py --run=28023 --chunk=50 --data_tier="root-tuple-virtual" --maketar --nfiles=2000 --version=v09_91_02d01 --skip=0 # first 2000
python submitMerge.py --run=28023 --chunk=50 --data_tier="root-tuple-virtual" --maketar --nfiles=2000 --version=v09_91_02d01 --skip=2000 # next 2000
....
~~~

example of using lar to create Cafs. 

here $MERGE_VERSION is the dunesw version you are running to do the merge

~~~
python submitMerge.py --dataset=$DATASET --file_type=$FILE_TYPE --detector=$DETECTOR --merge_version=$MERGE_VERSION --uselar --lar_config=$FCL --chunk=$CHUNK --nfiles=$NFILES  --maketar --skip=$SKIP --destination=$DESTINATION --debug
~~~

currently the lar version only works with datasets. 


## remote and local scripts


`interactive.sh` run this to set up fake batch mode

`remote.sh`, `remote_lar.sh` and `remote_dataset.sh` scripts that run on the remote system

`setup_remote.sh`, `setup_lar.sh` set up the remote environment

## depends on:

- CheckConfiguration.py
- CheckSum.py
- MakeTarball.py
- mergeMetaCat.py
- mergeRoot.py
- TimeUtil.py
- TypeChecker.py





