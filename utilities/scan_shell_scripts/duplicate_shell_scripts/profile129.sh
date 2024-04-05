#!/bin/bash
cd ~/rucio129_python3
. bin/activate
cd ../mcruciosam
. /grid/fermiapp/products/common/etc/setups
setup sam_web_client
export SAM_EXPERIMENT=dune
export METACAT_SERVER_URL=https://metacat.fnal.gov:9443/dune_meta_prod/app
export METACAT_AUTH_SERVER_URL=https://metacat.fnal.gov:8143/auth/dune

