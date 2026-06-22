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
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0600 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0600" 2> "$OUTPUT_DIR/test.err.f0600" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0601 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0601" 2> "$OUTPUT_DIR/test.err.f0601" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0602 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0602" 2> "$OUTPUT_DIR/test.err.f0602" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0603 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0603" 2> "$OUTPUT_DIR/test.err.f0603" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0604 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0604" 2> "$OUTPUT_DIR/test.err.f0604" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0605 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0605" 2> "$OUTPUT_DIR/test.err.f0605" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0606 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0606" 2> "$OUTPUT_DIR/test.err.f0606" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0607 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0607" 2> "$OUTPUT_DIR/test.err.f0607" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0608 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0608" 2> "$OUTPUT_DIR/test.err.f0608" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0609 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0609" 2> "$OUTPUT_DIR/test.err.f0609" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0610 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0610" 2> "$OUTPUT_DIR/test.err.f0610" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0611 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0611" 2> "$OUTPUT_DIR/test.err.f0611" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0612 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0612" 2> "$OUTPUT_DIR/test.err.f0612" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0613 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0613" 2> "$OUTPUT_DIR/test.err.f0613" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0614 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0614" 2> "$OUTPUT_DIR/test.err.f0614" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0615 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0615" 2> "$OUTPUT_DIR/test.err.f0615" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0616 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0616" 2> "$OUTPUT_DIR/test.err.f0616" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0617 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0617" 2> "$OUTPUT_DIR/test.err.f0617" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0618 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0618" 2> "$OUTPUT_DIR/test.err.f0618" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0619 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0619" 2> "$OUTPUT_DIR/test.err.f0619" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0620 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0620" 2> "$OUTPUT_DIR/test.err.f0620" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0621 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0621" 2> "$OUTPUT_DIR/test.err.f0621" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0622 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0622" 2> "$OUTPUT_DIR/test.err.f0622" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0623 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0623" 2> "$OUTPUT_DIR/test.err.f0623" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0624 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0624" 2> "$OUTPUT_DIR/test.err.f0624" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0625 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0625" 2> "$OUTPUT_DIR/test.err.f0625" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0626 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0626" 2> "$OUTPUT_DIR/test.err.f0626" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0627 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0627" 2> "$OUTPUT_DIR/test.err.f0627" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0628 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0628" 2> "$OUTPUT_DIR/test.err.f0628" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0629 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0629" 2> "$OUTPUT_DIR/test.err.f0629" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0630 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0630" 2> "$OUTPUT_DIR/test.err.f0630" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0631 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0631" 2> "$OUTPUT_DIR/test.err.f0631" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0632 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0632" 2> "$OUTPUT_DIR/test.err.f0632" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0633 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0633" 2> "$OUTPUT_DIR/test.err.f0633" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0634 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0634" 2> "$OUTPUT_DIR/test.err.f0634" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0635 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0635" 2> "$OUTPUT_DIR/test.err.f0635" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0636 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0636" 2> "$OUTPUT_DIR/test.err.f0636" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0637 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0637" 2> "$OUTPUT_DIR/test.err.f0637" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0638 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0638" 2> "$OUTPUT_DIR/test.err.f0638" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0639 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0639" 2> "$OUTPUT_DIR/test.err.f0639" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0640 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0640" 2> "$OUTPUT_DIR/test.err.f0640" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0641 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0641" 2> "$OUTPUT_DIR/test.err.f0641" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0642 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0642" 2> "$OUTPUT_DIR/test.err.f0642" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0643 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0643" 2> "$OUTPUT_DIR/test.err.f0643" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0644 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0644" 2> "$OUTPUT_DIR/test.err.f0644" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0645 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0645" 2> "$OUTPUT_DIR/test.err.f0645" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0646 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0646" 2> "$OUTPUT_DIR/test.err.f0646" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0647 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0647" 2> "$OUTPUT_DIR/test.err.f0647" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0648 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0648" 2> "$OUTPUT_DIR/test.err.f0648" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0649 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0649" 2> "$OUTPUT_DIR/test.err.f0649" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0650 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0650" 2> "$OUTPUT_DIR/test.err.f0650" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0651 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0651" 2> "$OUTPUT_DIR/test.err.f0651" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0652 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0652" 2> "$OUTPUT_DIR/test.err.f0652" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0653 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0653" 2> "$OUTPUT_DIR/test.err.f0653" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0654 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0654" 2> "$OUTPUT_DIR/test.err.f0654" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0655 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0655" 2> "$OUTPUT_DIR/test.err.f0655" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0656 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0656" 2> "$OUTPUT_DIR/test.err.f0656" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0657 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0657" 2> "$OUTPUT_DIR/test.err.f0657" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0658 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0658" 2> "$OUTPUT_DIR/test.err.f0658" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0659 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0659" 2> "$OUTPUT_DIR/test.err.f0659" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0660 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0660" 2> "$OUTPUT_DIR/test.err.f0660" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0661 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0661" 2> "$OUTPUT_DIR/test.err.f0661" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0662 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0662" 2> "$OUTPUT_DIR/test.err.f0662" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0663 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0663" 2> "$OUTPUT_DIR/test.err.f0663" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0664 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0664" 2> "$OUTPUT_DIR/test.err.f0664" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0665 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0665" 2> "$OUTPUT_DIR/test.err.f0665" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0666 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0666" 2> "$OUTPUT_DIR/test.err.f0666" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0667 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0667" 2> "$OUTPUT_DIR/test.err.f0667" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0668 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0668" 2> "$OUTPUT_DIR/test.err.f0668" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0669 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0669" 2> "$OUTPUT_DIR/test.err.f0669" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0670 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0670" 2> "$OUTPUT_DIR/test.err.f0670" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0671 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0671" 2> "$OUTPUT_DIR/test.err.f0671" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0672 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0672" 2> "$OUTPUT_DIR/test.err.f0672" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0673 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0673" 2> "$OUTPUT_DIR/test.err.f0673" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0674 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0674" 2> "$OUTPUT_DIR/test.err.f0674" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0675 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0675" 2> "$OUTPUT_DIR/test.err.f0675" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0676 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0676" 2> "$OUTPUT_DIR/test.err.f0676" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0677 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0677" 2> "$OUTPUT_DIR/test.err.f0677" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0678 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0678" 2> "$OUTPUT_DIR/test.err.f0678" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0679 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0679" 2> "$OUTPUT_DIR/test.err.f0679" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0680 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0680" 2> "$OUTPUT_DIR/test.err.f0680" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0681 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0681" 2> "$OUTPUT_DIR/test.err.f0681" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0682 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0682" 2> "$OUTPUT_DIR/test.err.f0682" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0683 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0683" 2> "$OUTPUT_DIR/test.err.f0683" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0684 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0684" 2> "$OUTPUT_DIR/test.err.f0684" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0685 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0685" 2> "$OUTPUT_DIR/test.err.f0685" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0686 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0686" 2> "$OUTPUT_DIR/test.err.f0686" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0687 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0687" 2> "$OUTPUT_DIR/test.err.f0687" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0688 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0688" 2> "$OUTPUT_DIR/test.err.f0688" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0689 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0689" 2> "$OUTPUT_DIR/test.err.f0689" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0690 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0690" 2> "$OUTPUT_DIR/test.err.f0690" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0691 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0691" 2> "$OUTPUT_DIR/test.err.f0691" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0692 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0692" 2> "$OUTPUT_DIR/test.err.f0692" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0693 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0693" 2> "$OUTPUT_DIR/test.err.f0693" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0694 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0694" 2> "$OUTPUT_DIR/test.err.f0694" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0695 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0695" 2> "$OUTPUT_DIR/test.err.f0695" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0696 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0696" 2> "$OUTPUT_DIR/test.err.f0696" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0697 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0697" 2> "$OUTPUT_DIR/test.err.f0697" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0698 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0698" 2> "$OUTPUT_DIR/test.err.f0698" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0699 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0699" 2> "$OUTPUT_DIR/test.err.f0699" &
sleep 1800
