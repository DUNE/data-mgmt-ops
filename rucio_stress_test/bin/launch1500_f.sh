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
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1500 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1500" 2> "$OUTPUT_DIR/test.err.f1500" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1501 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1501" 2> "$OUTPUT_DIR/test.err.f1501" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1502 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1502" 2> "$OUTPUT_DIR/test.err.f1502" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1503 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1503" 2> "$OUTPUT_DIR/test.err.f1503" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1504 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1504" 2> "$OUTPUT_DIR/test.err.f1504" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1505 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1505" 2> "$OUTPUT_DIR/test.err.f1505" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1506 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1506" 2> "$OUTPUT_DIR/test.err.f1506" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1507 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1507" 2> "$OUTPUT_DIR/test.err.f1507" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1508 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1508" 2> "$OUTPUT_DIR/test.err.f1508" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1509 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1509" 2> "$OUTPUT_DIR/test.err.f1509" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1510 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1510" 2> "$OUTPUT_DIR/test.err.f1510" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1511 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1511" 2> "$OUTPUT_DIR/test.err.f1511" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1512 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1512" 2> "$OUTPUT_DIR/test.err.f1512" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1513 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1513" 2> "$OUTPUT_DIR/test.err.f1513" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1514 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1514" 2> "$OUTPUT_DIR/test.err.f1514" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1515 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1515" 2> "$OUTPUT_DIR/test.err.f1515" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1516 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1516" 2> "$OUTPUT_DIR/test.err.f1516" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1517 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1517" 2> "$OUTPUT_DIR/test.err.f1517" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1518 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1518" 2> "$OUTPUT_DIR/test.err.f1518" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1519 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1519" 2> "$OUTPUT_DIR/test.err.f1519" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1520 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1520" 2> "$OUTPUT_DIR/test.err.f1520" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1521 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1521" 2> "$OUTPUT_DIR/test.err.f1521" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1522 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1522" 2> "$OUTPUT_DIR/test.err.f1522" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1523 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1523" 2> "$OUTPUT_DIR/test.err.f1523" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1524 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1524" 2> "$OUTPUT_DIR/test.err.f1524" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1525 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1525" 2> "$OUTPUT_DIR/test.err.f1525" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1526 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1526" 2> "$OUTPUT_DIR/test.err.f1526" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1527 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1527" 2> "$OUTPUT_DIR/test.err.f1527" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1528 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1528" 2> "$OUTPUT_DIR/test.err.f1528" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1529 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1529" 2> "$OUTPUT_DIR/test.err.f1529" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1530 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1530" 2> "$OUTPUT_DIR/test.err.f1530" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1531 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1531" 2> "$OUTPUT_DIR/test.err.f1531" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1532 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1532" 2> "$OUTPUT_DIR/test.err.f1532" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1533 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1533" 2> "$OUTPUT_DIR/test.err.f1533" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1534 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1534" 2> "$OUTPUT_DIR/test.err.f1534" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1535 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1535" 2> "$OUTPUT_DIR/test.err.f1535" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1536 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1536" 2> "$OUTPUT_DIR/test.err.f1536" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1537 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1537" 2> "$OUTPUT_DIR/test.err.f1537" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1538 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1538" 2> "$OUTPUT_DIR/test.err.f1538" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1539 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1539" 2> "$OUTPUT_DIR/test.err.f1539" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1540 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1540" 2> "$OUTPUT_DIR/test.err.f1540" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1541 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1541" 2> "$OUTPUT_DIR/test.err.f1541" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1542 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1542" 2> "$OUTPUT_DIR/test.err.f1542" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1543 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1543" 2> "$OUTPUT_DIR/test.err.f1543" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1544 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1544" 2> "$OUTPUT_DIR/test.err.f1544" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1545 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1545" 2> "$OUTPUT_DIR/test.err.f1545" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1546 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1546" 2> "$OUTPUT_DIR/test.err.f1546" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1547 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1547" 2> "$OUTPUT_DIR/test.err.f1547" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1548 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1548" 2> "$OUTPUT_DIR/test.err.f1548" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1549 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1549" 2> "$OUTPUT_DIR/test.err.f1549" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1550 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1550" 2> "$OUTPUT_DIR/test.err.f1550" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1551 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1551" 2> "$OUTPUT_DIR/test.err.f1551" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1552 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1552" 2> "$OUTPUT_DIR/test.err.f1552" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1553 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1553" 2> "$OUTPUT_DIR/test.err.f1553" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1554 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1554" 2> "$OUTPUT_DIR/test.err.f1554" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1555 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1555" 2> "$OUTPUT_DIR/test.err.f1555" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1556 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1556" 2> "$OUTPUT_DIR/test.err.f1556" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1557 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1557" 2> "$OUTPUT_DIR/test.err.f1557" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1558 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1558" 2> "$OUTPUT_DIR/test.err.f1558" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1559 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1559" 2> "$OUTPUT_DIR/test.err.f1559" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1560 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1560" 2> "$OUTPUT_DIR/test.err.f1560" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1561 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1561" 2> "$OUTPUT_DIR/test.err.f1561" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1562 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1562" 2> "$OUTPUT_DIR/test.err.f1562" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1563 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1563" 2> "$OUTPUT_DIR/test.err.f1563" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1564 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1564" 2> "$OUTPUT_DIR/test.err.f1564" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1565 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1565" 2> "$OUTPUT_DIR/test.err.f1565" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1566 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1566" 2> "$OUTPUT_DIR/test.err.f1566" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1567 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1567" 2> "$OUTPUT_DIR/test.err.f1567" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1568 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1568" 2> "$OUTPUT_DIR/test.err.f1568" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1569 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1569" 2> "$OUTPUT_DIR/test.err.f1569" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1570 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1570" 2> "$OUTPUT_DIR/test.err.f1570" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1571 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1571" 2> "$OUTPUT_DIR/test.err.f1571" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1572 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1572" 2> "$OUTPUT_DIR/test.err.f1572" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1573 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1573" 2> "$OUTPUT_DIR/test.err.f1573" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1574 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1574" 2> "$OUTPUT_DIR/test.err.f1574" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1575 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1575" 2> "$OUTPUT_DIR/test.err.f1575" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1576 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1576" 2> "$OUTPUT_DIR/test.err.f1576" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1577 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1577" 2> "$OUTPUT_DIR/test.err.f1577" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1578 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1578" 2> "$OUTPUT_DIR/test.err.f1578" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1579 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1579" 2> "$OUTPUT_DIR/test.err.f1579" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1580 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1580" 2> "$OUTPUT_DIR/test.err.f1580" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1581 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1581" 2> "$OUTPUT_DIR/test.err.f1581" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1582 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1582" 2> "$OUTPUT_DIR/test.err.f1582" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1583 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1583" 2> "$OUTPUT_DIR/test.err.f1583" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1584 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1584" 2> "$OUTPUT_DIR/test.err.f1584" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1585 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1585" 2> "$OUTPUT_DIR/test.err.f1585" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1586 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1586" 2> "$OUTPUT_DIR/test.err.f1586" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1587 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1587" 2> "$OUTPUT_DIR/test.err.f1587" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1588 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1588" 2> "$OUTPUT_DIR/test.err.f1588" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1589 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1589" 2> "$OUTPUT_DIR/test.err.f1589" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1590 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1590" 2> "$OUTPUT_DIR/test.err.f1590" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1591 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1591" 2> "$OUTPUT_DIR/test.err.f1591" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1592 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1592" 2> "$OUTPUT_DIR/test.err.f1592" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1593 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1593" 2> "$OUTPUT_DIR/test.err.f1593" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1594 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1594" 2> "$OUTPUT_DIR/test.err.f1594" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1595 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1595" 2> "$OUTPUT_DIR/test.err.f1595" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1596 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1596" 2> "$OUTPUT_DIR/test.err.f1596" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1597 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1597" 2> "$OUTPUT_DIR/test.err.f1597" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1598 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1598" 2> "$OUTPUT_DIR/test.err.f1598" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1599 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1599" 2> "$OUTPUT_DIR/test.err.f1599" &
sleep 1800
