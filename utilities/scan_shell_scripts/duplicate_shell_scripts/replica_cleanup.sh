#!/bin/bash
for file in `cat $2.mcnoruciodsplusreplica`
do
    rucio attach $1 $file
done
for file in `cat $2.mcplusruciodsnoreplica`
do
    rucio detach $1 $file
done
