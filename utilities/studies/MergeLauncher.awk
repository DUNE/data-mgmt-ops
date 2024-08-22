
/No Problem/ && /root-tuple-virtual/ {print "python ../merging/submitMerge.py --run", $9 , "--version", $11, "--usetar=$TARBALL # ",$4,$6, $10}
/less/ && /root-tuple-virtual/ {print "python ../merging/submitMerge.py --run", $10, "--version", $12,"--usetar=$TARBALL # ", $4, $7, $11}