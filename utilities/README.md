# utilities for data management

Please work on a branch and then do a pull request

Please list utilities and their use in this file.

## mergeMetaCat

takes a file and  list of filenames (either paths or metacat dids) used to make that file and creates new metadata.

complains and stops if you try to merge across a wide range of things you should not combine in one file

consistent = ["core.file_type","core.file_format","core.data_tier","core.group",'core.application','dune.campaign']

we can add to that list.
        


usage: mergeMetaCat.py [-h] [--fileName FILENAME] [--nameSpace NAMESPACE]
                       [--jsonList JSONLIST] [--fileList FILELIST] [-s S]
                       [-t T] [-u U] [--dataTier DATATIER]
                       [--application APPLICATION] [--version VERSION]

Merge Meta

options:

  -h, --help            show this help message and exit
  
  --fileName FILENAME   Name of merged file
  
  --nameSpace NAMESPACE                 Namespace for merged file
  
  --jsonList JSONLIST   Name of file containing list of json files if -t=local
  
  --fileList FILELIST   Name of file containing list of metacat did if
                        -t=metacat
                        
  -s S                  Do Sort?
  
  -t T                  local or metacat
  
  -u U                  Patch user to specified. Leave empty to not patch
  
  --dataTier DATATIER   data_tier for output
  
  --application APPLICATION
                        merge application name
                        
  --version VERSION     software version for merge

## mergeRoot.py

merge root files.  need to specify a workflow or a run number. Assumes this is data from hd-protodune running

- chunk is the # of files to merge at once
- skip is the starting file #
- nfiles is the total # of files to merge
- workflow or run need to be specified

right now it xrdcp's to local cache area and ignores some sites so not full production ready.

### example to run 2 jobs

~~~
mergeRoot.py --run=27309 --chunk=50 --skip=0 --nfiles=1000
mergeRoot.py --run=27309 --chunk=50 --skip=1000 --nfiles=1000
~~~


~~~
python mergeRoot.py  --help
usage: mergeRoot.py [-h] [--workflow WORKFLOW] [--chunk CHUNK] [--nfiles NFILES] [--skip SKIP]
                    [--run RUN]

Merge Data

optional arguments:
  -h, --help           show this help message and exit
  --workflow WORKFLOW  workflow id to merge
  --chunk CHUNK        number of files/merge
  --nfiles NFILES      number of files to merge total
  --skip SKIP          number of files to skip before doing nfiles
  --run RUN            run number
~~~

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

you need to edit MetaFixer.py to have a metacat query and choose a workflow list to run over.

this is in the __main__ at line ~ 263

You also choose test="parentage" to fix parentage or test="duplicates" to find duplicates.

You specify the data_tier and a run/test flag on the command line.

### parentage fixing 

set test="parentage" and the "run" flag on the command line, it will then fix parentage.  this has been done for all production so not needed anymore

### duplicate finding

The duplicate are identified in method:

 def dupfinder(self,filemd=None):

it currently just writes out a line to file:

 duplicates_<data_tier>_<workflow>_<timestamp>.txt

which contains the name of the duplicate file, which duplicate it is in the list, what it was found to be a duplicate of and the tag of the file used to see if it is of the same type. 

the program goes through the long list and will find the other file later, and tag it as a duplicate of the 1st.   

the program chunks the query up into groups of 100. 

One could either put the duplicate nuking code in this script or run over the lists it produces, if one runs over the lists, you need to start at the most childy data_tier and work up from there to avoid leaving orphans








