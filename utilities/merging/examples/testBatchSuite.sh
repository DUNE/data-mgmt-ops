# test suite for batch
source examples/TarSmall.sh >& testTar.log
source examples/interactiveRun.sh >& testInteractive.log
source examples/makeCAF.sh >& testCAF.log
source examples/submitRun.sh >& testRun.log
#source examples/MergeLar.sh >& testLar.log