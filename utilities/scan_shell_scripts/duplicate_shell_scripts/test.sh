#!/bin/bash
myworkflow=1583
metacat query 'files from dune:all where core.data_tier in ("pandora-info","pandora_info") and core.file_format="binary" and dune.workflow["workflow_id"]'=${myworkflow}
