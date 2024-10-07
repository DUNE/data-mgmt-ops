#export DWORK=dunegpvm11.fnal.gov:/exp/dune/data/users/schellma/data-mgmt-ops/utilities
#export DDTEST=dunegpvm11.fnal.gov:/pnfs/dune/scratch/users/$USER/ddtest
export HERE=$PWD
export PATH=${HOME}/.local/bin:$PATH

export PYTHONPATH=$HERE:$HERE/..:${PYTHONPATH}

source /cvmfs/larsoft.opensciencegrid.org/spack-packages/setup-env.sh
# gives you access to root and cmake 

# get the packages you need to run this
echo "root"
spack load root@6.28.12
echo "cmake"
spack load cmake@3.27.7
echo "gcc"
spack load gcc@12.2.0%gcc@11.4.1
spack load fife-utils@3.7.0
spack load metacat@4.0.0
spack load rucio-clients@33.3.0
spack load sam-web-client@3.4%gcc@12.2.0 
spack load r-m-dd-config@1.0 experiment=dune

export DATA_DISPATCHER_URL=https://metacat.fnal.gov:9443/dune/dd/data
export DATA_DISPATCHER_AUTH_URL=https://metacat.fnal.gov:8143/auth/dune
export METACAT_SERVER_URL=https://metacat.fnal.gov:9443/dune_meta_prod/app
export METACAT_AUTH_SERVER_URL=https://metacat.fnal.gov:8143/auth/dune
 
