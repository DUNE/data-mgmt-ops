from metacat.webapi import MetaCatClient
import os
import sys
from rucio.client.replicaclient import ReplicaClient
from rucio.client.didclient import DIDClient
from rucio.common.exception import DataIdentifierNotFound, DataIdentifierAlreadyExists, FileAlreadyExists, DuplicateRule, RucioException
def matchfile(name1,name2):
  ind1=name1.index('reco2')
  ind2=name2.index('reco2')
  truncname1=name1[0:ind1+4]
  truncname2=name2[0:ind2+4]
  if truncname1==truncname2:
    return True
  else:
    return False

prefix=sys.argv[1]
thisquery=sys.argv[2]

goodf=open(prefix+"goodfiles","a")
badf=open(prefix+"badfiles","a")
metaclient = MetaCatClient(server_url="https://metacat.fnal.gov:9443/dune_meta_prod/app", auth_server_url="https://metacat.fnal.gov:8143/auth/dune")

mydataset=metaclient.query(thisquery,with_metadata=True,with_provenance=True)
for datafile in mydataset:
   print("starting next file")
   copy1=[]
   copy2=[]
   copy3=[]
#  print(datafile)
   print("did", datafile["namespace"], datafile["name"])
   did=datafile["namespace"]+':'+datafile["name"]
   print("Parents", datafile["parents"],"Children", datafile["children"])
   mychildcount=len(datafile["children"])
#   print(mychildcount)
   mymetadata=datafile["metadata"]
#   print(mymetadata) 
   if 'dune.output_status' in mymetadata:
     print (mymetadata["dune.output_status"])
   if 'core.data_tier' in mymetadata:
     print (mymetadata["core.data_tier"])
   print("scanning children")
   for fileelement in datafile["children"]:
     myfid=fileelement["fid"]
     childinfo=metaclient.get_file(fid=myfid,with_metadata=True,with_provenance=True)
#    print(childinfo)
     childname=childinfo["name"]
     childnamespace=childinfo["namespace"]
     childdid=childnamespace+':'+childname
     if len(copy1)==0:
       copy1.append(childdid)
     else:
       if matchfile(copy1[0],childdid):
         copy1.append(childdid)
       else:
         if len(copy2)==0:
           copy2.append(childdid)
         else:
           if matchfile(copy2[0],childdid):
             copy2.append(childdid)
           else:
             if len(copy3)==0:
                copy3.append(childdid)
             else:
                if matchfile(copy3[0],childdid):
                  copy3.append(childdid)
                else:  
                  print(childdid)
                  print("this did doesn't match either list")
   
#     print(copy1)
#     print(copy2)
#     print(copy3)
     childchildren=childinfo["children"]
     print("Child",childnamespace,childname)
#     print(len(childchildren))
     childmetadata=childinfo["metadata"]
     if 'dune.output_status' in childmetadata:
         childoutputstatus=childmetadata["dune.output_status"]
         print(childoutputstatus)
     datatier=childmetadata["core.data_tier"]
     if datatier=="full-reconstructed" and len(childchildren)>0:
        for record in childchildren:
#            print("in record/childchildren loop")
#            print(record)
            grandchildfid=record["fid"]  
            grandchildinfo=metaclient.get_file(fid=grandchildfid,with_metadata=True,with_provenance=True)
#            print("printing grandchild info")
#            print(grandchildinfo)
            grandchildname=grandchildinfo["name"]
            grandchildnamespace=grandchildinfo["namespace"]
            grandchilddid=grandchildnamespace+':'+grandchildname
            grandchildmetadata=grandchildinfo["metadata"]
            if len(copy1)==0:
              copy1.append(grandchilddid)
            else:
              if matchfile(copy1[0],grandchilddid):
                copy1.append(grandchilddid)
              else:
                if len(copy2)==0:
                  copy2.append(grandchilddid)
                else:
                  if matchfile(copy2[0],grandchilddid):
                    copy2.append(grandchilddid)
                  else:
                    if len(copy3)==0:
                       copy3.append(grandchilddid)
                    else: 
                       if matchfile(copy3[0],grandchilddid):
                         copy3.append(grandchilddid)
                       else:
                         print(grandchilddid)
                         print("this did doesn't match either list")
            #print(copy1)
            #print(copy2)
            #print(copy3)
            if 'dune.output_status' in grandchildmetadata:
               grandchildoutputstatus=grandchildmetadata["dune.output_status"]
               print("Grandchild", grandchildname, grandchildnamespace, grandchildoutputstatus)

#  Done with the children loop on the file
   print("done with file",did)
   copylen1=len(copy1)
   print("copy1",copylen1,copy1)
   copylen2=len(copy2)
   print("copy2",copylen2,copy2)
   copylen3=len(copy3)
   print("copy3",copylen3,copy3)
   if copylen1==4 and copylen2==0 and copylen3==0:
      print(did)
      print("file is good")
      for file in copy1:
          goodf.write(str(file)+"\n")
   else:
      print(did)
      print("file is bad, need to nuke all")
      if len(copy1)>0:
        for file in copy1:
           badf.write(str(file)+"\n")
      if len(copy2)>0:
        for file in copy2:
           badf.write(str(file)+"\n")
      if len(copy3)>0:
        for file in copy3:
           badf.write(str(file)+"\n")
# End of the main dataset loop
goodf.close()
badf.close()
