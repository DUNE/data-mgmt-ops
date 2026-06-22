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
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0100 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0100" 2> "$OUTPUT_DIR/test.err.f0100" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0101 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0101" 2> "$OUTPUT_DIR/test.err.f0101" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0102 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0102" 2> "$OUTPUT_DIR/test.err.f0102" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0103 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0103" 2> "$OUTPUT_DIR/test.err.f0103" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0104 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0104" 2> "$OUTPUT_DIR/test.err.f0104" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0105 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0105" 2> "$OUTPUT_DIR/test.err.f0105" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0106 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0106" 2> "$OUTPUT_DIR/test.err.f0106" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0107 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0107" 2> "$OUTPUT_DIR/test.err.f0107" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0108 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0108" 2> "$OUTPUT_DIR/test.err.f0108" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0109 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0109" 2> "$OUTPUT_DIR/test.err.f0109" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0110 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0110" 2> "$OUTPUT_DIR/test.err.f0110" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0111 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0111" 2> "$OUTPUT_DIR/test.err.f0111" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0112 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0112" 2> "$OUTPUT_DIR/test.err.f0112" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0113 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0113" 2> "$OUTPUT_DIR/test.err.f0113" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0114 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0114" 2> "$OUTPUT_DIR/test.err.f0114" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0115 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0115" 2> "$OUTPUT_DIR/test.err.f0115" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0116 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0116" 2> "$OUTPUT_DIR/test.err.f0116" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0117 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0117" 2> "$OUTPUT_DIR/test.err.f0117" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0118 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0118" 2> "$OUTPUT_DIR/test.err.f0118" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0119 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0119" 2> "$OUTPUT_DIR/test.err.f0119" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0120 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0120" 2> "$OUTPUT_DIR/test.err.f0120" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0121 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0121" 2> "$OUTPUT_DIR/test.err.f0121" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0122 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0122" 2> "$OUTPUT_DIR/test.err.f0122" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0123 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0123" 2> "$OUTPUT_DIR/test.err.f0123" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0124 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0124" 2> "$OUTPUT_DIR/test.err.f0124" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0125 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0125" 2> "$OUTPUT_DIR/test.err.f0125" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0126 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0126" 2> "$OUTPUT_DIR/test.err.f0126" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0127 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0127" 2> "$OUTPUT_DIR/test.err.f0127" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0128 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0128" 2> "$OUTPUT_DIR/test.err.f0128" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0129 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0129" 2> "$OUTPUT_DIR/test.err.f0129" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0130 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0130" 2> "$OUTPUT_DIR/test.err.f0130" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0131 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0131" 2> "$OUTPUT_DIR/test.err.f0131" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0132 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0132" 2> "$OUTPUT_DIR/test.err.f0132" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0133 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0133" 2> "$OUTPUT_DIR/test.err.f0133" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0134 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0134" 2> "$OUTPUT_DIR/test.err.f0134" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0135 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0135" 2> "$OUTPUT_DIR/test.err.f0135" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0136 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0136" 2> "$OUTPUT_DIR/test.err.f0136" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0137 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0137" 2> "$OUTPUT_DIR/test.err.f0137" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0138 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0138" 2> "$OUTPUT_DIR/test.err.f0138" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0139 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0139" 2> "$OUTPUT_DIR/test.err.f0139" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0140 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0140" 2> "$OUTPUT_DIR/test.err.f0140" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0141 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0141" 2> "$OUTPUT_DIR/test.err.f0141" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0142 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0142" 2> "$OUTPUT_DIR/test.err.f0142" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0143 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0143" 2> "$OUTPUT_DIR/test.err.f0143" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0144 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0144" 2> "$OUTPUT_DIR/test.err.f0144" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0145 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0145" 2> "$OUTPUT_DIR/test.err.f0145" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0146 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0146" 2> "$OUTPUT_DIR/test.err.f0146" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0147 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0147" 2> "$OUTPUT_DIR/test.err.f0147" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0148 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0148" 2> "$OUTPUT_DIR/test.err.f0148" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0149 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0149" 2> "$OUTPUT_DIR/test.err.f0149" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0150 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0150" 2> "$OUTPUT_DIR/test.err.f0150" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0151 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0151" 2> "$OUTPUT_DIR/test.err.f0151" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0152 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0152" 2> "$OUTPUT_DIR/test.err.f0152" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0153 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0153" 2> "$OUTPUT_DIR/test.err.f0153" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0154 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0154" 2> "$OUTPUT_DIR/test.err.f0154" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0155 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0155" 2> "$OUTPUT_DIR/test.err.f0155" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0156 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0156" 2> "$OUTPUT_DIR/test.err.f0156" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0157 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0157" 2> "$OUTPUT_DIR/test.err.f0157" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0158 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0158" 2> "$OUTPUT_DIR/test.err.f0158" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0159 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0159" 2> "$OUTPUT_DIR/test.err.f0159" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0160 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0160" 2> "$OUTPUT_DIR/test.err.f0160" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0161 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0161" 2> "$OUTPUT_DIR/test.err.f0161" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0162 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0162" 2> "$OUTPUT_DIR/test.err.f0162" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0163 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0163" 2> "$OUTPUT_DIR/test.err.f0163" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0164 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0164" 2> "$OUTPUT_DIR/test.err.f0164" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0165 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0165" 2> "$OUTPUT_DIR/test.err.f0165" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0166 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0166" 2> "$OUTPUT_DIR/test.err.f0166" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0167 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0167" 2> "$OUTPUT_DIR/test.err.f0167" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0168 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0168" 2> "$OUTPUT_DIR/test.err.f0168" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0169 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0169" 2> "$OUTPUT_DIR/test.err.f0169" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0170 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0170" 2> "$OUTPUT_DIR/test.err.f0170" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0171 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0171" 2> "$OUTPUT_DIR/test.err.f0171" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0172 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0172" 2> "$OUTPUT_DIR/test.err.f0172" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0173 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0173" 2> "$OUTPUT_DIR/test.err.f0173" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0174 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0174" 2> "$OUTPUT_DIR/test.err.f0174" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0175 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0175" 2> "$OUTPUT_DIR/test.err.f0175" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0176 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0176" 2> "$OUTPUT_DIR/test.err.f0176" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0177 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0177" 2> "$OUTPUT_DIR/test.err.f0177" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0178 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0178" 2> "$OUTPUT_DIR/test.err.f0178" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0179 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0179" 2> "$OUTPUT_DIR/test.err.f0179" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0180 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0180" 2> "$OUTPUT_DIR/test.err.f0180" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0181 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0181" 2> "$OUTPUT_DIR/test.err.f0181" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0182 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0182" 2> "$OUTPUT_DIR/test.err.f0182" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0183 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0183" 2> "$OUTPUT_DIR/test.err.f0183" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0184 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0184" 2> "$OUTPUT_DIR/test.err.f0184" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0185 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0185" 2> "$OUTPUT_DIR/test.err.f0185" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0186 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0186" 2> "$OUTPUT_DIR/test.err.f0186" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0187 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0187" 2> "$OUTPUT_DIR/test.err.f0187" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0188 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0188" 2> "$OUTPUT_DIR/test.err.f0188" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0189 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0189" 2> "$OUTPUT_DIR/test.err.f0189" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0190 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0190" 2> "$OUTPUT_DIR/test.err.f0190" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0191 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0191" 2> "$OUTPUT_DIR/test.err.f0191" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0192 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0192" 2> "$OUTPUT_DIR/test.err.f0192" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0193 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0193" 2> "$OUTPUT_DIR/test.err.f0193" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0194 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0194" 2> "$OUTPUT_DIR/test.err.f0194" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0195 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0195" 2> "$OUTPUT_DIR/test.err.f0195" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0196 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0196" 2> "$OUTPUT_DIR/test.err.f0196" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0197 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0197" 2> "$OUTPUT_DIR/test.err.f0197" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0198 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0198" 2> "$OUTPUT_DIR/test.err.f0198" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0199 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0199" 2> "$OUTPUT_DIR/test.err.f0199" &
sleep 1800
