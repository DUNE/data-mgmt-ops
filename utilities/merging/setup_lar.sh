export DWORK=dunegpvm11.fnal.gov:/exp/dune/data/users/schellma/data-mgmt-ops/utilities
export DDTEST=dunegpvm11.fnal.gov:/pnfs/dune/scratch/users/$USER/ddtest
export HERE=$PWD
export PATH=${HOME}/.local/bin:$PATH

export PYTHONPATH=$HERE:$HERE/..:${PYTHONPATH}

export DUNESW_VERSION=${MERGE_VERSION}
export DUNESW_QUALIFIER=e26:prof
export RUCIO_ACCOUNT=${USER}
export UPS_OVERRIDE="-H Linux64bit+3.10-2.17"

source /cvmfs/dune.opensciencegrid.org/products/dune/setup_dune.sh
#setup fife_utils
setup -B dunesw ${DUNESW_VERSION} -q ${DUNESW_QUALIFIER}
setup metacat
setup rucio
#setup python v3_9_15 -f Linux64bit+3.10-2.17 -z /cvmfs/larsoft.opensciencegrid.org/products
which python
which lar
which ifdh
export DATA_DISPATCHER_URL=https://metacat.fnal.gov:9443/dune/dd/data
export DATA_DISPATCHER_AUTH_URL=https://metacat.fnal.gov:8143/auth/dune
export METACAT_SERVER_URL=https://metacat.fnal.gov:9443/dune_meta_prod/app
export METACAT_AUTH_SERVER_URL=https://metacat.fnal.gov:8143/auth/dune
 
