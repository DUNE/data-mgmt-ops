# merging scripts

H. Schellman, August 2024

## main script submitMerge.py

usage: submitMerge.py [-h] [--detector DETECTOR] [--chunk CHUNK]
                      [--nfiles NFILES] [--skip SKIP] [--run RUN]
                      [--destination DESTINATION] [--data_tier DATA_TIER]
                      [--application APPLICATION] [--version VERSION]
                      [--debug] [--maketar] [--usetar USETAR]

Merge root files by running batch jobs at FNAL using jobsub

options:
  -h, --help            show this help message and exit
  --detector DETECTOR   detector id [hd-protodune]
  --chunk CHUNK         number of files/merge
  --nfiles NFILES       number of files to merge total
  --skip SKIP           number of files to skip before doing nfiles
  --run RUN             run number
  --destination DESTINATION
                        destination directory
  --data_tier DATA_TIER
                        input data tier [root-tuple-virtual]
  --application APPLICATION
                        merge application name [inherits]
  --version VERSION     software version for merge [inherits]
  --debug               make very verbose
  --maketar             make a tarball
  --usetar USETAR       full path for existing tarball

example of submissions split up within a run

~~~
python submitMerge.py --run=28023 --chunk=50 --data_tier="root-tuple-virtual" --maketar --nfiles=2000 --skip=0
python submitMerge.py --run=28023 --chunk=50 --data_tier="root-tuple-virtual" --maketar --nfiles=2000 --skip=2000
....
~~~

## remote and local scripts


`interactive.sh` run this to set up fake batch mode

`remote.sh` script that runs on the remote system

`setup_remote.sh` set up the remote environment

## depends on:

- CheckConfiguration.py
- CheckSum.py
- MakeTarball.py
- mergeMetaCat.py
- mergeRoot.py
- TimeUtil.py
- TypeChecker.py





