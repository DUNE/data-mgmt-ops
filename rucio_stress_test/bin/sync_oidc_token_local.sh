#!/bin/bash
# Generate and sync OIDC token on all dune GPVM hosts.
#
# Usage:
#   ./bin/sync_oidc_token_local.sh [username]
#
# Example:
#   ./bin/sync_oidc_token_local.sh timm
#
# Per host actions:
#   1) htgettoken -i dune -r production -a htvaultprod.fnal.gov
#   2) copy /run/user/<uid>/bt_u<uid> -> /tmp/.rucio/duneprod.token
#   3) chmod 600 on /tmp/.rucio/duneprod.token

set -euo pipefail

USERNAME="${1:-$USER}"
TOKEN_DST="/tmp/.rucio/duneprod.token"
HOSTS=(
  dunegpvm01 dunegpvm02 dunegpvm03 dunegpvm04
  dunegpvm05 dunegpvm06 dunegpvm07 dunegpvm08
  dunegpvm09 dunegpvm10 dunegpvm11 dunegpvm12
  dunegpvm13 dunegpvm14 dunegpvm15 dunegpvm16
)

for host in "${HOSTS[@]}"; do
  echo "[$host] generating token..."

  set +e
  ht_output="$(ssh -K "${USERNAME}@${host}" "htgettoken -i dune -r production -a htvaultprod.fnal.gov 2>&1")"
  ht_rc=$?
  set -e

  printf '%s\n' "$ht_output"

  if [ $ht_rc -ne 0 ]; then
    echo "[$host] non-interactive htgettoken failed; retrying interactively..."
    if ! ssh -K -tt "${USERNAME}@${host}" "htgettoken -i dune -r production -a htvaultprod.fnal.gov"; then
      echo "[$host] interactive htgettoken also failed." >&2
      exit 1
    fi
  fi

  echo "[$host] syncing token to ${TOKEN_DST}..."
  ssh -K "${USERNAME}@${host}" "set -euo pipefail; \
    TOKEN_SRC=\"/run/user/\$(id -u)/bt_u\$(id -u)\"; \
    if [ ! -s \"\$TOKEN_SRC\" ]; then \
      echo \"Token source file not found or empty: \$TOKEN_SRC\" >&2; \
      exit 1; \
    fi; \
    mkdir -p /tmp/.rucio; \
    tr -d \"\r\n\" < \"\$TOKEN_SRC\" > \"${TOKEN_DST}\"; \
    chmod 600 \"${TOKEN_DST}\"; \
    echo \"[$host] token ready at ${TOKEN_DST}\""
done

echo "All hosts updated."
