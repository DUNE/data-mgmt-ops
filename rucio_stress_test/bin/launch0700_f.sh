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
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0700 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0700" 2> "$OUTPUT_DIR/test.err.f0700" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0701 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0701" 2> "$OUTPUT_DIR/test.err.f0701" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0702 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0702" 2> "$OUTPUT_DIR/test.err.f0702" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0703 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0703" 2> "$OUTPUT_DIR/test.err.f0703" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0704 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0704" 2> "$OUTPUT_DIR/test.err.f0704" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0705 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0705" 2> "$OUTPUT_DIR/test.err.f0705" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0706 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0706" 2> "$OUTPUT_DIR/test.err.f0706" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0707 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0707" 2> "$OUTPUT_DIR/test.err.f0707" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0708 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0708" 2> "$OUTPUT_DIR/test.err.f0708" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0709 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0709" 2> "$OUTPUT_DIR/test.err.f0709" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0710 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0710" 2> "$OUTPUT_DIR/test.err.f0710" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0711 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0711" 2> "$OUTPUT_DIR/test.err.f0711" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0712 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0712" 2> "$OUTPUT_DIR/test.err.f0712" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0713 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0713" 2> "$OUTPUT_DIR/test.err.f0713" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0714 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0714" 2> "$OUTPUT_DIR/test.err.f0714" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0715 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0715" 2> "$OUTPUT_DIR/test.err.f0715" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0716 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0716" 2> "$OUTPUT_DIR/test.err.f0716" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0717 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0717" 2> "$OUTPUT_DIR/test.err.f0717" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0718 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0718" 2> "$OUTPUT_DIR/test.err.f0718" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0719 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0719" 2> "$OUTPUT_DIR/test.err.f0719" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0720 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0720" 2> "$OUTPUT_DIR/test.err.f0720" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0721 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0721" 2> "$OUTPUT_DIR/test.err.f0721" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0722 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0722" 2> "$OUTPUT_DIR/test.err.f0722" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0723 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0723" 2> "$OUTPUT_DIR/test.err.f0723" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0724 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0724" 2> "$OUTPUT_DIR/test.err.f0724" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0725 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0725" 2> "$OUTPUT_DIR/test.err.f0725" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0726 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0726" 2> "$OUTPUT_DIR/test.err.f0726" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0727 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0727" 2> "$OUTPUT_DIR/test.err.f0727" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0728 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0728" 2> "$OUTPUT_DIR/test.err.f0728" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0729 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0729" 2> "$OUTPUT_DIR/test.err.f0729" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0730 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0730" 2> "$OUTPUT_DIR/test.err.f0730" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0731 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0731" 2> "$OUTPUT_DIR/test.err.f0731" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0732 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0732" 2> "$OUTPUT_DIR/test.err.f0732" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0733 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0733" 2> "$OUTPUT_DIR/test.err.f0733" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0734 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0734" 2> "$OUTPUT_DIR/test.err.f0734" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0735 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0735" 2> "$OUTPUT_DIR/test.err.f0735" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0736 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0736" 2> "$OUTPUT_DIR/test.err.f0736" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0737 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0737" 2> "$OUTPUT_DIR/test.err.f0737" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0738 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0738" 2> "$OUTPUT_DIR/test.err.f0738" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0739 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0739" 2> "$OUTPUT_DIR/test.err.f0739" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0740 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0740" 2> "$OUTPUT_DIR/test.err.f0740" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0741 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0741" 2> "$OUTPUT_DIR/test.err.f0741" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0742 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0742" 2> "$OUTPUT_DIR/test.err.f0742" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0743 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0743" 2> "$OUTPUT_DIR/test.err.f0743" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0744 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0744" 2> "$OUTPUT_DIR/test.err.f0744" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0745 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0745" 2> "$OUTPUT_DIR/test.err.f0745" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0746 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0746" 2> "$OUTPUT_DIR/test.err.f0746" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0747 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0747" 2> "$OUTPUT_DIR/test.err.f0747" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0748 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0748" 2> "$OUTPUT_DIR/test.err.f0748" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0749 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0749" 2> "$OUTPUT_DIR/test.err.f0749" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0750 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0750" 2> "$OUTPUT_DIR/test.err.f0750" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0751 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0751" 2> "$OUTPUT_DIR/test.err.f0751" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0752 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0752" 2> "$OUTPUT_DIR/test.err.f0752" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0753 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0753" 2> "$OUTPUT_DIR/test.err.f0753" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0754 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0754" 2> "$OUTPUT_DIR/test.err.f0754" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0755 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0755" 2> "$OUTPUT_DIR/test.err.f0755" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0756 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0756" 2> "$OUTPUT_DIR/test.err.f0756" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0757 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0757" 2> "$OUTPUT_DIR/test.err.f0757" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0758 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0758" 2> "$OUTPUT_DIR/test.err.f0758" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0759 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0759" 2> "$OUTPUT_DIR/test.err.f0759" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0760 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0760" 2> "$OUTPUT_DIR/test.err.f0760" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0761 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0761" 2> "$OUTPUT_DIR/test.err.f0761" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0762 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0762" 2> "$OUTPUT_DIR/test.err.f0762" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0763 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0763" 2> "$OUTPUT_DIR/test.err.f0763" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0764 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0764" 2> "$OUTPUT_DIR/test.err.f0764" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0765 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0765" 2> "$OUTPUT_DIR/test.err.f0765" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0766 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0766" 2> "$OUTPUT_DIR/test.err.f0766" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0767 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0767" 2> "$OUTPUT_DIR/test.err.f0767" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0768 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0768" 2> "$OUTPUT_DIR/test.err.f0768" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0769 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0769" 2> "$OUTPUT_DIR/test.err.f0769" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0770 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0770" 2> "$OUTPUT_DIR/test.err.f0770" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0771 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0771" 2> "$OUTPUT_DIR/test.err.f0771" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0772 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0772" 2> "$OUTPUT_DIR/test.err.f0772" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0773 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0773" 2> "$OUTPUT_DIR/test.err.f0773" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0774 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0774" 2> "$OUTPUT_DIR/test.err.f0774" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0775 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0775" 2> "$OUTPUT_DIR/test.err.f0775" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0776 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0776" 2> "$OUTPUT_DIR/test.err.f0776" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0777 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0777" 2> "$OUTPUT_DIR/test.err.f0777" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0778 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0778" 2> "$OUTPUT_DIR/test.err.f0778" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0779 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0779" 2> "$OUTPUT_DIR/test.err.f0779" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0780 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0780" 2> "$OUTPUT_DIR/test.err.f0780" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0781 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0781" 2> "$OUTPUT_DIR/test.err.f0781" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0782 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0782" 2> "$OUTPUT_DIR/test.err.f0782" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0783 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0783" 2> "$OUTPUT_DIR/test.err.f0783" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0784 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0784" 2> "$OUTPUT_DIR/test.err.f0784" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0785 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0785" 2> "$OUTPUT_DIR/test.err.f0785" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0786 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0786" 2> "$OUTPUT_DIR/test.err.f0786" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0787 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0787" 2> "$OUTPUT_DIR/test.err.f0787" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0788 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0788" 2> "$OUTPUT_DIR/test.err.f0788" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0789 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0789" 2> "$OUTPUT_DIR/test.err.f0789" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0790 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0790" 2> "$OUTPUT_DIR/test.err.f0790" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0791 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0791" 2> "$OUTPUT_DIR/test.err.f0791" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0792 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0792" 2> "$OUTPUT_DIR/test.err.f0792" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0793 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0793" 2> "$OUTPUT_DIR/test.err.f0793" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0794 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0794" 2> "$OUTPUT_DIR/test.err.f0794" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0795 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0795" 2> "$OUTPUT_DIR/test.err.f0795" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0796 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0796" 2> "$OUTPUT_DIR/test.err.f0796" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0797 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0797" 2> "$OUTPUT_DIR/test.err.f0797" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0798 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0798" 2> "$OUTPUT_DIR/test.err.f0798" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0799 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0799" 2> "$OUTPUT_DIR/test.err.f0799" &
sleep 1800
