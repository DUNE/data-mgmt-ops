''' file to contain inputs to FileChecker'''

def known_fields():
    return {
        "core.run_type":[
            "fardet",
            "neardet",
            "protodune",
            "protodune-sp",
            "protodune-dp",
            "35ton",
            "311",
            "311_dp_light"
            "iceberg",
            "fardet-sp",
            "fardet-dp",
            "fardet-moo",
            "np04_vst",
            "vd-coldbox-bottom",
            "vd-coldbox-top",
            "protodune-hd",
            "hd-coldbox",
            "vd-protodune-arapucas",
            "protodune-vst",
            "vd-protodune-pds",
            "fardet-hd",
            "fardet-vd",
            "dc4-vd-coldbox-bottom",
            "dc4-vd-coldbox-top",
            "dc4-hd-protodune",
            "hd-protodune",
            "neardet-lar",
            "neardet-2x2-minerva",
            "neardet-2x2-lar-charge",
            "neardet-2x2-lar-light",
            "neardet-2x2",
            "neardet-2x2-lar",
            "vd-protodune",
            "vd-coldbox"
        ],
        "core.file_type":[
            "detector",
            "mc",
            "importedDetector"  # minerva
        ],
        "core.data_tier":[
            "simulated",
            "raw",
            "hit-reconstructed",
            "full-reconstructed",
            "generated",
            "detector-simulated",
            "reconstructed-2d",
            "reconstructed-3d",
            "sliced",
            "dc1input",
            "dc1output",
            "root-tuple",
            "root-hist",
            "dqm",
            "decoded-raw",
            "sam-user",
            "pandora_info",
            "reco-recalibrated",
            "storage-testing",
            "root-tuple-virtual",
            "binary-raw",
            "trigprim",
            "pandora-info"
        ],
        "core.data_stream":[
            "out1",
            "noise",
            "test",
            "cosmics",
            "calibration",
            "physics",
            "commissioning",
            "out2",
            "pedestal",
            "study",
            "trigprim",
            "pdstl",
            "linjc",
            "numib",
            "numip",
            "numil"
]
    

                    

    }