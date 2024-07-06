''' read a digest of run information and produce summary'''
import os, sys, json, csv

input = sys.argv[1]

f = open(input,'r')

data = json.load(f)

summary = []
fieldnames = ["run","data_stream"]
for run in data:
    record = {}
    record["run"]=run
    thestream = None
    for stream in data[run]:
        #print (run, stream, data[run][stream])
        if "raw" in data[run][stream]:
            thestream = stream
            record["data_stream"]=thestream
            #print (run, thestream, data[run][thestream])
            for tier in data[run][thestream]:
                #print (run, thestream, tier, data[run][thestream][tier])
                for field in data[run][thestream][tier]:
                    name = "%s:%s"%(tier,field)
                    value = data[run][thestream][tier][field]
                    record[name]=value
                    if name not in fieldnames:
                        fieldnames.append(name)
                    #print (name,value)
            
            summary.append(record)
            print(run,record)
                    
newfile = input.replace("json","csv")
with open(newfile, 'w', newline='') as csvfile:
    
    writer = csv.DictWriter(csvfile, fieldnames=fieldnames)

    writer.writeheader()
    for run in summary:
        writer.writerow(run)
    

     