# local setup
export DWORK=dunegpvm11.fnal.gov:/exp/dune/data/users/$USER/data-mgmt-ops/utilities
export DSCRATCH=/pnfs/dune/scratch/users/$USER
export MERGING=${DSCRATCH}/merging
export HERE=$PWD
export PATH=${HOME}/.local/bin:$PATH

export PYTHONPATH=$HERE:$HERE/..:${PYTHONPATH}

export DATA_DISPATCHER_URL=https://metacat.fnal.gov:9443/dune/dd/data
export DATA_DISPATCHER_AUTH_URL=https://metacat.fnal.gov:8143/auth/dune
export METACAT_SERVER_URL=https://metacat.fnal.gov:9443/dune_meta_prod/app
export METACAT_AUTH_SERVER_URL=https://metacat.fnal.gov:8143/auth/dune
 
