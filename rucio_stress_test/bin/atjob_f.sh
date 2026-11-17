#!/bin/bash
# Usage:
#   ./bin/atjob_f.sh [username] [at_time] [file_base]
# Examples:
#   ./bin/atjob_f.sh timm 15:11
#   ./bin/atjob_f.sh timm "now + 5 minutes"
#   ./bin/atjob_f.sh timm "now + 2 minutes" runA
#   ./bin/atjob_f.sh timm          # defaults to "now" and "1gbtestfile"
#   ./bin/atjob_f.sh               # defaults to current user, "now" and "1gbtestfile"
#
# Token prerequisite (run once before scheduling launches):
#   htgettoken -i dune -r production -a htvaultprod.fnal.gov
#   ./bin/sync_oidc_token_local.sh
#
# The launch scripts expect the shared token at:
#   /tmp/.rucio/duneprod.token
# Optional test file base name (arg 3):
#   file_base (default: 1gbtestfile)
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
USERNAME="${1:-$USER}"
AT_TIME="${2:-now}"
FILE_BASE="${3:-1gbtestfile}"

echo "Scheduling as user: ${USERNAME}"
echo "Schedule time: ${AT_TIME}"
echo "Test file base: ${FILE_BASE}"

schedule_host() {
  local host="$1"
  local launch_script="$2"
  echo " -> ${host}: ${launch_script}"
  ssh "${USERNAME}@${host}" "printf '%s\n' 'bash ${SCRIPT_DIR}/${launch_script} ${FILE_BASE}' | at '${AT_TIME}'"
}

schedule_host dunegpvm01 launch0100_f.sh
schedule_host dunegpvm02 launch0200_f.sh
schedule_host dunegpvm03 launch0300_f.sh
schedule_host dunegpvm04 launch0400_f.sh
schedule_host dunegpvm05 launch0500_f.sh
schedule_host dunegpvm06 launch0600_f.sh
schedule_host dunegpvm07 launch0700_f.sh
schedule_host dunegpvm08 launch0800_f.sh
schedule_host dunegpvm09 launch0900_f.sh
schedule_host dunegpvm10 launch1000_f.sh
schedule_host dunegpvm11 launch1100_f.sh
schedule_host dunegpvm12 launch1200_f.sh
schedule_host dunegpvm13 launch1300_f.sh
schedule_host dunegpvm14 launch1400_f.sh
schedule_host dunegpvm15 launch1500_f.sh
schedule_host dunegpvm16 launch1600_f.sh
