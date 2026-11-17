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
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0300 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0300" 2> "$OUTPUT_DIR/test.err.f0300" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0301 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0301" 2> "$OUTPUT_DIR/test.err.f0301" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0302 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0302" 2> "$OUTPUT_DIR/test.err.f0302" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0303 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0303" 2> "$OUTPUT_DIR/test.err.f0303" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0304 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0304" 2> "$OUTPUT_DIR/test.err.f0304" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0305 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0305" 2> "$OUTPUT_DIR/test.err.f0305" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0306 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0306" 2> "$OUTPUT_DIR/test.err.f0306" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0307 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0307" 2> "$OUTPUT_DIR/test.err.f0307" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0308 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0308" 2> "$OUTPUT_DIR/test.err.f0308" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0309 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0309" 2> "$OUTPUT_DIR/test.err.f0309" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0310 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0310" 2> "$OUTPUT_DIR/test.err.f0310" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0311 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0311" 2> "$OUTPUT_DIR/test.err.f0311" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0312 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0312" 2> "$OUTPUT_DIR/test.err.f0312" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0313 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0313" 2> "$OUTPUT_DIR/test.err.f0313" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0314 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0314" 2> "$OUTPUT_DIR/test.err.f0314" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0315 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0315" 2> "$OUTPUT_DIR/test.err.f0315" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0316 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0316" 2> "$OUTPUT_DIR/test.err.f0316" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0317 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0317" 2> "$OUTPUT_DIR/test.err.f0317" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0318 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0318" 2> "$OUTPUT_DIR/test.err.f0318" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0319 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0319" 2> "$OUTPUT_DIR/test.err.f0319" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0320 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0320" 2> "$OUTPUT_DIR/test.err.f0320" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0321 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0321" 2> "$OUTPUT_DIR/test.err.f0321" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0322 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0322" 2> "$OUTPUT_DIR/test.err.f0322" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0323 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0323" 2> "$OUTPUT_DIR/test.err.f0323" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0324 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0324" 2> "$OUTPUT_DIR/test.err.f0324" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0325 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0325" 2> "$OUTPUT_DIR/test.err.f0325" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0326 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0326" 2> "$OUTPUT_DIR/test.err.f0326" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0327 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0327" 2> "$OUTPUT_DIR/test.err.f0327" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0328 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0328" 2> "$OUTPUT_DIR/test.err.f0328" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0329 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0329" 2> "$OUTPUT_DIR/test.err.f0329" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0330 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0330" 2> "$OUTPUT_DIR/test.err.f0330" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0331 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0331" 2> "$OUTPUT_DIR/test.err.f0331" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0332 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0332" 2> "$OUTPUT_DIR/test.err.f0332" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0333 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0333" 2> "$OUTPUT_DIR/test.err.f0333" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0334 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0334" 2> "$OUTPUT_DIR/test.err.f0334" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0335 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0335" 2> "$OUTPUT_DIR/test.err.f0335" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0336 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0336" 2> "$OUTPUT_DIR/test.err.f0336" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0337 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0337" 2> "$OUTPUT_DIR/test.err.f0337" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0338 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0338" 2> "$OUTPUT_DIR/test.err.f0338" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0339 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0339" 2> "$OUTPUT_DIR/test.err.f0339" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0340 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0340" 2> "$OUTPUT_DIR/test.err.f0340" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0341 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0341" 2> "$OUTPUT_DIR/test.err.f0341" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0342 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0342" 2> "$OUTPUT_DIR/test.err.f0342" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0343 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0343" 2> "$OUTPUT_DIR/test.err.f0343" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0344 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0344" 2> "$OUTPUT_DIR/test.err.f0344" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0345 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0345" 2> "$OUTPUT_DIR/test.err.f0345" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0346 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0346" 2> "$OUTPUT_DIR/test.err.f0346" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0347 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0347" 2> "$OUTPUT_DIR/test.err.f0347" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0348 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0348" 2> "$OUTPUT_DIR/test.err.f0348" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0349 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0349" 2> "$OUTPUT_DIR/test.err.f0349" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0350 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0350" 2> "$OUTPUT_DIR/test.err.f0350" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0351 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0351" 2> "$OUTPUT_DIR/test.err.f0351" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0352 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0352" 2> "$OUTPUT_DIR/test.err.f0352" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0353 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0353" 2> "$OUTPUT_DIR/test.err.f0353" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0354 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0354" 2> "$OUTPUT_DIR/test.err.f0354" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0355 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0355" 2> "$OUTPUT_DIR/test.err.f0355" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0356 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0356" 2> "$OUTPUT_DIR/test.err.f0356" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0357 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0357" 2> "$OUTPUT_DIR/test.err.f0357" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0358 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0358" 2> "$OUTPUT_DIR/test.err.f0358" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0359 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0359" 2> "$OUTPUT_DIR/test.err.f0359" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0360 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0360" 2> "$OUTPUT_DIR/test.err.f0360" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0361 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0361" 2> "$OUTPUT_DIR/test.err.f0361" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0362 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0362" 2> "$OUTPUT_DIR/test.err.f0362" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0363 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0363" 2> "$OUTPUT_DIR/test.err.f0363" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0364 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0364" 2> "$OUTPUT_DIR/test.err.f0364" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0365 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0365" 2> "$OUTPUT_DIR/test.err.f0365" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0366 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0366" 2> "$OUTPUT_DIR/test.err.f0366" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0367 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0367" 2> "$OUTPUT_DIR/test.err.f0367" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0368 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0368" 2> "$OUTPUT_DIR/test.err.f0368" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0369 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0369" 2> "$OUTPUT_DIR/test.err.f0369" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0370 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0370" 2> "$OUTPUT_DIR/test.err.f0370" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0371 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0371" 2> "$OUTPUT_DIR/test.err.f0371" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0372 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0372" 2> "$OUTPUT_DIR/test.err.f0372" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0373 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0373" 2> "$OUTPUT_DIR/test.err.f0373" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0374 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0374" 2> "$OUTPUT_DIR/test.err.f0374" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0375 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0375" 2> "$OUTPUT_DIR/test.err.f0375" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0376 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0376" 2> "$OUTPUT_DIR/test.err.f0376" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0377 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0377" 2> "$OUTPUT_DIR/test.err.f0377" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0378 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0378" 2> "$OUTPUT_DIR/test.err.f0378" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0379 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0379" 2> "$OUTPUT_DIR/test.err.f0379" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0380 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0380" 2> "$OUTPUT_DIR/test.err.f0380" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0381 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0381" 2> "$OUTPUT_DIR/test.err.f0381" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0382 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0382" 2> "$OUTPUT_DIR/test.err.f0382" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0383 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0383" 2> "$OUTPUT_DIR/test.err.f0383" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0384 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0384" 2> "$OUTPUT_DIR/test.err.f0384" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0385 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0385" 2> "$OUTPUT_DIR/test.err.f0385" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0386 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0386" 2> "$OUTPUT_DIR/test.err.f0386" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0387 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0387" 2> "$OUTPUT_DIR/test.err.f0387" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0388 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0388" 2> "$OUTPUT_DIR/test.err.f0388" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0389 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0389" 2> "$OUTPUT_DIR/test.err.f0389" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0390 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0390" 2> "$OUTPUT_DIR/test.err.f0390" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0391 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0391" 2> "$OUTPUT_DIR/test.err.f0391" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0392 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0392" 2> "$OUTPUT_DIR/test.err.f0392" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0393 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0393" 2> "$OUTPUT_DIR/test.err.f0393" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0394 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0394" 2> "$OUTPUT_DIR/test.err.f0394" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0395 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0395" 2> "$OUTPUT_DIR/test.err.f0395" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0396 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0396" 2> "$OUTPUT_DIR/test.err.f0396" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0397 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0397" 2> "$OUTPUT_DIR/test.err.f0397" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0398 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0398" 2> "$OUTPUT_DIR/test.err.f0398" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0399 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0399" 2> "$OUTPUT_DIR/test.err.f0399" &
sleep 1800
