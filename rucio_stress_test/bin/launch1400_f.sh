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
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1400 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1400" 2> "$OUTPUT_DIR/test.err.f1400" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1401 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1401" 2> "$OUTPUT_DIR/test.err.f1401" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1402 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1402" 2> "$OUTPUT_DIR/test.err.f1402" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1403 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1403" 2> "$OUTPUT_DIR/test.err.f1403" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1404 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1404" 2> "$OUTPUT_DIR/test.err.f1404" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1405 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1405" 2> "$OUTPUT_DIR/test.err.f1405" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1406 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1406" 2> "$OUTPUT_DIR/test.err.f1406" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1407 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1407" 2> "$OUTPUT_DIR/test.err.f1407" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1408 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1408" 2> "$OUTPUT_DIR/test.err.f1408" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1409 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1409" 2> "$OUTPUT_DIR/test.err.f1409" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1410 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1410" 2> "$OUTPUT_DIR/test.err.f1410" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1411 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1411" 2> "$OUTPUT_DIR/test.err.f1411" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1412 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1412" 2> "$OUTPUT_DIR/test.err.f1412" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1413 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1413" 2> "$OUTPUT_DIR/test.err.f1413" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1414 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1414" 2> "$OUTPUT_DIR/test.err.f1414" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1415 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1415" 2> "$OUTPUT_DIR/test.err.f1415" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1416 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1416" 2> "$OUTPUT_DIR/test.err.f1416" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1417 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1417" 2> "$OUTPUT_DIR/test.err.f1417" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1418 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1418" 2> "$OUTPUT_DIR/test.err.f1418" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1419 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1419" 2> "$OUTPUT_DIR/test.err.f1419" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1420 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1420" 2> "$OUTPUT_DIR/test.err.f1420" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1421 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1421" 2> "$OUTPUT_DIR/test.err.f1421" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1422 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1422" 2> "$OUTPUT_DIR/test.err.f1422" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1423 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1423" 2> "$OUTPUT_DIR/test.err.f1423" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1424 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1424" 2> "$OUTPUT_DIR/test.err.f1424" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1425 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1425" 2> "$OUTPUT_DIR/test.err.f1425" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1426 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1426" 2> "$OUTPUT_DIR/test.err.f1426" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1427 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1427" 2> "$OUTPUT_DIR/test.err.f1427" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1428 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1428" 2> "$OUTPUT_DIR/test.err.f1428" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1429 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1429" 2> "$OUTPUT_DIR/test.err.f1429" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1430 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1430" 2> "$OUTPUT_DIR/test.err.f1430" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1431 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1431" 2> "$OUTPUT_DIR/test.err.f1431" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1432 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1432" 2> "$OUTPUT_DIR/test.err.f1432" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1433 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1433" 2> "$OUTPUT_DIR/test.err.f1433" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1434 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1434" 2> "$OUTPUT_DIR/test.err.f1434" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1435 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1435" 2> "$OUTPUT_DIR/test.err.f1435" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1436 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1436" 2> "$OUTPUT_DIR/test.err.f1436" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1437 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1437" 2> "$OUTPUT_DIR/test.err.f1437" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1438 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1438" 2> "$OUTPUT_DIR/test.err.f1438" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1439 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1439" 2> "$OUTPUT_DIR/test.err.f1439" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1440 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1440" 2> "$OUTPUT_DIR/test.err.f1440" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1441 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1441" 2> "$OUTPUT_DIR/test.err.f1441" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1442 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1442" 2> "$OUTPUT_DIR/test.err.f1442" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1443 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1443" 2> "$OUTPUT_DIR/test.err.f1443" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1444 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1444" 2> "$OUTPUT_DIR/test.err.f1444" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1445 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1445" 2> "$OUTPUT_DIR/test.err.f1445" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1446 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1446" 2> "$OUTPUT_DIR/test.err.f1446" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1447 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1447" 2> "$OUTPUT_DIR/test.err.f1447" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1448 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1448" 2> "$OUTPUT_DIR/test.err.f1448" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1449 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1449" 2> "$OUTPUT_DIR/test.err.f1449" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1450 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1450" 2> "$OUTPUT_DIR/test.err.f1450" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1451 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1451" 2> "$OUTPUT_DIR/test.err.f1451" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1452 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1452" 2> "$OUTPUT_DIR/test.err.f1452" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1453 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1453" 2> "$OUTPUT_DIR/test.err.f1453" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1454 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1454" 2> "$OUTPUT_DIR/test.err.f1454" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1455 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1455" 2> "$OUTPUT_DIR/test.err.f1455" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1456 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1456" 2> "$OUTPUT_DIR/test.err.f1456" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1457 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1457" 2> "$OUTPUT_DIR/test.err.f1457" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1458 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1458" 2> "$OUTPUT_DIR/test.err.f1458" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1459 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1459" 2> "$OUTPUT_DIR/test.err.f1459" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1460 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1460" 2> "$OUTPUT_DIR/test.err.f1460" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1461 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1461" 2> "$OUTPUT_DIR/test.err.f1461" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1462 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1462" 2> "$OUTPUT_DIR/test.err.f1462" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1463 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1463" 2> "$OUTPUT_DIR/test.err.f1463" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1464 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1464" 2> "$OUTPUT_DIR/test.err.f1464" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1465 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1465" 2> "$OUTPUT_DIR/test.err.f1465" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1466 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1466" 2> "$OUTPUT_DIR/test.err.f1466" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1467 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1467" 2> "$OUTPUT_DIR/test.err.f1467" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1468 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1468" 2> "$OUTPUT_DIR/test.err.f1468" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1469 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1469" 2> "$OUTPUT_DIR/test.err.f1469" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1470 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1470" 2> "$OUTPUT_DIR/test.err.f1470" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1471 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1471" 2> "$OUTPUT_DIR/test.err.f1471" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1472 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1472" 2> "$OUTPUT_DIR/test.err.f1472" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1473 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1473" 2> "$OUTPUT_DIR/test.err.f1473" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1474 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1474" 2> "$OUTPUT_DIR/test.err.f1474" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1475 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1475" 2> "$OUTPUT_DIR/test.err.f1475" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1476 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1476" 2> "$OUTPUT_DIR/test.err.f1476" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1477 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1477" 2> "$OUTPUT_DIR/test.err.f1477" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1478 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1478" 2> "$OUTPUT_DIR/test.err.f1478" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1479 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1479" 2> "$OUTPUT_DIR/test.err.f1479" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1480 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1480" 2> "$OUTPUT_DIR/test.err.f1480" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1481 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1481" 2> "$OUTPUT_DIR/test.err.f1481" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1482 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1482" 2> "$OUTPUT_DIR/test.err.f1482" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1483 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1483" 2> "$OUTPUT_DIR/test.err.f1483" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1484 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1484" 2> "$OUTPUT_DIR/test.err.f1484" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1485 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1485" 2> "$OUTPUT_DIR/test.err.f1485" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1486 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1486" 2> "$OUTPUT_DIR/test.err.f1486" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1487 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1487" 2> "$OUTPUT_DIR/test.err.f1487" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1488 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1488" 2> "$OUTPUT_DIR/test.err.f1488" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1489 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1489" 2> "$OUTPUT_DIR/test.err.f1489" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1490 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1490" 2> "$OUTPUT_DIR/test.err.f1490" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1491 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1491" 2> "$OUTPUT_DIR/test.err.f1491" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1492 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1492" 2> "$OUTPUT_DIR/test.err.f1492" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1493 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1493" 2> "$OUTPUT_DIR/test.err.f1493" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1494 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1494" 2> "$OUTPUT_DIR/test.err.f1494" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1495 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1495" 2> "$OUTPUT_DIR/test.err.f1495" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1496 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1496" 2> "$OUTPUT_DIR/test.err.f1496" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1497 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1497" 2> "$OUTPUT_DIR/test.err.f1497" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1498 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1498" 2> "$OUTPUT_DIR/test.err.f1498" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1499 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1499" 2> "$OUTPUT_DIR/test.err.f1499" &
sleep 1800
