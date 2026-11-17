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
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0200 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0200" 2> "$OUTPUT_DIR/test.err.f0200" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0201 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0201" 2> "$OUTPUT_DIR/test.err.f0201" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0202 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0202" 2> "$OUTPUT_DIR/test.err.f0202" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0203 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0203" 2> "$OUTPUT_DIR/test.err.f0203" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0204 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0204" 2> "$OUTPUT_DIR/test.err.f0204" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0205 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0205" 2> "$OUTPUT_DIR/test.err.f0205" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0206 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0206" 2> "$OUTPUT_DIR/test.err.f0206" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0207 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0207" 2> "$OUTPUT_DIR/test.err.f0207" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0208 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0208" 2> "$OUTPUT_DIR/test.err.f0208" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0209 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0209" 2> "$OUTPUT_DIR/test.err.f0209" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0210 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0210" 2> "$OUTPUT_DIR/test.err.f0210" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0211 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0211" 2> "$OUTPUT_DIR/test.err.f0211" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0212 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0212" 2> "$OUTPUT_DIR/test.err.f0212" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0213 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0213" 2> "$OUTPUT_DIR/test.err.f0213" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0214 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0214" 2> "$OUTPUT_DIR/test.err.f0214" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0215 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0215" 2> "$OUTPUT_DIR/test.err.f0215" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0216 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0216" 2> "$OUTPUT_DIR/test.err.f0216" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0217 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0217" 2> "$OUTPUT_DIR/test.err.f0217" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0218 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0218" 2> "$OUTPUT_DIR/test.err.f0218" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0219 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0219" 2> "$OUTPUT_DIR/test.err.f0219" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0220 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0220" 2> "$OUTPUT_DIR/test.err.f0220" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0221 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0221" 2> "$OUTPUT_DIR/test.err.f0221" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0222 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0222" 2> "$OUTPUT_DIR/test.err.f0222" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0223 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0223" 2> "$OUTPUT_DIR/test.err.f0223" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0224 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0224" 2> "$OUTPUT_DIR/test.err.f0224" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0225 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0225" 2> "$OUTPUT_DIR/test.err.f0225" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0226 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0226" 2> "$OUTPUT_DIR/test.err.f0226" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0227 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0227" 2> "$OUTPUT_DIR/test.err.f0227" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0228 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0228" 2> "$OUTPUT_DIR/test.err.f0228" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0229 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0229" 2> "$OUTPUT_DIR/test.err.f0229" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0230 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0230" 2> "$OUTPUT_DIR/test.err.f0230" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0231 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0231" 2> "$OUTPUT_DIR/test.err.f0231" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0232 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0232" 2> "$OUTPUT_DIR/test.err.f0232" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0233 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0233" 2> "$OUTPUT_DIR/test.err.f0233" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0234 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0234" 2> "$OUTPUT_DIR/test.err.f0234" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0235 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0235" 2> "$OUTPUT_DIR/test.err.f0235" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0236 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0236" 2> "$OUTPUT_DIR/test.err.f0236" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0237 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0237" 2> "$OUTPUT_DIR/test.err.f0237" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0238 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0238" 2> "$OUTPUT_DIR/test.err.f0238" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0239 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0239" 2> "$OUTPUT_DIR/test.err.f0239" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0240 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0240" 2> "$OUTPUT_DIR/test.err.f0240" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0241 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0241" 2> "$OUTPUT_DIR/test.err.f0241" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0242 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0242" 2> "$OUTPUT_DIR/test.err.f0242" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0243 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0243" 2> "$OUTPUT_DIR/test.err.f0243" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0244 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0244" 2> "$OUTPUT_DIR/test.err.f0244" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0245 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0245" 2> "$OUTPUT_DIR/test.err.f0245" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0246 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0246" 2> "$OUTPUT_DIR/test.err.f0246" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0247 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0247" 2> "$OUTPUT_DIR/test.err.f0247" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0248 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0248" 2> "$OUTPUT_DIR/test.err.f0248" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0249 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0249" 2> "$OUTPUT_DIR/test.err.f0249" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0250 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0250" 2> "$OUTPUT_DIR/test.err.f0250" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0251 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0251" 2> "$OUTPUT_DIR/test.err.f0251" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0252 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0252" 2> "$OUTPUT_DIR/test.err.f0252" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0253 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0253" 2> "$OUTPUT_DIR/test.err.f0253" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0254 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0254" 2> "$OUTPUT_DIR/test.err.f0254" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0255 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0255" 2> "$OUTPUT_DIR/test.err.f0255" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0256 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0256" 2> "$OUTPUT_DIR/test.err.f0256" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0257 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0257" 2> "$OUTPUT_DIR/test.err.f0257" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0258 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0258" 2> "$OUTPUT_DIR/test.err.f0258" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0259 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0259" 2> "$OUTPUT_DIR/test.err.f0259" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0260 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0260" 2> "$OUTPUT_DIR/test.err.f0260" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0261 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0261" 2> "$OUTPUT_DIR/test.err.f0261" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0262 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0262" 2> "$OUTPUT_DIR/test.err.f0262" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0263 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0263" 2> "$OUTPUT_DIR/test.err.f0263" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0264 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0264" 2> "$OUTPUT_DIR/test.err.f0264" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0265 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0265" 2> "$OUTPUT_DIR/test.err.f0265" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0266 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0266" 2> "$OUTPUT_DIR/test.err.f0266" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0267 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0267" 2> "$OUTPUT_DIR/test.err.f0267" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0268 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0268" 2> "$OUTPUT_DIR/test.err.f0268" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0269 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0269" 2> "$OUTPUT_DIR/test.err.f0269" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0270 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0270" 2> "$OUTPUT_DIR/test.err.f0270" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0271 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0271" 2> "$OUTPUT_DIR/test.err.f0271" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0272 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0272" 2> "$OUTPUT_DIR/test.err.f0272" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0273 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0273" 2> "$OUTPUT_DIR/test.err.f0273" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0274 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0274" 2> "$OUTPUT_DIR/test.err.f0274" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0275 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0275" 2> "$OUTPUT_DIR/test.err.f0275" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0276 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0276" 2> "$OUTPUT_DIR/test.err.f0276" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0277 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0277" 2> "$OUTPUT_DIR/test.err.f0277" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0278 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0278" 2> "$OUTPUT_DIR/test.err.f0278" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0279 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0279" 2> "$OUTPUT_DIR/test.err.f0279" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0280 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0280" 2> "$OUTPUT_DIR/test.err.f0280" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0281 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0281" 2> "$OUTPUT_DIR/test.err.f0281" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0282 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0282" 2> "$OUTPUT_DIR/test.err.f0282" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0283 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0283" 2> "$OUTPUT_DIR/test.err.f0283" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0284 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0284" 2> "$OUTPUT_DIR/test.err.f0284" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0285 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0285" 2> "$OUTPUT_DIR/test.err.f0285" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0286 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0286" 2> "$OUTPUT_DIR/test.err.f0286" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0287 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0287" 2> "$OUTPUT_DIR/test.err.f0287" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0288 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0288" 2> "$OUTPUT_DIR/test.err.f0288" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0289 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0289" 2> "$OUTPUT_DIR/test.err.f0289" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0290 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0290" 2> "$OUTPUT_DIR/test.err.f0290" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0291 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0291" 2> "$OUTPUT_DIR/test.err.f0291" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0292 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0292" 2> "$OUTPUT_DIR/test.err.f0292" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0293 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0293" 2> "$OUTPUT_DIR/test.err.f0293" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0294 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0294" 2> "$OUTPUT_DIR/test.err.f0294" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0295 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0295" 2> "$OUTPUT_DIR/test.err.f0295" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0296 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0296" 2> "$OUTPUT_DIR/test.err.f0296" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0297 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0297" 2> "$OUTPUT_DIR/test.err.f0297" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0298 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0298" 2> "$OUTPUT_DIR/test.err.f0298" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0299 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0299" 2> "$OUTPUT_DIR/test.err.f0299" &
sleep 1800
