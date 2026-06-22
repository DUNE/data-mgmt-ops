#!/bin/bash
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
OUTPUT_DIR="$REPO_DIR/output"
TOKEN_DST="/tmp/.rucio/duneprod.token"
FILE_BASE="${1:-1gbtestfile}"
MYDATE="$(date +%Y%m%d)"
BASE_FILE="/tmp/${FILE_BASE}.${MYDATE}"

# Use the shared rucio client virtualenv.
. ~/ruciov38_3/bin/activate
export RUCIO_CONFIG="$REPO_DIR/etc/rucio.cfg.oidc.int"

if [ ! -s "$TOKEN_DST" ]; then
  echo "Shared token not found at $TOKEN_DST" >&2
  echo "Run $SCRIPT_DIR/sync_oidc_token_local.sh once after htgettoken" >&2
  exit 1
fi

# Create the base test file once per launcher run.
if [ ! -s "$BASE_FILE" ]; then
  dd if=/dev/zero of="$BASE_FILE" bs=1024 count=1000000
fi

mkdir -p "$OUTPUT_DIR"
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0500 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0500" 2> "$OUTPUT_DIR/test.err.f0500" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0501 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0501" 2> "$OUTPUT_DIR/test.err.f0501" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0502 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0502" 2> "$OUTPUT_DIR/test.err.f0502" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0503 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0503" 2> "$OUTPUT_DIR/test.err.f0503" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0504 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0504" 2> "$OUTPUT_DIR/test.err.f0504" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0505 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0505" 2> "$OUTPUT_DIR/test.err.f0505" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0506 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0506" 2> "$OUTPUT_DIR/test.err.f0506" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0507 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0507" 2> "$OUTPUT_DIR/test.err.f0507" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0508 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0508" 2> "$OUTPUT_DIR/test.err.f0508" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0509 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0509" 2> "$OUTPUT_DIR/test.err.f0509" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0510 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0510" 2> "$OUTPUT_DIR/test.err.f0510" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0511 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0511" 2> "$OUTPUT_DIR/test.err.f0511" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0512 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0512" 2> "$OUTPUT_DIR/test.err.f0512" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0513 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0513" 2> "$OUTPUT_DIR/test.err.f0513" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0514 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0514" 2> "$OUTPUT_DIR/test.err.f0514" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0515 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0515" 2> "$OUTPUT_DIR/test.err.f0515" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0516 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0516" 2> "$OUTPUT_DIR/test.err.f0516" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0517 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0517" 2> "$OUTPUT_DIR/test.err.f0517" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0518 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0518" 2> "$OUTPUT_DIR/test.err.f0518" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0519 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0519" 2> "$OUTPUT_DIR/test.err.f0519" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0520 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0520" 2> "$OUTPUT_DIR/test.err.f0520" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0521 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0521" 2> "$OUTPUT_DIR/test.err.f0521" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0522 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0522" 2> "$OUTPUT_DIR/test.err.f0522" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0523 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0523" 2> "$OUTPUT_DIR/test.err.f0523" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0524 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0524" 2> "$OUTPUT_DIR/test.err.f0524" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0525 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0525" 2> "$OUTPUT_DIR/test.err.f0525" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0526 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0526" 2> "$OUTPUT_DIR/test.err.f0526" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0527 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0527" 2> "$OUTPUT_DIR/test.err.f0527" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0528 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0528" 2> "$OUTPUT_DIR/test.err.f0528" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0529 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0529" 2> "$OUTPUT_DIR/test.err.f0529" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0530 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0530" 2> "$OUTPUT_DIR/test.err.f0530" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0531 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0531" 2> "$OUTPUT_DIR/test.err.f0531" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0532 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0532" 2> "$OUTPUT_DIR/test.err.f0532" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0533 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0533" 2> "$OUTPUT_DIR/test.err.f0533" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0534 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0534" 2> "$OUTPUT_DIR/test.err.f0534" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0535 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0535" 2> "$OUTPUT_DIR/test.err.f0535" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0536 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0536" 2> "$OUTPUT_DIR/test.err.f0536" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0537 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0537" 2> "$OUTPUT_DIR/test.err.f0537" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0538 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0538" 2> "$OUTPUT_DIR/test.err.f0538" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0539 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0539" 2> "$OUTPUT_DIR/test.err.f0539" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0540 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0540" 2> "$OUTPUT_DIR/test.err.f0540" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0541 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0541" 2> "$OUTPUT_DIR/test.err.f0541" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0542 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0542" 2> "$OUTPUT_DIR/test.err.f0542" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0543 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0543" 2> "$OUTPUT_DIR/test.err.f0543" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0544 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0544" 2> "$OUTPUT_DIR/test.err.f0544" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0545 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0545" 2> "$OUTPUT_DIR/test.err.f0545" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0546 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0546" 2> "$OUTPUT_DIR/test.err.f0546" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0547 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0547" 2> "$OUTPUT_DIR/test.err.f0547" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0548 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0548" 2> "$OUTPUT_DIR/test.err.f0548" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0549 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0549" 2> "$OUTPUT_DIR/test.err.f0549" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0550 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0550" 2> "$OUTPUT_DIR/test.err.f0550" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0551 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0551" 2> "$OUTPUT_DIR/test.err.f0551" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0552 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0552" 2> "$OUTPUT_DIR/test.err.f0552" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0553 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0553" 2> "$OUTPUT_DIR/test.err.f0553" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0554 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0554" 2> "$OUTPUT_DIR/test.err.f0554" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0555 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0555" 2> "$OUTPUT_DIR/test.err.f0555" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0556 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0556" 2> "$OUTPUT_DIR/test.err.f0556" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0557 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0557" 2> "$OUTPUT_DIR/test.err.f0557" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0558 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0558" 2> "$OUTPUT_DIR/test.err.f0558" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0559 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0559" 2> "$OUTPUT_DIR/test.err.f0559" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0560 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0560" 2> "$OUTPUT_DIR/test.err.f0560" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0561 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0561" 2> "$OUTPUT_DIR/test.err.f0561" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0562 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0562" 2> "$OUTPUT_DIR/test.err.f0562" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0563 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0563" 2> "$OUTPUT_DIR/test.err.f0563" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0564 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0564" 2> "$OUTPUT_DIR/test.err.f0564" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0565 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0565" 2> "$OUTPUT_DIR/test.err.f0565" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0566 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0566" 2> "$OUTPUT_DIR/test.err.f0566" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0567 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0567" 2> "$OUTPUT_DIR/test.err.f0567" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0568 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0568" 2> "$OUTPUT_DIR/test.err.f0568" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0569 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0569" 2> "$OUTPUT_DIR/test.err.f0569" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0570 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0570" 2> "$OUTPUT_DIR/test.err.f0570" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0571 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0571" 2> "$OUTPUT_DIR/test.err.f0571" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0572 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0572" 2> "$OUTPUT_DIR/test.err.f0572" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0573 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0573" 2> "$OUTPUT_DIR/test.err.f0573" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0574 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0574" 2> "$OUTPUT_DIR/test.err.f0574" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0575 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0575" 2> "$OUTPUT_DIR/test.err.f0575" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0576 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0576" 2> "$OUTPUT_DIR/test.err.f0576" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0577 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0577" 2> "$OUTPUT_DIR/test.err.f0577" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0578 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0578" 2> "$OUTPUT_DIR/test.err.f0578" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0579 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0579" 2> "$OUTPUT_DIR/test.err.f0579" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0580 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0580" 2> "$OUTPUT_DIR/test.err.f0580" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0581 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0581" 2> "$OUTPUT_DIR/test.err.f0581" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0582 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0582" 2> "$OUTPUT_DIR/test.err.f0582" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0583 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0583" 2> "$OUTPUT_DIR/test.err.f0583" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0584 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0584" 2> "$OUTPUT_DIR/test.err.f0584" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0585 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0585" 2> "$OUTPUT_DIR/test.err.f0585" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0586 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0586" 2> "$OUTPUT_DIR/test.err.f0586" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0587 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0587" 2> "$OUTPUT_DIR/test.err.f0587" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0588 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0588" 2> "$OUTPUT_DIR/test.err.f0588" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0589 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0589" 2> "$OUTPUT_DIR/test.err.f0589" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0590 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0590" 2> "$OUTPUT_DIR/test.err.f0590" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0591 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0591" 2> "$OUTPUT_DIR/test.err.f0591" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0592 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0592" 2> "$OUTPUT_DIR/test.err.f0592" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0593 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0593" 2> "$OUTPUT_DIR/test.err.f0593" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0594 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0594" 2> "$OUTPUT_DIR/test.err.f0594" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0595 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0595" 2> "$OUTPUT_DIR/test.err.f0595" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0596 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0596" 2> "$OUTPUT_DIR/test.err.f0596" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0597 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0597" 2> "$OUTPUT_DIR/test.err.f0597" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0598 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0598" 2> "$OUTPUT_DIR/test.err.f0598" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0599 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0599" 2> "$OUTPUT_DIR/test.err.f0599" &
sleep 1800
