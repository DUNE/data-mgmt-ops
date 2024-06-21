'''very simple checksum in metacat format'''
import zlib
from io import BytesIO 

def Adler32(filename):
    'calcutate a checksum in metacat format'
    with open(filename, "rb") as fh:
        buf = BytesIO(fh.read())
        data=zlib.adler32(buf.getvalue())
        return hex(data)[2:]
