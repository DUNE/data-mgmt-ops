#!/bin/bash
cd ~/ruciov38_3
. bin/activate
nohup sh ./justin_rucio_upload_test_bkg.sh d0001 < /dev/null  > test.out.d0001 2> test.err.d0001 &

