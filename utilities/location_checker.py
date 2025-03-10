import os,sys

def is_file_online_pnfs(f):
    path, filename = os.path.split(f)
    stat_file="%s/.(get)(%s)(locality)"%(path,filename)
    theStatFile=open(stat_file)
    state=theStatFile.readline()
    theStatFile.close()
    return 'ONLINE' in state, state

testfile = "root://fndca1.fnal.gov:1094/pnfs/fnal.gov/usr/dune/tape_backed/dunepro//protodune/np04/beam/detector/None/raw/06/60/67/48/np04_raw_run005141_0011_dl8.root"


if len(sys.argv) > 1:
    testfile = sys.argv[1]

newpath = testfile.replace("root://fndca1.fnal.gov:1094/pnfs/fnal.gov/usr","/pnfs")
print ("status =", is_file_online_pnfs(newpath))