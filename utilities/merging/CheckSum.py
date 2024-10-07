'''very simple checksum in metacat format'''
import zlib
import sys
from io import BytesIO 

def Adler32(filename):
    'calcutate a checksum in metacat format'
    with open(filename, "rb") as fh:
        buf = BytesIO(fh.read())
        data=zlib.adler32(buf.getvalue())
       # return hex(data)[2:]
        return "%08x" % data 

if __name__ == "__main__":
    print (Adler32(sys.argv[1]))
