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
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1200 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1200" 2> "$OUTPUT_DIR/test.err.f1200" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1201 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1201" 2> "$OUTPUT_DIR/test.err.f1201" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1202 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1202" 2> "$OUTPUT_DIR/test.err.f1202" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1203 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1203" 2> "$OUTPUT_DIR/test.err.f1203" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1204 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1204" 2> "$OUTPUT_DIR/test.err.f1204" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1205 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1205" 2> "$OUTPUT_DIR/test.err.f1205" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1206 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1206" 2> "$OUTPUT_DIR/test.err.f1206" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1207 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1207" 2> "$OUTPUT_DIR/test.err.f1207" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1208 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1208" 2> "$OUTPUT_DIR/test.err.f1208" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1209 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1209" 2> "$OUTPUT_DIR/test.err.f1209" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1210 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1210" 2> "$OUTPUT_DIR/test.err.f1210" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1211 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1211" 2> "$OUTPUT_DIR/test.err.f1211" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1212 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1212" 2> "$OUTPUT_DIR/test.err.f1212" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1213 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1213" 2> "$OUTPUT_DIR/test.err.f1213" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1214 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1214" 2> "$OUTPUT_DIR/test.err.f1214" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1215 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1215" 2> "$OUTPUT_DIR/test.err.f1215" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1216 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1216" 2> "$OUTPUT_DIR/test.err.f1216" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1217 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1217" 2> "$OUTPUT_DIR/test.err.f1217" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1218 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1218" 2> "$OUTPUT_DIR/test.err.f1218" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1219 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1219" 2> "$OUTPUT_DIR/test.err.f1219" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1220 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1220" 2> "$OUTPUT_DIR/test.err.f1220" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1221 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1221" 2> "$OUTPUT_DIR/test.err.f1221" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1222 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1222" 2> "$OUTPUT_DIR/test.err.f1222" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1223 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1223" 2> "$OUTPUT_DIR/test.err.f1223" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1224 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1224" 2> "$OUTPUT_DIR/test.err.f1224" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1225 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1225" 2> "$OUTPUT_DIR/test.err.f1225" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1226 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1226" 2> "$OUTPUT_DIR/test.err.f1226" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1227 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1227" 2> "$OUTPUT_DIR/test.err.f1227" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1228 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1228" 2> "$OUTPUT_DIR/test.err.f1228" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1229 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1229" 2> "$OUTPUT_DIR/test.err.f1229" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1230 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1230" 2> "$OUTPUT_DIR/test.err.f1230" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1231 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1231" 2> "$OUTPUT_DIR/test.err.f1231" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1232 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1232" 2> "$OUTPUT_DIR/test.err.f1232" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1233 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1233" 2> "$OUTPUT_DIR/test.err.f1233" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1234 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1234" 2> "$OUTPUT_DIR/test.err.f1234" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1235 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1235" 2> "$OUTPUT_DIR/test.err.f1235" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1236 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1236" 2> "$OUTPUT_DIR/test.err.f1236" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1237 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1237" 2> "$OUTPUT_DIR/test.err.f1237" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1238 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1238" 2> "$OUTPUT_DIR/test.err.f1238" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1239 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1239" 2> "$OUTPUT_DIR/test.err.f1239" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1240 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1240" 2> "$OUTPUT_DIR/test.err.f1240" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1241 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1241" 2> "$OUTPUT_DIR/test.err.f1241" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1242 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1242" 2> "$OUTPUT_DIR/test.err.f1242" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1243 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1243" 2> "$OUTPUT_DIR/test.err.f1243" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1244 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1244" 2> "$OUTPUT_DIR/test.err.f1244" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1245 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1245" 2> "$OUTPUT_DIR/test.err.f1245" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1246 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1246" 2> "$OUTPUT_DIR/test.err.f1246" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1247 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1247" 2> "$OUTPUT_DIR/test.err.f1247" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1248 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1248" 2> "$OUTPUT_DIR/test.err.f1248" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1249 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1249" 2> "$OUTPUT_DIR/test.err.f1249" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1250 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1250" 2> "$OUTPUT_DIR/test.err.f1250" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1251 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1251" 2> "$OUTPUT_DIR/test.err.f1251" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1252 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1252" 2> "$OUTPUT_DIR/test.err.f1252" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1253 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1253" 2> "$OUTPUT_DIR/test.err.f1253" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1254 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1254" 2> "$OUTPUT_DIR/test.err.f1254" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1255 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1255" 2> "$OUTPUT_DIR/test.err.f1255" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1256 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1256" 2> "$OUTPUT_DIR/test.err.f1256" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1257 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1257" 2> "$OUTPUT_DIR/test.err.f1257" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1258 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1258" 2> "$OUTPUT_DIR/test.err.f1258" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1259 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1259" 2> "$OUTPUT_DIR/test.err.f1259" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1260 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1260" 2> "$OUTPUT_DIR/test.err.f1260" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1261 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1261" 2> "$OUTPUT_DIR/test.err.f1261" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1262 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1262" 2> "$OUTPUT_DIR/test.err.f1262" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1263 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1263" 2> "$OUTPUT_DIR/test.err.f1263" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1264 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1264" 2> "$OUTPUT_DIR/test.err.f1264" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1265 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1265" 2> "$OUTPUT_DIR/test.err.f1265" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1266 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1266" 2> "$OUTPUT_DIR/test.err.f1266" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1267 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1267" 2> "$OUTPUT_DIR/test.err.f1267" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1268 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1268" 2> "$OUTPUT_DIR/test.err.f1268" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1269 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1269" 2> "$OUTPUT_DIR/test.err.f1269" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1270 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1270" 2> "$OUTPUT_DIR/test.err.f1270" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1271 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1271" 2> "$OUTPUT_DIR/test.err.f1271" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1272 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1272" 2> "$OUTPUT_DIR/test.err.f1272" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1273 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1273" 2> "$OUTPUT_DIR/test.err.f1273" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1274 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1274" 2> "$OUTPUT_DIR/test.err.f1274" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1275 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1275" 2> "$OUTPUT_DIR/test.err.f1275" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1276 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1276" 2> "$OUTPUT_DIR/test.err.f1276" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1277 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1277" 2> "$OUTPUT_DIR/test.err.f1277" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1278 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1278" 2> "$OUTPUT_DIR/test.err.f1278" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1279 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1279" 2> "$OUTPUT_DIR/test.err.f1279" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1280 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1280" 2> "$OUTPUT_DIR/test.err.f1280" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1281 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1281" 2> "$OUTPUT_DIR/test.err.f1281" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1282 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1282" 2> "$OUTPUT_DIR/test.err.f1282" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1283 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1283" 2> "$OUTPUT_DIR/test.err.f1283" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1284 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1284" 2> "$OUTPUT_DIR/test.err.f1284" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1285 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1285" 2> "$OUTPUT_DIR/test.err.f1285" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1286 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1286" 2> "$OUTPUT_DIR/test.err.f1286" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1287 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1287" 2> "$OUTPUT_DIR/test.err.f1287" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1288 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1288" 2> "$OUTPUT_DIR/test.err.f1288" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1289 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1289" 2> "$OUTPUT_DIR/test.err.f1289" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1290 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1290" 2> "$OUTPUT_DIR/test.err.f1290" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1291 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1291" 2> "$OUTPUT_DIR/test.err.f1291" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1292 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1292" 2> "$OUTPUT_DIR/test.err.f1292" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1293 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1293" 2> "$OUTPUT_DIR/test.err.f1293" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1294 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1294" 2> "$OUTPUT_DIR/test.err.f1294" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1295 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1295" 2> "$OUTPUT_DIR/test.err.f1295" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1296 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1296" 2> "$OUTPUT_DIR/test.err.f1296" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1297 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1297" 2> "$OUTPUT_DIR/test.err.f1297" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1298 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1298" 2> "$OUTPUT_DIR/test.err.f1298" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1299 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1299" 2> "$OUTPUT_DIR/test.err.f1299" &
sleep 1800
