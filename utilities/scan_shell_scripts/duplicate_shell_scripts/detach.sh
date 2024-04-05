#!/bin/bash
for file in `cat 1632.mcplusruciodsnoreplica` 
do echo $file 
     rucio list-parent-dids $file 
     rucio list-file-replicas $file
done
