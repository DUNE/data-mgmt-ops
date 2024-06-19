import os
import zlib
from io import BytesIO 

testfile = "/Users/schellma/scratch/hists/np04hd_raw_run026418_0000_dataflow0_datawriter_0_20240524T164025_20240604T212142_keepup_hists.root"

def Adler32(filename):
    with open(testfile, "rb") as fh:
        buf = BytesIO(fh.read())
        data=zlib.adler32(buf.getvalue())
        return hex(data)[2:]
