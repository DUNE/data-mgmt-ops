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
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0900 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0900" 2> "$OUTPUT_DIR/test.err.f0900" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0901 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0901" 2> "$OUTPUT_DIR/test.err.f0901" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0902 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0902" 2> "$OUTPUT_DIR/test.err.f0902" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0903 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0903" 2> "$OUTPUT_DIR/test.err.f0903" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0904 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0904" 2> "$OUTPUT_DIR/test.err.f0904" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0905 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0905" 2> "$OUTPUT_DIR/test.err.f0905" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0906 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0906" 2> "$OUTPUT_DIR/test.err.f0906" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0907 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0907" 2> "$OUTPUT_DIR/test.err.f0907" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0908 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0908" 2> "$OUTPUT_DIR/test.err.f0908" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0909 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0909" 2> "$OUTPUT_DIR/test.err.f0909" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0910 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0910" 2> "$OUTPUT_DIR/test.err.f0910" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0911 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0911" 2> "$OUTPUT_DIR/test.err.f0911" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0912 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0912" 2> "$OUTPUT_DIR/test.err.f0912" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0913 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0913" 2> "$OUTPUT_DIR/test.err.f0913" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0914 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0914" 2> "$OUTPUT_DIR/test.err.f0914" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0915 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0915" 2> "$OUTPUT_DIR/test.err.f0915" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0916 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0916" 2> "$OUTPUT_DIR/test.err.f0916" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0917 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0917" 2> "$OUTPUT_DIR/test.err.f0917" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0918 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0918" 2> "$OUTPUT_DIR/test.err.f0918" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0919 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0919" 2> "$OUTPUT_DIR/test.err.f0919" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0920 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0920" 2> "$OUTPUT_DIR/test.err.f0920" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0921 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0921" 2> "$OUTPUT_DIR/test.err.f0921" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0922 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0922" 2> "$OUTPUT_DIR/test.err.f0922" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0923 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0923" 2> "$OUTPUT_DIR/test.err.f0923" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0924 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0924" 2> "$OUTPUT_DIR/test.err.f0924" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0925 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0925" 2> "$OUTPUT_DIR/test.err.f0925" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0926 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0926" 2> "$OUTPUT_DIR/test.err.f0926" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0927 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0927" 2> "$OUTPUT_DIR/test.err.f0927" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0928 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0928" 2> "$OUTPUT_DIR/test.err.f0928" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0929 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0929" 2> "$OUTPUT_DIR/test.err.f0929" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0930 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0930" 2> "$OUTPUT_DIR/test.err.f0930" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0931 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0931" 2> "$OUTPUT_DIR/test.err.f0931" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0932 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0932" 2> "$OUTPUT_DIR/test.err.f0932" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0933 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0933" 2> "$OUTPUT_DIR/test.err.f0933" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0934 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0934" 2> "$OUTPUT_DIR/test.err.f0934" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0935 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0935" 2> "$OUTPUT_DIR/test.err.f0935" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0936 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0936" 2> "$OUTPUT_DIR/test.err.f0936" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0937 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0937" 2> "$OUTPUT_DIR/test.err.f0937" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0938 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0938" 2> "$OUTPUT_DIR/test.err.f0938" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0939 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0939" 2> "$OUTPUT_DIR/test.err.f0939" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0940 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0940" 2> "$OUTPUT_DIR/test.err.f0940" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0941 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0941" 2> "$OUTPUT_DIR/test.err.f0941" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0942 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0942" 2> "$OUTPUT_DIR/test.err.f0942" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0943 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0943" 2> "$OUTPUT_DIR/test.err.f0943" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0944 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0944" 2> "$OUTPUT_DIR/test.err.f0944" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0945 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0945" 2> "$OUTPUT_DIR/test.err.f0945" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0946 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0946" 2> "$OUTPUT_DIR/test.err.f0946" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0947 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0947" 2> "$OUTPUT_DIR/test.err.f0947" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0948 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0948" 2> "$OUTPUT_DIR/test.err.f0948" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0949 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0949" 2> "$OUTPUT_DIR/test.err.f0949" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0950 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0950" 2> "$OUTPUT_DIR/test.err.f0950" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0951 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0951" 2> "$OUTPUT_DIR/test.err.f0951" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0952 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0952" 2> "$OUTPUT_DIR/test.err.f0952" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0953 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0953" 2> "$OUTPUT_DIR/test.err.f0953" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0954 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0954" 2> "$OUTPUT_DIR/test.err.f0954" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0955 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0955" 2> "$OUTPUT_DIR/test.err.f0955" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0956 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0956" 2> "$OUTPUT_DIR/test.err.f0956" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0957 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0957" 2> "$OUTPUT_DIR/test.err.f0957" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0958 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0958" 2> "$OUTPUT_DIR/test.err.f0958" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0959 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0959" 2> "$OUTPUT_DIR/test.err.f0959" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0960 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0960" 2> "$OUTPUT_DIR/test.err.f0960" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0961 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0961" 2> "$OUTPUT_DIR/test.err.f0961" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0962 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0962" 2> "$OUTPUT_DIR/test.err.f0962" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0963 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0963" 2> "$OUTPUT_DIR/test.err.f0963" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0964 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0964" 2> "$OUTPUT_DIR/test.err.f0964" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0965 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0965" 2> "$OUTPUT_DIR/test.err.f0965" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0966 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0966" 2> "$OUTPUT_DIR/test.err.f0966" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0967 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0967" 2> "$OUTPUT_DIR/test.err.f0967" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0968 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0968" 2> "$OUTPUT_DIR/test.err.f0968" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0969 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0969" 2> "$OUTPUT_DIR/test.err.f0969" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0970 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0970" 2> "$OUTPUT_DIR/test.err.f0970" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0971 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0971" 2> "$OUTPUT_DIR/test.err.f0971" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0972 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0972" 2> "$OUTPUT_DIR/test.err.f0972" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0973 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0973" 2> "$OUTPUT_DIR/test.err.f0973" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0974 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0974" 2> "$OUTPUT_DIR/test.err.f0974" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0975 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0975" 2> "$OUTPUT_DIR/test.err.f0975" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0976 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0976" 2> "$OUTPUT_DIR/test.err.f0976" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0977 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0977" 2> "$OUTPUT_DIR/test.err.f0977" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0978 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0978" 2> "$OUTPUT_DIR/test.err.f0978" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0979 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0979" 2> "$OUTPUT_DIR/test.err.f0979" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0980 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0980" 2> "$OUTPUT_DIR/test.err.f0980" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0981 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0981" 2> "$OUTPUT_DIR/test.err.f0981" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0982 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0982" 2> "$OUTPUT_DIR/test.err.f0982" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0983 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0983" 2> "$OUTPUT_DIR/test.err.f0983" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0984 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0984" 2> "$OUTPUT_DIR/test.err.f0984" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0985 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0985" 2> "$OUTPUT_DIR/test.err.f0985" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0986 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0986" 2> "$OUTPUT_DIR/test.err.f0986" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0987 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0987" 2> "$OUTPUT_DIR/test.err.f0987" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0988 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0988" 2> "$OUTPUT_DIR/test.err.f0988" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0989 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0989" 2> "$OUTPUT_DIR/test.err.f0989" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0990 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0990" 2> "$OUTPUT_DIR/test.err.f0990" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0991 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0991" 2> "$OUTPUT_DIR/test.err.f0991" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0992 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0992" 2> "$OUTPUT_DIR/test.err.f0992" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0993 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0993" 2> "$OUTPUT_DIR/test.err.f0993" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0994 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0994" 2> "$OUTPUT_DIR/test.err.f0994" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0995 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0995" 2> "$OUTPUT_DIR/test.err.f0995" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0996 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0996" 2> "$OUTPUT_DIR/test.err.f0996" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0997 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0997" 2> "$OUTPUT_DIR/test.err.f0997" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0998 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0998" 2> "$OUTPUT_DIR/test.err.f0998" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0999 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0999" 2> "$OUTPUT_DIR/test.err.f0999" &
sleep 1800
