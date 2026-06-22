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
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0400 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0400" 2> "$OUTPUT_DIR/test.err.f0400" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0401 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0401" 2> "$OUTPUT_DIR/test.err.f0401" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0402 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0402" 2> "$OUTPUT_DIR/test.err.f0402" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0403 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0403" 2> "$OUTPUT_DIR/test.err.f0403" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0404 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0404" 2> "$OUTPUT_DIR/test.err.f0404" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0405 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0405" 2> "$OUTPUT_DIR/test.err.f0405" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0406 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0406" 2> "$OUTPUT_DIR/test.err.f0406" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0407 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0407" 2> "$OUTPUT_DIR/test.err.f0407" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0408 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0408" 2> "$OUTPUT_DIR/test.err.f0408" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0409 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0409" 2> "$OUTPUT_DIR/test.err.f0409" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0410 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0410" 2> "$OUTPUT_DIR/test.err.f0410" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0411 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0411" 2> "$OUTPUT_DIR/test.err.f0411" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0412 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0412" 2> "$OUTPUT_DIR/test.err.f0412" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0413 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0413" 2> "$OUTPUT_DIR/test.err.f0413" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0414 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0414" 2> "$OUTPUT_DIR/test.err.f0414" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0415 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0415" 2> "$OUTPUT_DIR/test.err.f0415" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0416 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0416" 2> "$OUTPUT_DIR/test.err.f0416" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0417 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0417" 2> "$OUTPUT_DIR/test.err.f0417" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0418 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0418" 2> "$OUTPUT_DIR/test.err.f0418" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0419 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0419" 2> "$OUTPUT_DIR/test.err.f0419" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0420 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0420" 2> "$OUTPUT_DIR/test.err.f0420" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0421 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0421" 2> "$OUTPUT_DIR/test.err.f0421" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0422 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0422" 2> "$OUTPUT_DIR/test.err.f0422" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0423 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0423" 2> "$OUTPUT_DIR/test.err.f0423" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0424 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0424" 2> "$OUTPUT_DIR/test.err.f0424" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0425 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0425" 2> "$OUTPUT_DIR/test.err.f0425" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0426 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0426" 2> "$OUTPUT_DIR/test.err.f0426" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0427 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0427" 2> "$OUTPUT_DIR/test.err.f0427" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0428 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0428" 2> "$OUTPUT_DIR/test.err.f0428" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0429 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0429" 2> "$OUTPUT_DIR/test.err.f0429" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0430 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0430" 2> "$OUTPUT_DIR/test.err.f0430" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0431 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0431" 2> "$OUTPUT_DIR/test.err.f0431" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0432 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0432" 2> "$OUTPUT_DIR/test.err.f0432" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0433 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0433" 2> "$OUTPUT_DIR/test.err.f0433" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0434 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0434" 2> "$OUTPUT_DIR/test.err.f0434" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0435 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0435" 2> "$OUTPUT_DIR/test.err.f0435" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0436 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0436" 2> "$OUTPUT_DIR/test.err.f0436" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0437 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0437" 2> "$OUTPUT_DIR/test.err.f0437" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0438 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0438" 2> "$OUTPUT_DIR/test.err.f0438" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0439 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0439" 2> "$OUTPUT_DIR/test.err.f0439" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0440 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0440" 2> "$OUTPUT_DIR/test.err.f0440" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0441 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0441" 2> "$OUTPUT_DIR/test.err.f0441" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0442 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0442" 2> "$OUTPUT_DIR/test.err.f0442" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0443 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0443" 2> "$OUTPUT_DIR/test.err.f0443" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0444 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0444" 2> "$OUTPUT_DIR/test.err.f0444" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0445 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0445" 2> "$OUTPUT_DIR/test.err.f0445" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0446 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0446" 2> "$OUTPUT_DIR/test.err.f0446" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0447 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0447" 2> "$OUTPUT_DIR/test.err.f0447" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0448 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0448" 2> "$OUTPUT_DIR/test.err.f0448" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0449 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0449" 2> "$OUTPUT_DIR/test.err.f0449" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0450 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0450" 2> "$OUTPUT_DIR/test.err.f0450" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0451 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0451" 2> "$OUTPUT_DIR/test.err.f0451" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0452 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0452" 2> "$OUTPUT_DIR/test.err.f0452" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0453 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0453" 2> "$OUTPUT_DIR/test.err.f0453" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0454 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0454" 2> "$OUTPUT_DIR/test.err.f0454" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0455 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0455" 2> "$OUTPUT_DIR/test.err.f0455" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0456 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0456" 2> "$OUTPUT_DIR/test.err.f0456" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0457 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0457" 2> "$OUTPUT_DIR/test.err.f0457" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0458 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0458" 2> "$OUTPUT_DIR/test.err.f0458" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0459 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0459" 2> "$OUTPUT_DIR/test.err.f0459" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0460 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0460" 2> "$OUTPUT_DIR/test.err.f0460" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0461 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0461" 2> "$OUTPUT_DIR/test.err.f0461" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0462 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0462" 2> "$OUTPUT_DIR/test.err.f0462" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0463 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0463" 2> "$OUTPUT_DIR/test.err.f0463" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0464 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0464" 2> "$OUTPUT_DIR/test.err.f0464" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0465 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0465" 2> "$OUTPUT_DIR/test.err.f0465" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0466 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0466" 2> "$OUTPUT_DIR/test.err.f0466" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0467 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0467" 2> "$OUTPUT_DIR/test.err.f0467" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0468 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0468" 2> "$OUTPUT_DIR/test.err.f0468" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0469 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0469" 2> "$OUTPUT_DIR/test.err.f0469" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0470 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0470" 2> "$OUTPUT_DIR/test.err.f0470" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0471 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0471" 2> "$OUTPUT_DIR/test.err.f0471" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0472 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0472" 2> "$OUTPUT_DIR/test.err.f0472" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0473 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0473" 2> "$OUTPUT_DIR/test.err.f0473" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0474 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0474" 2> "$OUTPUT_DIR/test.err.f0474" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0475 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0475" 2> "$OUTPUT_DIR/test.err.f0475" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0476 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0476" 2> "$OUTPUT_DIR/test.err.f0476" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0477 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0477" 2> "$OUTPUT_DIR/test.err.f0477" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0478 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0478" 2> "$OUTPUT_DIR/test.err.f0478" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0479 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0479" 2> "$OUTPUT_DIR/test.err.f0479" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0480 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0480" 2> "$OUTPUT_DIR/test.err.f0480" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0481 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0481" 2> "$OUTPUT_DIR/test.err.f0481" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0482 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0482" 2> "$OUTPUT_DIR/test.err.f0482" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0483 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0483" 2> "$OUTPUT_DIR/test.err.f0483" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0484 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0484" 2> "$OUTPUT_DIR/test.err.f0484" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0485 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0485" 2> "$OUTPUT_DIR/test.err.f0485" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0486 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0486" 2> "$OUTPUT_DIR/test.err.f0486" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0487 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0487" 2> "$OUTPUT_DIR/test.err.f0487" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0488 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0488" 2> "$OUTPUT_DIR/test.err.f0488" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0489 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0489" 2> "$OUTPUT_DIR/test.err.f0489" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0490 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0490" 2> "$OUTPUT_DIR/test.err.f0490" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0491 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0491" 2> "$OUTPUT_DIR/test.err.f0491" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0492 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0492" 2> "$OUTPUT_DIR/test.err.f0492" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0493 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0493" 2> "$OUTPUT_DIR/test.err.f0493" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0494 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0494" 2> "$OUTPUT_DIR/test.err.f0494" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0495 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0495" 2> "$OUTPUT_DIR/test.err.f0495" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0496 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0496" 2> "$OUTPUT_DIR/test.err.f0496" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0497 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0497" 2> "$OUTPUT_DIR/test.err.f0497" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0498 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0498" 2> "$OUTPUT_DIR/test.err.f0498" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f0499 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f0499" 2> "$OUTPUT_DIR/test.err.f0499" &
sleep 1800
