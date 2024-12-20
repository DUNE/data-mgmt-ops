## Examples



there are scripts to 

`submitRun.sh` -- example of submitting a run from protodune-hd keepup

`submitCAFmaker.sh` -- example of submitting a LAR job to make cafs

`interactiveMerge.sh` -- example of using a list of tuple files interactively to do a final merge - parents are parents of the inputs - works if the files you are merging have not been declared.

`interactiveDirectParentage.sh` -- example of using a list of tuple files interactively to do a final merge - parents are the inputs themselves. This only works if the files you are merging have been declared. 

`MergeLar_hd.sh` -- example of using lar to merge files with no modes, uses the inherit_config flag. 

`MergeTar.sh` -- example of merging files from a list into a tarball  

# a utility

`makeList.sh` -- example of making a list of files from the outputs of a batch job to input to `interactiveMerge.sh`


