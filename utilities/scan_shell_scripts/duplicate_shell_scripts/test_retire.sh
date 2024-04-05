#!/bin/bash
cd ~/mcruciosam
. ./profile.sh 
dd if=/dev/zero of=/tmp/1mbtestfile.st2024mar6 bs=1024 count=1000
xrdadler32 /tmp/1mbtestfile.st2024mar6
metacat dataset create test:steve_test_retire_mar6
metacat file declare test:1mbtestfile.st2024mar6 test:steve_test_retire_mar6 -s 1024000 -c adler32:a0e10001
metacat file declare test:1mbtestfile.st2024mar6.child test:steve_test_retire_mar6 -s 1024000 -c adler32:a0e10001 --parents test:1mbtestfile.st2024mar6
metacat file declare test:1mbtestfile.st2024mar6.child2 test:steve_test_retire_mar6 -s 1024000 -c adler32:a0e10001 --parents test:1mbtestfile.st2024mar6
metacat dataset files test:steve_test_retire_mar6
metacat file show test:1mbtestfile.st2024mar6 -l  
metacat file show test:1mbtestfile.st2024mar6.child -l 
metacat file show test:1mbtestfile.st2024mar6.child2 -l 
metacat query children '(files from test:steve_test_retire_mar6)'
metacat query parents ' (files from test:steve_test_retire_mar6)'
# now retire test:1mbtestfile.st2024mar6.child
# using st_retire_metacat.py because my cli still has the metacat file retire bug
python3 st_retire_metacat.py  test:1mbtestfile.st2024mar6.child
metacat dataset files test:steve_test_retire_mar6
metacat file show test:1mbtestfile.st2024mar6 -l
metacat file show test:1mbtestfile.st2024mar6.child -l
metacat file show test:1mbtestfile.st2024mar6.child2 -l
metacat query children '(files from test:steve_test_retire_mar6)'
metacat query parents ' (files from test:steve_test_retire_mar6)'

