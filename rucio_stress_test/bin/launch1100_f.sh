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
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1100 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1100" 2> "$OUTPUT_DIR/test.err.f1100" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1101 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1101" 2> "$OUTPUT_DIR/test.err.f1101" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1102 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1102" 2> "$OUTPUT_DIR/test.err.f1102" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1103 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1103" 2> "$OUTPUT_DIR/test.err.f1103" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1104 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1104" 2> "$OUTPUT_DIR/test.err.f1104" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1105 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1105" 2> "$OUTPUT_DIR/test.err.f1105" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1106 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1106" 2> "$OUTPUT_DIR/test.err.f1106" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1107 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1107" 2> "$OUTPUT_DIR/test.err.f1107" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1108 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1108" 2> "$OUTPUT_DIR/test.err.f1108" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1109 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1109" 2> "$OUTPUT_DIR/test.err.f1109" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1110 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1110" 2> "$OUTPUT_DIR/test.err.f1110" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1111 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1111" 2> "$OUTPUT_DIR/test.err.f1111" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1112 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1112" 2> "$OUTPUT_DIR/test.err.f1112" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1113 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1113" 2> "$OUTPUT_DIR/test.err.f1113" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1114 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1114" 2> "$OUTPUT_DIR/test.err.f1114" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1115 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1115" 2> "$OUTPUT_DIR/test.err.f1115" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1116 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1116" 2> "$OUTPUT_DIR/test.err.f1116" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1117 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1117" 2> "$OUTPUT_DIR/test.err.f1117" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1118 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1118" 2> "$OUTPUT_DIR/test.err.f1118" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1119 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1119" 2> "$OUTPUT_DIR/test.err.f1119" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1120 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1120" 2> "$OUTPUT_DIR/test.err.f1120" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1121 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1121" 2> "$OUTPUT_DIR/test.err.f1121" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1122 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1122" 2> "$OUTPUT_DIR/test.err.f1122" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1123 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1123" 2> "$OUTPUT_DIR/test.err.f1123" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1124 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1124" 2> "$OUTPUT_DIR/test.err.f1124" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1125 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1125" 2> "$OUTPUT_DIR/test.err.f1125" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1126 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1126" 2> "$OUTPUT_DIR/test.err.f1126" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1127 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1127" 2> "$OUTPUT_DIR/test.err.f1127" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1128 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1128" 2> "$OUTPUT_DIR/test.err.f1128" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1129 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1129" 2> "$OUTPUT_DIR/test.err.f1129" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1130 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1130" 2> "$OUTPUT_DIR/test.err.f1130" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1131 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1131" 2> "$OUTPUT_DIR/test.err.f1131" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1132 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1132" 2> "$OUTPUT_DIR/test.err.f1132" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1133 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1133" 2> "$OUTPUT_DIR/test.err.f1133" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1134 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1134" 2> "$OUTPUT_DIR/test.err.f1134" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1135 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1135" 2> "$OUTPUT_DIR/test.err.f1135" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1136 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1136" 2> "$OUTPUT_DIR/test.err.f1136" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1137 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1137" 2> "$OUTPUT_DIR/test.err.f1137" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1138 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1138" 2> "$OUTPUT_DIR/test.err.f1138" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1139 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1139" 2> "$OUTPUT_DIR/test.err.f1139" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1140 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1140" 2> "$OUTPUT_DIR/test.err.f1140" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1141 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1141" 2> "$OUTPUT_DIR/test.err.f1141" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1142 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1142" 2> "$OUTPUT_DIR/test.err.f1142" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1143 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1143" 2> "$OUTPUT_DIR/test.err.f1143" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1144 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1144" 2> "$OUTPUT_DIR/test.err.f1144" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1145 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1145" 2> "$OUTPUT_DIR/test.err.f1145" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1146 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1146" 2> "$OUTPUT_DIR/test.err.f1146" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1147 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1147" 2> "$OUTPUT_DIR/test.err.f1147" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1148 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1148" 2> "$OUTPUT_DIR/test.err.f1148" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1149 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1149" 2> "$OUTPUT_DIR/test.err.f1149" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1150 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1150" 2> "$OUTPUT_DIR/test.err.f1150" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1151 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1151" 2> "$OUTPUT_DIR/test.err.f1151" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1152 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1152" 2> "$OUTPUT_DIR/test.err.f1152" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1153 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1153" 2> "$OUTPUT_DIR/test.err.f1153" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1154 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1154" 2> "$OUTPUT_DIR/test.err.f1154" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1155 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1155" 2> "$OUTPUT_DIR/test.err.f1155" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1156 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1156" 2> "$OUTPUT_DIR/test.err.f1156" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1157 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1157" 2> "$OUTPUT_DIR/test.err.f1157" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1158 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1158" 2> "$OUTPUT_DIR/test.err.f1158" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1159 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1159" 2> "$OUTPUT_DIR/test.err.f1159" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1160 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1160" 2> "$OUTPUT_DIR/test.err.f1160" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1161 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1161" 2> "$OUTPUT_DIR/test.err.f1161" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1162 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1162" 2> "$OUTPUT_DIR/test.err.f1162" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1163 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1163" 2> "$OUTPUT_DIR/test.err.f1163" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1164 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1164" 2> "$OUTPUT_DIR/test.err.f1164" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1165 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1165" 2> "$OUTPUT_DIR/test.err.f1165" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1166 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1166" 2> "$OUTPUT_DIR/test.err.f1166" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1167 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1167" 2> "$OUTPUT_DIR/test.err.f1167" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1168 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1168" 2> "$OUTPUT_DIR/test.err.f1168" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1169 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1169" 2> "$OUTPUT_DIR/test.err.f1169" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1170 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1170" 2> "$OUTPUT_DIR/test.err.f1170" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1171 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1171" 2> "$OUTPUT_DIR/test.err.f1171" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1172 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1172" 2> "$OUTPUT_DIR/test.err.f1172" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1173 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1173" 2> "$OUTPUT_DIR/test.err.f1173" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1174 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1174" 2> "$OUTPUT_DIR/test.err.f1174" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1175 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1175" 2> "$OUTPUT_DIR/test.err.f1175" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1176 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1176" 2> "$OUTPUT_DIR/test.err.f1176" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1177 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1177" 2> "$OUTPUT_DIR/test.err.f1177" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1178 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1178" 2> "$OUTPUT_DIR/test.err.f1178" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1179 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1179" 2> "$OUTPUT_DIR/test.err.f1179" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1180 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1180" 2> "$OUTPUT_DIR/test.err.f1180" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1181 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1181" 2> "$OUTPUT_DIR/test.err.f1181" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1182 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1182" 2> "$OUTPUT_DIR/test.err.f1182" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1183 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1183" 2> "$OUTPUT_DIR/test.err.f1183" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1184 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1184" 2> "$OUTPUT_DIR/test.err.f1184" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1185 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1185" 2> "$OUTPUT_DIR/test.err.f1185" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1186 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1186" 2> "$OUTPUT_DIR/test.err.f1186" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1187 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1187" 2> "$OUTPUT_DIR/test.err.f1187" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1188 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1188" 2> "$OUTPUT_DIR/test.err.f1188" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1189 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1189" 2> "$OUTPUT_DIR/test.err.f1189" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1190 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1190" 2> "$OUTPUT_DIR/test.err.f1190" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1191 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1191" 2> "$OUTPUT_DIR/test.err.f1191" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1192 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1192" 2> "$OUTPUT_DIR/test.err.f1192" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1193 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1193" 2> "$OUTPUT_DIR/test.err.f1193" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1194 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1194" 2> "$OUTPUT_DIR/test.err.f1194" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1195 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1195" 2> "$OUTPUT_DIR/test.err.f1195" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1196 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1196" 2> "$OUTPUT_DIR/test.err.f1196" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1197 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1197" 2> "$OUTPUT_DIR/test.err.f1197" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1198 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1198" 2> "$OUTPUT_DIR/test.err.f1198" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1199 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1199" 2> "$OUTPUT_DIR/test.err.f1199" &
sleep 1800
