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
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1600 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1600" 2> "$OUTPUT_DIR/test.err.f1600" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1601 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1601" 2> "$OUTPUT_DIR/test.err.f1601" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1602 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1602" 2> "$OUTPUT_DIR/test.err.f1602" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1603 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1603" 2> "$OUTPUT_DIR/test.err.f1603" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1604 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1604" 2> "$OUTPUT_DIR/test.err.f1604" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1605 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1605" 2> "$OUTPUT_DIR/test.err.f1605" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1606 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1606" 2> "$OUTPUT_DIR/test.err.f1606" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1607 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1607" 2> "$OUTPUT_DIR/test.err.f1607" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1608 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1608" 2> "$OUTPUT_DIR/test.err.f1608" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1609 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1609" 2> "$OUTPUT_DIR/test.err.f1609" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1610 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1610" 2> "$OUTPUT_DIR/test.err.f1610" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1611 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1611" 2> "$OUTPUT_DIR/test.err.f1611" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1612 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1612" 2> "$OUTPUT_DIR/test.err.f1612" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1613 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1613" 2> "$OUTPUT_DIR/test.err.f1613" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1614 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1614" 2> "$OUTPUT_DIR/test.err.f1614" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1615 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1615" 2> "$OUTPUT_DIR/test.err.f1615" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1616 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1616" 2> "$OUTPUT_DIR/test.err.f1616" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1617 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1617" 2> "$OUTPUT_DIR/test.err.f1617" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1618 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1618" 2> "$OUTPUT_DIR/test.err.f1618" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1619 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1619" 2> "$OUTPUT_DIR/test.err.f1619" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1620 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1620" 2> "$OUTPUT_DIR/test.err.f1620" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1621 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1621" 2> "$OUTPUT_DIR/test.err.f1621" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1622 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1622" 2> "$OUTPUT_DIR/test.err.f1622" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1623 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1623" 2> "$OUTPUT_DIR/test.err.f1623" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1624 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1624" 2> "$OUTPUT_DIR/test.err.f1624" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1625 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1625" 2> "$OUTPUT_DIR/test.err.f1625" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1626 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1626" 2> "$OUTPUT_DIR/test.err.f1626" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1627 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1627" 2> "$OUTPUT_DIR/test.err.f1627" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1628 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1628" 2> "$OUTPUT_DIR/test.err.f1628" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1629 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1629" 2> "$OUTPUT_DIR/test.err.f1629" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1630 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1630" 2> "$OUTPUT_DIR/test.err.f1630" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1631 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1631" 2> "$OUTPUT_DIR/test.err.f1631" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1632 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1632" 2> "$OUTPUT_DIR/test.err.f1632" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1633 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1633" 2> "$OUTPUT_DIR/test.err.f1633" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1634 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1634" 2> "$OUTPUT_DIR/test.err.f1634" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1635 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1635" 2> "$OUTPUT_DIR/test.err.f1635" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1636 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1636" 2> "$OUTPUT_DIR/test.err.f1636" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1637 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1637" 2> "$OUTPUT_DIR/test.err.f1637" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1638 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1638" 2> "$OUTPUT_DIR/test.err.f1638" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1639 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1639" 2> "$OUTPUT_DIR/test.err.f1639" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1640 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1640" 2> "$OUTPUT_DIR/test.err.f1640" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1641 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1641" 2> "$OUTPUT_DIR/test.err.f1641" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1642 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1642" 2> "$OUTPUT_DIR/test.err.f1642" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1643 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1643" 2> "$OUTPUT_DIR/test.err.f1643" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1644 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1644" 2> "$OUTPUT_DIR/test.err.f1644" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1645 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1645" 2> "$OUTPUT_DIR/test.err.f1645" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1646 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1646" 2> "$OUTPUT_DIR/test.err.f1646" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1647 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1647" 2> "$OUTPUT_DIR/test.err.f1647" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1648 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1648" 2> "$OUTPUT_DIR/test.err.f1648" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1649 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1649" 2> "$OUTPUT_DIR/test.err.f1649" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1650 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1650" 2> "$OUTPUT_DIR/test.err.f1650" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1651 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1651" 2> "$OUTPUT_DIR/test.err.f1651" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1652 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1652" 2> "$OUTPUT_DIR/test.err.f1652" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1653 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1653" 2> "$OUTPUT_DIR/test.err.f1653" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1654 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1654" 2> "$OUTPUT_DIR/test.err.f1654" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1655 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1655" 2> "$OUTPUT_DIR/test.err.f1655" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1656 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1656" 2> "$OUTPUT_DIR/test.err.f1656" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1657 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1657" 2> "$OUTPUT_DIR/test.err.f1657" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1658 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1658" 2> "$OUTPUT_DIR/test.err.f1658" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1659 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1659" 2> "$OUTPUT_DIR/test.err.f1659" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1660 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1660" 2> "$OUTPUT_DIR/test.err.f1660" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1661 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1661" 2> "$OUTPUT_DIR/test.err.f1661" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1662 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1662" 2> "$OUTPUT_DIR/test.err.f1662" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1663 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1663" 2> "$OUTPUT_DIR/test.err.f1663" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1664 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1664" 2> "$OUTPUT_DIR/test.err.f1664" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1665 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1665" 2> "$OUTPUT_DIR/test.err.f1665" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1666 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1666" 2> "$OUTPUT_DIR/test.err.f1666" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1667 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1667" 2> "$OUTPUT_DIR/test.err.f1667" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1668 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1668" 2> "$OUTPUT_DIR/test.err.f1668" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1669 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1669" 2> "$OUTPUT_DIR/test.err.f1669" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1670 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1670" 2> "$OUTPUT_DIR/test.err.f1670" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1671 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1671" 2> "$OUTPUT_DIR/test.err.f1671" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1672 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1672" 2> "$OUTPUT_DIR/test.err.f1672" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1673 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1673" 2> "$OUTPUT_DIR/test.err.f1673" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1674 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1674" 2> "$OUTPUT_DIR/test.err.f1674" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1675 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1675" 2> "$OUTPUT_DIR/test.err.f1675" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1676 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1676" 2> "$OUTPUT_DIR/test.err.f1676" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1677 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1677" 2> "$OUTPUT_DIR/test.err.f1677" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1678 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1678" 2> "$OUTPUT_DIR/test.err.f1678" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1679 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1679" 2> "$OUTPUT_DIR/test.err.f1679" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1680 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1680" 2> "$OUTPUT_DIR/test.err.f1680" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1681 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1681" 2> "$OUTPUT_DIR/test.err.f1681" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1682 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1682" 2> "$OUTPUT_DIR/test.err.f1682" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1683 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1683" 2> "$OUTPUT_DIR/test.err.f1683" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1684 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1684" 2> "$OUTPUT_DIR/test.err.f1684" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1685 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1685" 2> "$OUTPUT_DIR/test.err.f1685" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1686 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1686" 2> "$OUTPUT_DIR/test.err.f1686" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1687 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1687" 2> "$OUTPUT_DIR/test.err.f1687" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1688 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1688" 2> "$OUTPUT_DIR/test.err.f1688" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1689 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1689" 2> "$OUTPUT_DIR/test.err.f1689" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1690 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1690" 2> "$OUTPUT_DIR/test.err.f1690" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1691 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1691" 2> "$OUTPUT_DIR/test.err.f1691" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1692 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1692" 2> "$OUTPUT_DIR/test.err.f1692" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1693 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1693" 2> "$OUTPUT_DIR/test.err.f1693" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1694 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1694" 2> "$OUTPUT_DIR/test.err.f1694" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1695 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1695" 2> "$OUTPUT_DIR/test.err.f1695" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1696 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1696" 2> "$OUTPUT_DIR/test.err.f1696" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1697 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1697" 2> "$OUTPUT_DIR/test.err.f1697" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1698 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1698" 2> "$OUTPUT_DIR/test.err.f1698" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1699 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1699" 2> "$OUTPUT_DIR/test.err.f1699" &
sleep 1800
