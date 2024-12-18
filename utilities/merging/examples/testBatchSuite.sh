# test suite 
# interactive
source examples/MergeTar.sh >& MergeTar.log
source examples/interactiveRun.sh >& testInteractive.log
# batch
source examples/submitLar.sh >& testCAF.log
source examples/submitRun.sh >& testRun.log
#source examples/MergeLar.sh >& testLar.logt