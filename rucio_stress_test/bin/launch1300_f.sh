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
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1300 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1300" 2> "$OUTPUT_DIR/test.err.f1300" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1301 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1301" 2> "$OUTPUT_DIR/test.err.f1301" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1302 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1302" 2> "$OUTPUT_DIR/test.err.f1302" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1303 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1303" 2> "$OUTPUT_DIR/test.err.f1303" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1304 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1304" 2> "$OUTPUT_DIR/test.err.f1304" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1305 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1305" 2> "$OUTPUT_DIR/test.err.f1305" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1306 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1306" 2> "$OUTPUT_DIR/test.err.f1306" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1307 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1307" 2> "$OUTPUT_DIR/test.err.f1307" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1308 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1308" 2> "$OUTPUT_DIR/test.err.f1308" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1309 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1309" 2> "$OUTPUT_DIR/test.err.f1309" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1310 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1310" 2> "$OUTPUT_DIR/test.err.f1310" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1311 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1311" 2> "$OUTPUT_DIR/test.err.f1311" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1312 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1312" 2> "$OUTPUT_DIR/test.err.f1312" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1313 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1313" 2> "$OUTPUT_DIR/test.err.f1313" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1314 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1314" 2> "$OUTPUT_DIR/test.err.f1314" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1315 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1315" 2> "$OUTPUT_DIR/test.err.f1315" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1316 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1316" 2> "$OUTPUT_DIR/test.err.f1316" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1317 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1317" 2> "$OUTPUT_DIR/test.err.f1317" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1318 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1318" 2> "$OUTPUT_DIR/test.err.f1318" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1319 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1319" 2> "$OUTPUT_DIR/test.err.f1319" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1320 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1320" 2> "$OUTPUT_DIR/test.err.f1320" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1321 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1321" 2> "$OUTPUT_DIR/test.err.f1321" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1322 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1322" 2> "$OUTPUT_DIR/test.err.f1322" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1323 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1323" 2> "$OUTPUT_DIR/test.err.f1323" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1324 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1324" 2> "$OUTPUT_DIR/test.err.f1324" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1325 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1325" 2> "$OUTPUT_DIR/test.err.f1325" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1326 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1326" 2> "$OUTPUT_DIR/test.err.f1326" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1327 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1327" 2> "$OUTPUT_DIR/test.err.f1327" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1328 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1328" 2> "$OUTPUT_DIR/test.err.f1328" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1329 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1329" 2> "$OUTPUT_DIR/test.err.f1329" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1330 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1330" 2> "$OUTPUT_DIR/test.err.f1330" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1331 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1331" 2> "$OUTPUT_DIR/test.err.f1331" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1332 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1332" 2> "$OUTPUT_DIR/test.err.f1332" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1333 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1333" 2> "$OUTPUT_DIR/test.err.f1333" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1334 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1334" 2> "$OUTPUT_DIR/test.err.f1334" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1335 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1335" 2> "$OUTPUT_DIR/test.err.f1335" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1336 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1336" 2> "$OUTPUT_DIR/test.err.f1336" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1337 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1337" 2> "$OUTPUT_DIR/test.err.f1337" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1338 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1338" 2> "$OUTPUT_DIR/test.err.f1338" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1339 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1339" 2> "$OUTPUT_DIR/test.err.f1339" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1340 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1340" 2> "$OUTPUT_DIR/test.err.f1340" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1341 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1341" 2> "$OUTPUT_DIR/test.err.f1341" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1342 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1342" 2> "$OUTPUT_DIR/test.err.f1342" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1343 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1343" 2> "$OUTPUT_DIR/test.err.f1343" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1344 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1344" 2> "$OUTPUT_DIR/test.err.f1344" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1345 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1345" 2> "$OUTPUT_DIR/test.err.f1345" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1346 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1346" 2> "$OUTPUT_DIR/test.err.f1346" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1347 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1347" 2> "$OUTPUT_DIR/test.err.f1347" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1348 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1348" 2> "$OUTPUT_DIR/test.err.f1348" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1349 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1349" 2> "$OUTPUT_DIR/test.err.f1349" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1350 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1350" 2> "$OUTPUT_DIR/test.err.f1350" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1351 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1351" 2> "$OUTPUT_DIR/test.err.f1351" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1352 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1352" 2> "$OUTPUT_DIR/test.err.f1352" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1353 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1353" 2> "$OUTPUT_DIR/test.err.f1353" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1354 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1354" 2> "$OUTPUT_DIR/test.err.f1354" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1355 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1355" 2> "$OUTPUT_DIR/test.err.f1355" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1356 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1356" 2> "$OUTPUT_DIR/test.err.f1356" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1357 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1357" 2> "$OUTPUT_DIR/test.err.f1357" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1358 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1358" 2> "$OUTPUT_DIR/test.err.f1358" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1359 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1359" 2> "$OUTPUT_DIR/test.err.f1359" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1360 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1360" 2> "$OUTPUT_DIR/test.err.f1360" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1361 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1361" 2> "$OUTPUT_DIR/test.err.f1361" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1362 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1362" 2> "$OUTPUT_DIR/test.err.f1362" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1363 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1363" 2> "$OUTPUT_DIR/test.err.f1363" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1364 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1364" 2> "$OUTPUT_DIR/test.err.f1364" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1365 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1365" 2> "$OUTPUT_DIR/test.err.f1365" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1366 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1366" 2> "$OUTPUT_DIR/test.err.f1366" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1367 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1367" 2> "$OUTPUT_DIR/test.err.f1367" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1368 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1368" 2> "$OUTPUT_DIR/test.err.f1368" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1369 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1369" 2> "$OUTPUT_DIR/test.err.f1369" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1370 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1370" 2> "$OUTPUT_DIR/test.err.f1370" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1371 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1371" 2> "$OUTPUT_DIR/test.err.f1371" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1372 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1372" 2> "$OUTPUT_DIR/test.err.f1372" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1373 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1373" 2> "$OUTPUT_DIR/test.err.f1373" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1374 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1374" 2> "$OUTPUT_DIR/test.err.f1374" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1375 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1375" 2> "$OUTPUT_DIR/test.err.f1375" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1376 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1376" 2> "$OUTPUT_DIR/test.err.f1376" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1377 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1377" 2> "$OUTPUT_DIR/test.err.f1377" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1378 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1378" 2> "$OUTPUT_DIR/test.err.f1378" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1379 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1379" 2> "$OUTPUT_DIR/test.err.f1379" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1380 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1380" 2> "$OUTPUT_DIR/test.err.f1380" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1381 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1381" 2> "$OUTPUT_DIR/test.err.f1381" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1382 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1382" 2> "$OUTPUT_DIR/test.err.f1382" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1383 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1383" 2> "$OUTPUT_DIR/test.err.f1383" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1384 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1384" 2> "$OUTPUT_DIR/test.err.f1384" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1385 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1385" 2> "$OUTPUT_DIR/test.err.f1385" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1386 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1386" 2> "$OUTPUT_DIR/test.err.f1386" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1387 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1387" 2> "$OUTPUT_DIR/test.err.f1387" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1388 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1388" 2> "$OUTPUT_DIR/test.err.f1388" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1389 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1389" 2> "$OUTPUT_DIR/test.err.f1389" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1390 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1390" 2> "$OUTPUT_DIR/test.err.f1390" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1391 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1391" 2> "$OUTPUT_DIR/test.err.f1391" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1392 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1392" 2> "$OUTPUT_DIR/test.err.f1392" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1393 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1393" 2> "$OUTPUT_DIR/test.err.f1393" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1394 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1394" 2> "$OUTPUT_DIR/test.err.f1394" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1395 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1395" 2> "$OUTPUT_DIR/test.err.f1395" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1396 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1396" 2> "$OUTPUT_DIR/test.err.f1396" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1397 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1397" 2> "$OUTPUT_DIR/test.err.f1397" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1398 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1398" 2> "$OUTPUT_DIR/test.err.f1398" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1399 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1399" 2> "$OUTPUT_DIR/test.err.f1399" &
sleep 1800
