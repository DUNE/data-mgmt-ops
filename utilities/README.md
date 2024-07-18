# utilities for data management

Please work on a branch and then do a pull request

Please list utilities and their use in this file.

## mergeMetaCat

takes a merged file and a file containing a list of filenames (either paths to json files or metacat dids) that were merged to make that file and merges the metadata. 

complains and stops if you try to merge across a wide range of things you should not combine in one file

consistent = ["core.file_type","core.file_format","core.data_tier","core.group",'core.application','dune.campaign']

several options to change characteristics of the daughter file metadata but defaults to inheritance in most cases. 


        
~~~
python mergeMetaCat.py --help
usage: mergeMetaCat.py [-h] [--fileName FILENAME] [--nameSpace NAMESPACE] [--jsonList JSONLIST]
                       [--fileList FILELIST] [-s S] [-t T] [-u U] [--dataTier DATATIER]
                       [--application APPLICATION] [--version VERSION] [--debug]

Merge Meta

options:
  -h, --help            show this help message and exit
  --fileName FILENAME   Name of merged file
  --nameSpace NAMESPACE
                        new namespace for merged file [same as parents]
  --jsonList JSONLIST   Name of file containing list of json files if -t=local
  --fileList FILELIST   Name of file containing list of metacat did if -t=metacat
  -s S                  Do Sort?
  -t T                  local or metacat [metacat]
  -u U                  Patch user to specified. Leave empty to not patch
  --dataTier DATATIER   data_tier for output [root-tuple]
  --application APPLICATION
                        merge application name [inherits]
  --version VERSION     software version for merge [inherits]
  --debug               make very verbose

~~~

## mergeRoot.py

~~~
python mergeRoot.py --help
usage: mergeRoot.py [-h] [--workflow WORKFLOW] [--chunk CHUNK] [--nfiles NFILES] [--skip SKIP] [--run RUN]
                    [--destination DESTINATION] [--data_tier DATA_TIER] [--test]
                    [--application APPLICATION] [--version VERSION] [--debug]

Merge Data

optional arguments:
  -h, --help            show this help message and exit
  --workflow WORKFLOW   workflow id to merge
  --chunk CHUNK         number of files/merge
  --nfiles NFILES       number of files to merge total
  --skip SKIP           number of files to skip before doing nfiles
  --run RUN             run number
  --destination DESTINATION
                        destination directory
  --data_tier DATA_TIER
                        input data tier [root-tuple-virtual]
  --test                write to test area
  --application APPLICATION
                        merge application name [inherits]
  --version VERSION     software version for merge [inherits]
  --debug               make very verbose

merge root files.  need to specify a workflow or a run number. 

~~~

- chunk is the # of files to merge at once
- skip is the starting file # in the ordered list
- nfiles is the total # of files to merge
- workflow or run need to be specified

expects the input file to be at FNAL.

destination defaults to /pnfs/dune/persistent/users/$USER/merging


### example to run a long job

~~~
python mergeRoot.py --run=28023 --chunk=100 --nfiles=100000 --test 1>&28022.log
~~~

2024-07-17 Needs an addon script to mark merged files as done once it complete successfully.



## future duplicate nuking framework

Script MetaNuker is in development 

python MetaNuker.py <file to nuke with all its children> <test/fix>

Right now this just runs the search. Expert will need to implement the methods:

    success = ActualNuke(myfid=None,verbose=False,fix=False,level=-1):
    
Nukeme is supposed to retire the file and tell rucio it is gone.Here fid is the metacat fileid (hex field) of the file, verbose sets writing level, fix means actually do the nuke, level keeps track of what level you are in the tree from the top level file. 

    success = RemoveMeFromParents(myfid=myfid,verbose=verbose,fix=fix,level=level)




## Metafixer.py does checks and fixes parentage 

Has been updated to take command line arguments and do runs or workflows

~~~
python MetaFixer.py --help
usage: MetaFixer.py [-h] [--workflows] [--runs] [--min MIN] [--max MAX]
                    [--tests TESTS] [--data_tiers DATA_TIERS]
                    [--experiment EXPERIMENT] [--mc] [--fix] [--debug]

check and fix metadata

options:
  -h, --help            show this help message and exit
  --workflows           use worflow id for min/max
  --runs                use run id for min/max
  --min MIN             minimum id to check
  --max MAX             maximum id to check
  --tests TESTS         list of tests to run, comma delimited string
  --data_tiers DATA_TIERS
                        list of data_tiers to test
  --experiment EXPERIMENT
                        experiment
  --mc                  set if mc
  --fix                 do or suggest a fix
  --debug               do a short run with printout
~~~

`python MetaFixer.py --debug  --workflows --min=2383 --max=2383 `

defaults to `hd-protodune` and `full-reconstructed`
  
it can do either parentage fixes (largely done) or duplicate searches

You specify the data_tier and a run/test flag on the command line.

### parentage fixing 

set tests="parentage" and the "runs" flag on the command line, it will then fix parentage.  this has been done for all production so not needed anymore

 

### duplicate finding

The duplicate are identified in method:

 def dupfinder(self,filemd=None):

it currently just writes out a line to file:

 duplicates_<data_tier>_<workflow>_<timestamp>.txt

which contains the name of the duplicate file, which duplicate it is in the list, what it was found to be a duplicate of and the tag of the file used to see if it is of the same type. 

the program goes through the long list and will find the other file later, and tag it as a duplicate of the 1st.   

the program chunks the query up into groups of 100. 

One could either put the duplicate nuking code in this script or run over the lists it produces, if one runs over the lists, you need to start at the most childy data_tier and work up from there to avoid leaving orphans








