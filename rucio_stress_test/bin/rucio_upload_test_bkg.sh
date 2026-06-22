#!/bin/bash 
#rm -Rf /tmp/timm/.rucio_timm
#klist -a
#kx509
export RUCIO_ACCOUNT=dunepro
mydate=`date +%Y%m%d`
file_base="${2:-1gbtestfile}"
suffix="${1:+.${1}}"

if [ ! -s "/tmp/${file_base}.${mydate}" ]; then
        echo "Base test file missing: /tmp/${file_base}.${mydate}" >&2
        echo "Create it in launch script before starting background uploads." >&2
        exit 1
fi
ln -s /tmp/${file_base}.${mydate} /tmp/${file_base}.${mydate}${suffix}
export PATH="/usr/local/sbin:/usr/local/bin:${PATH}"
#export PYTHONPATH="/usr/local/lib/python3.6/site-packages:${PATH}"
#export METACAT_AUTH_SERVER_URL=https://metacat.fnal.gov:8143/auth/dune
#export METACAT_SERVER_URL=https://metacat.fnal.gov:9443/dune_meta_prod/app
#metacat auth login -m x509 -c /tmp/x509up_u2904 dunepro
#echo "sed -e 's/MYDATE/$mydate/' < test.json.template > /tmp/test${suffix}.json" > testsed${suffix}.sh
#sh testsed${suffix}.sh
#sed -e 's/MYDATE/"${mydate}"/' < /usr/local/bin/test.json.template > /tmp/test.json
#metacat file declare test:1gbtestfile.${mydate}${suffix} dune:all -s 1024000000 -c 'adler32:93b40001' -m /tmp/test${suffix}.json
rucio -v --account dunepro upload --rse FNAL_DCACHE_PERSISTENT --lifetime 172000 --scope test --register-after-upload --protocol davs  /tmp/${file_base}.${mydate}${suffix}
#rucio -v --account dunepro upload --rse DUNE_US_FNAL_DISK_STAGE --lifetime 172000 --scope test --register-after-upload --protocol davs  /tmp/1gbtestfile.${mydate}${suffix}
myrc=$?
if [ $myrc -ne 0 ] 
then 
	echo "rucio upload not successful, exiting.  You may have to remove test file manually from pnfs"
        exit $myrc
fi
