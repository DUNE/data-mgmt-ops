#!/bin/bash 
#rm -Rf /tmp/timm/.rucio_timm
#klist -a
#kx509
export X509_USER_PROXY=/tmp/x509up_u2904
export RUCIO_ACCOUNT=dunepro
mydate=`date +%Y%m%d`
if [ $# -eq 1 ]
then
   suffix=".${1}"
else
   suffix=""
fi

#dd if=/dev/zero of=/tmp/1gbtestfile.${mydate}${suffix} bs=1024 count=1000000
ln -s /tmp/1gbtestfile.${mydate} /tmp/1gbtestfile.${mydate}${suffix}
export PATH="/usr/local/sbin:/usr/local/bin:${PATH}"
#export PYTHONPATH="/usr/local/lib/python3.6/site-packages:${PATH}"
#export METACAT_AUTH_SERVER_URL=https://metacat.fnal.gov:8143/auth/dune
#export METACAT_SERVER_URL=https://metacat.fnal.gov:9443/dune_meta_prod/app
#metacat auth login -m x509 -c /tmp/x509up_u2904 dunepro
#echo "sed -e 's/MYDATE/$mydate/' < test.json.template > /tmp/test${suffix}.json" > testsed${suffix}.sh
#sh testsed${suffix}.sh
#sed -e 's/MYDATE/"${mydate}"/' < /usr/local/bin/test.json.template > /tmp/test.json
#metacat file declare test:1gbtestfile.${mydate}${suffix} dune:all -s 1024000000 -c 'adler32:93b40001' -m /tmp/test${suffix}.json
rucio -v --account dunepro upload --rse FNAL_DCACHE_PERSISTENT --lifetime 172000 --scope test --register-after-upload --protocol davs  /tmp/1gbtestfile.${mydate}${suffix}
#rucio -v --account dunepro upload --rse DUNE_US_FNAL_DISK_STAGE --lifetime 172000 --scope test --register-after-upload --protocol davs  /tmp/1gbtestfile.${mydate}${suffix}
myrc=$?
if [ $myrc -ne 0 ] 
then 
	echo "rucio upload not successful, exiting.  You may have to remove test file manually from pnfs"
        exit $myrc
fi
