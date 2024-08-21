import os, sys,json

# infoname = "fd_mc_2023a.json"

# f = open(infoname,'r')
# info  = json.load(f)

from CollectionCreatorClass import CollectionCreatorClass

info = {
    "fardet-vd":[
        "prodgenie_nu_dunevd10kt_1x8x6_3view_30deg.fcl",
        "prodgenie_nu_numu2nue_nue2nutau_dunevd10kt_1x8x6_3view_30deg.fcl",
        "prodgenie_nu_numu2nutau_nue2numu_dunevd10kt_1x8x6_3view_30deg.fcl",
        "prodgenie_anu_dunevd10kt_1x8x6_3view_30deg.fcl",
        "prodgenie_anu_numu2nue_nue2nutau_dunevd10kt_1x8x6_3view_30deg.fcl",
        "prodgenie_anu_numu2nutau_nue2numu_dunevd10kt_1x8x6_3view_30deg.fcl",
        "standard_g4_dunevd10kt_1x8x6_3view_30deg.fcl",
        "standard_detsim_dunevd10kt_1x8x6_3view_30deg.fcl",
        "standard_reco1_dunevd10kt_1x8x6_3view_30deg.fcl"
    ],
    "fardet-hd":[
        "prodgenie_nu_dune10kt_1x2x6.fcl",
        "prodgenie_nue_dune10kt_1x2x6.fcl",
        "prodgenie_nutau_dune10kt_1x2x6.fcl",
        "prodgenie_anu_dune10kt_1x2x6.fcl",
        "prodgenie_anue_dune10kt_1x2x6.fcl",
        "prodgenie_anutau_dune10kt_1x2x6.fcl",
        "standard_g4_dune10kt_1x2x6.fcl",
        "standard_detsim_dune10kt_1x2x6.fcl",
        "standard_reco1_dune10kt_1x2x6.fcl"
    ]
}

template = {
    "description":"tuples to merge",
    "core.run_type":"fardet-vd",
    "namespace":"fardet-vd",
    "dune.campaign":"fd_mc_2023a_reco2",
    "core.data_tier":"root-tuple-virtual",
    "dune.requestid":"ritm1780305",
    "dune_mc.gen_fcl_filename":"prodgenie_anu_dunevd10kt_1x8x6_3view_30deg.fcl",
    "deftag":"merge_v0"
}

#creator = CollectionCreatorClass()

count = 0
for detector,fcls in info.items():
    
    for fcl in fcls:
        count += 1
        #if count > 2: continue
        print (fcl)
        newname = fcl.replace(".fcl",".json")
        nf = open(newname,'w')
        md = template.copy()
        md["namespace"]=detector
        md["core.run_type"] = detector
        md["dune_mc.gen_fcl_filename"] = fcl
        json.dump(md,nf,indent=4)
        nf.close()
        creator = CollectionCreatorClass()
        creator.load(thedict=md)
        creator.run()
        


