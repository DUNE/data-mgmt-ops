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
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0800 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0800" 2> "$OUTPUT_DIR/test.err.f0800" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0801 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0801" 2> "$OUTPUT_DIR/test.err.f0801" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0802 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0802" 2> "$OUTPUT_DIR/test.err.f0802" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0803 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0803" 2> "$OUTPUT_DIR/test.err.f0803" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0804 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0804" 2> "$OUTPUT_DIR/test.err.f0804" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0805 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0805" 2> "$OUTPUT_DIR/test.err.f0805" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0806 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0806" 2> "$OUTPUT_DIR/test.err.f0806" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0807 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0807" 2> "$OUTPUT_DIR/test.err.f0807" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0808 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0808" 2> "$OUTPUT_DIR/test.err.f0808" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0809 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0809" 2> "$OUTPUT_DIR/test.err.f0809" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0810 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0810" 2> "$OUTPUT_DIR/test.err.f0810" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0811 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0811" 2> "$OUTPUT_DIR/test.err.f0811" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0812 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0812" 2> "$OUTPUT_DIR/test.err.f0812" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0813 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0813" 2> "$OUTPUT_DIR/test.err.f0813" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0814 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0814" 2> "$OUTPUT_DIR/test.err.f0814" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0815 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0815" 2> "$OUTPUT_DIR/test.err.f0815" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0816 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0816" 2> "$OUTPUT_DIR/test.err.f0816" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0817 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0817" 2> "$OUTPUT_DIR/test.err.f0817" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0818 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0818" 2> "$OUTPUT_DIR/test.err.f0818" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0819 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0819" 2> "$OUTPUT_DIR/test.err.f0819" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0820 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0820" 2> "$OUTPUT_DIR/test.err.f0820" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0821 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0821" 2> "$OUTPUT_DIR/test.err.f0821" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0822 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0822" 2> "$OUTPUT_DIR/test.err.f0822" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0823 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0823" 2> "$OUTPUT_DIR/test.err.f0823" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0824 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0824" 2> "$OUTPUT_DIR/test.err.f0824" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0825 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0825" 2> "$OUTPUT_DIR/test.err.f0825" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0826 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0826" 2> "$OUTPUT_DIR/test.err.f0826" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0827 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0827" 2> "$OUTPUT_DIR/test.err.f0827" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0828 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0828" 2> "$OUTPUT_DIR/test.err.f0828" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0829 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0829" 2> "$OUTPUT_DIR/test.err.f0829" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0830 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0830" 2> "$OUTPUT_DIR/test.err.f0830" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0831 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0831" 2> "$OUTPUT_DIR/test.err.f0831" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0832 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0832" 2> "$OUTPUT_DIR/test.err.f0832" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0833 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0833" 2> "$OUTPUT_DIR/test.err.f0833" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0834 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0834" 2> "$OUTPUT_DIR/test.err.f0834" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0835 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0835" 2> "$OUTPUT_DIR/test.err.f0835" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0836 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0836" 2> "$OUTPUT_DIR/test.err.f0836" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0837 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0837" 2> "$OUTPUT_DIR/test.err.f0837" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0838 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0838" 2> "$OUTPUT_DIR/test.err.f0838" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0839 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0839" 2> "$OUTPUT_DIR/test.err.f0839" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0840 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0840" 2> "$OUTPUT_DIR/test.err.f0840" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0841 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0841" 2> "$OUTPUT_DIR/test.err.f0841" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0842 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0842" 2> "$OUTPUT_DIR/test.err.f0842" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0843 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0843" 2> "$OUTPUT_DIR/test.err.f0843" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0844 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0844" 2> "$OUTPUT_DIR/test.err.f0844" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0845 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0845" 2> "$OUTPUT_DIR/test.err.f0845" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0846 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0846" 2> "$OUTPUT_DIR/test.err.f0846" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0847 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0847" 2> "$OUTPUT_DIR/test.err.f0847" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0848 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0848" 2> "$OUTPUT_DIR/test.err.f0848" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0849 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0849" 2> "$OUTPUT_DIR/test.err.f0849" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0850 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0850" 2> "$OUTPUT_DIR/test.err.f0850" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0851 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0851" 2> "$OUTPUT_DIR/test.err.f0851" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0852 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0852" 2> "$OUTPUT_DIR/test.err.f0852" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0853 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0853" 2> "$OUTPUT_DIR/test.err.f0853" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0854 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0854" 2> "$OUTPUT_DIR/test.err.f0854" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0855 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0855" 2> "$OUTPUT_DIR/test.err.f0855" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0856 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0856" 2> "$OUTPUT_DIR/test.err.f0856" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0857 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0857" 2> "$OUTPUT_DIR/test.err.f0857" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0858 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0858" 2> "$OUTPUT_DIR/test.err.f0858" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0859 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0859" 2> "$OUTPUT_DIR/test.err.f0859" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0860 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0860" 2> "$OUTPUT_DIR/test.err.f0860" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0861 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0861" 2> "$OUTPUT_DIR/test.err.f0861" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0862 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0862" 2> "$OUTPUT_DIR/test.err.f0862" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0863 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0863" 2> "$OUTPUT_DIR/test.err.f0863" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0864 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0864" 2> "$OUTPUT_DIR/test.err.f0864" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0865 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0865" 2> "$OUTPUT_DIR/test.err.f0865" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0866 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0866" 2> "$OUTPUT_DIR/test.err.f0866" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0867 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0867" 2> "$OUTPUT_DIR/test.err.f0867" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0868 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0868" 2> "$OUTPUT_DIR/test.err.f0868" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0869 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0869" 2> "$OUTPUT_DIR/test.err.f0869" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0870 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0870" 2> "$OUTPUT_DIR/test.err.f0870" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0871 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0871" 2> "$OUTPUT_DIR/test.err.f0871" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0872 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0872" 2> "$OUTPUT_DIR/test.err.f0872" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0873 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0873" 2> "$OUTPUT_DIR/test.err.f0873" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0874 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0874" 2> "$OUTPUT_DIR/test.err.f0874" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0875 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0875" 2> "$OUTPUT_DIR/test.err.f0875" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0876 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0876" 2> "$OUTPUT_DIR/test.err.f0876" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0877 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0877" 2> "$OUTPUT_DIR/test.err.f0877" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0878 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0878" 2> "$OUTPUT_DIR/test.err.f0878" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0879 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0879" 2> "$OUTPUT_DIR/test.err.f0879" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0880 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0880" 2> "$OUTPUT_DIR/test.err.f0880" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0881 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0881" 2> "$OUTPUT_DIR/test.err.f0881" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0882 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0882" 2> "$OUTPUT_DIR/test.err.f0882" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0883 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0883" 2> "$OUTPUT_DIR/test.err.f0883" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0884 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0884" 2> "$OUTPUT_DIR/test.err.f0884" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0885 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0885" 2> "$OUTPUT_DIR/test.err.f0885" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0886 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0886" 2> "$OUTPUT_DIR/test.err.f0886" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0887 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0887" 2> "$OUTPUT_DIR/test.err.f0887" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0888 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0888" 2> "$OUTPUT_DIR/test.err.f0888" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0889 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0889" 2> "$OUTPUT_DIR/test.err.f0889" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0890 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0890" 2> "$OUTPUT_DIR/test.err.f0890" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0891 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0891" 2> "$OUTPUT_DIR/test.err.f0891" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0892 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0892" 2> "$OUTPUT_DIR/test.err.f0892" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0893 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0893" 2> "$OUTPUT_DIR/test.err.f0893" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0894 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0894" 2> "$OUTPUT_DIR/test.err.f0894" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0895 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0895" 2> "$OUTPUT_DIR/test.err.f0895" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0896 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0896" 2> "$OUTPUT_DIR/test.err.f0896" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0897 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0897" 2> "$OUTPUT_DIR/test.err.f0897" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0898 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0898" 2> "$OUTPUT_DIR/test.err.f0898" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0899 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0899" 2> "$OUTPUT_DIR/test.err.f0899" &
sleep 1800
