#!/bin/bash
# Cleanup stress-test files from /tmp on all dune GPVM hosts.
#
# Usage:
#   ./bin/cleanup_tmp_test_files.sh <file_base> [yyyymmdd]
#
# Examples:
#   ./bin/cleanup_tmp_test_files.sh runC 20260319
#   ./bin/cleanup_tmp_test_files.sh runC
#
# Removes on each host:
#   /tmp/<file_base>.<yyyymmdd>.*
#   /tmp/<file_base>.<yyyymmdd>

set -euo pipefail

if [ $# -lt 1 ] || [ $# -gt 2 ]; then
  echo "Usage: $0 <file_base> [yyyymmdd]" >&2
  exit 1
fi

FILE_BASE="$1"
DATE_TAG="${2:-$(date +%Y%m%d)}"
PATTERN="/tmp/${FILE_BASE}.${DATE_TAG}.*"
BASE_FILE="/tmp/${FILE_BASE}.${DATE_TAG}"

HOSTS=(
  dunegpvm01 dunegpvm02 dunegpvm03 dunegpvm04
  dunegpvm05 dunegpvm06 dunegpvm07 dunegpvm08
  dunegpvm09 dunegpvm10 dunegpvm11 dunegpvm12
  dunegpvm13 dunegpvm14 dunegpvm15 dunegpvm16
)

echo "Cleaning file base '${FILE_BASE}' for date '${DATE_TAG}'"

for host in "${HOSTS[@]}"; do
  echo "[$host] removing ${PATTERN} and ${BASE_FILE}"
  ssh "${USER}@${host}" "set -euo pipefail; rm -f ${PATTERN} ${BASE_FILE}; ls -l ${PATTERN} ${BASE_FILE} 2>/dev/null || true"
done

echo "Cleanup finished on all hosts."
