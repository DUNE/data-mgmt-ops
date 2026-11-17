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
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1000 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1000" 2> "$OUTPUT_DIR/test.err.f1000" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1001 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1001" 2> "$OUTPUT_DIR/test.err.f1001" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1002 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1002" 2> "$OUTPUT_DIR/test.err.f1002" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1003 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1003" 2> "$OUTPUT_DIR/test.err.f1003" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1004 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1004" 2> "$OUTPUT_DIR/test.err.f1004" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1005 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1005" 2> "$OUTPUT_DIR/test.err.f1005" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1006 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1006" 2> "$OUTPUT_DIR/test.err.f1006" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1007 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1007" 2> "$OUTPUT_DIR/test.err.f1007" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1008 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1008" 2> "$OUTPUT_DIR/test.err.f1008" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1009 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1009" 2> "$OUTPUT_DIR/test.err.f1009" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1010 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1010" 2> "$OUTPUT_DIR/test.err.f1010" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1011 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1011" 2> "$OUTPUT_DIR/test.err.f1011" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1012 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1012" 2> "$OUTPUT_DIR/test.err.f1012" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1013 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1013" 2> "$OUTPUT_DIR/test.err.f1013" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1014 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1014" 2> "$OUTPUT_DIR/test.err.f1014" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1015 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1015" 2> "$OUTPUT_DIR/test.err.f1015" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1016 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1016" 2> "$OUTPUT_DIR/test.err.f1016" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1017 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1017" 2> "$OUTPUT_DIR/test.err.f1017" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1018 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1018" 2> "$OUTPUT_DIR/test.err.f1018" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1019 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1019" 2> "$OUTPUT_DIR/test.err.f1019" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1020 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1020" 2> "$OUTPUT_DIR/test.err.f1020" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1021 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1021" 2> "$OUTPUT_DIR/test.err.f1021" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1022 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1022" 2> "$OUTPUT_DIR/test.err.f1022" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1023 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1023" 2> "$OUTPUT_DIR/test.err.f1023" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1024 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1024" 2> "$OUTPUT_DIR/test.err.f1024" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1025 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1025" 2> "$OUTPUT_DIR/test.err.f1025" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1026 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1026" 2> "$OUTPUT_DIR/test.err.f1026" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1027 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1027" 2> "$OUTPUT_DIR/test.err.f1027" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1028 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1028" 2> "$OUTPUT_DIR/test.err.f1028" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1029 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1029" 2> "$OUTPUT_DIR/test.err.f1029" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1030 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1030" 2> "$OUTPUT_DIR/test.err.f1030" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1031 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1031" 2> "$OUTPUT_DIR/test.err.f1031" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1032 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1032" 2> "$OUTPUT_DIR/test.err.f1032" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1033 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1033" 2> "$OUTPUT_DIR/test.err.f1033" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1034 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1034" 2> "$OUTPUT_DIR/test.err.f1034" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1035 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1035" 2> "$OUTPUT_DIR/test.err.f1035" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1036 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1036" 2> "$OUTPUT_DIR/test.err.f1036" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1037 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1037" 2> "$OUTPUT_DIR/test.err.f1037" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1038 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1038" 2> "$OUTPUT_DIR/test.err.f1038" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1039 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1039" 2> "$OUTPUT_DIR/test.err.f1039" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1040 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1040" 2> "$OUTPUT_DIR/test.err.f1040" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1041 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1041" 2> "$OUTPUT_DIR/test.err.f1041" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1042 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1042" 2> "$OUTPUT_DIR/test.err.f1042" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1043 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1043" 2> "$OUTPUT_DIR/test.err.f1043" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1044 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1044" 2> "$OUTPUT_DIR/test.err.f1044" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1045 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1045" 2> "$OUTPUT_DIR/test.err.f1045" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1046 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1046" 2> "$OUTPUT_DIR/test.err.f1046" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1047 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1047" 2> "$OUTPUT_DIR/test.err.f1047" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1048 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1048" 2> "$OUTPUT_DIR/test.err.f1048" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1049 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1049" 2> "$OUTPUT_DIR/test.err.f1049" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1050 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1050" 2> "$OUTPUT_DIR/test.err.f1050" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1051 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1051" 2> "$OUTPUT_DIR/test.err.f1051" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1052 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1052" 2> "$OUTPUT_DIR/test.err.f1052" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1053 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1053" 2> "$OUTPUT_DIR/test.err.f1053" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1054 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1054" 2> "$OUTPUT_DIR/test.err.f1054" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1055 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1055" 2> "$OUTPUT_DIR/test.err.f1055" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1056 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1056" 2> "$OUTPUT_DIR/test.err.f1056" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1057 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1057" 2> "$OUTPUT_DIR/test.err.f1057" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1058 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1058" 2> "$OUTPUT_DIR/test.err.f1058" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1059 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1059" 2> "$OUTPUT_DIR/test.err.f1059" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1060 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1060" 2> "$OUTPUT_DIR/test.err.f1060" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1061 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1061" 2> "$OUTPUT_DIR/test.err.f1061" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1062 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1062" 2> "$OUTPUT_DIR/test.err.f1062" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1063 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1063" 2> "$OUTPUT_DIR/test.err.f1063" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1064 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1064" 2> "$OUTPUT_DIR/test.err.f1064" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1065 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1065" 2> "$OUTPUT_DIR/test.err.f1065" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1066 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1066" 2> "$OUTPUT_DIR/test.err.f1066" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1067 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1067" 2> "$OUTPUT_DIR/test.err.f1067" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1068 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1068" 2> "$OUTPUT_DIR/test.err.f1068" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1069 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1069" 2> "$OUTPUT_DIR/test.err.f1069" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1070 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1070" 2> "$OUTPUT_DIR/test.err.f1070" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1071 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1071" 2> "$OUTPUT_DIR/test.err.f1071" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1072 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1072" 2> "$OUTPUT_DIR/test.err.f1072" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1073 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1073" 2> "$OUTPUT_DIR/test.err.f1073" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1074 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1074" 2> "$OUTPUT_DIR/test.err.f1074" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1075 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1075" 2> "$OUTPUT_DIR/test.err.f1075" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1076 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1076" 2> "$OUTPUT_DIR/test.err.f1076" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1077 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1077" 2> "$OUTPUT_DIR/test.err.f1077" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1078 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1078" 2> "$OUTPUT_DIR/test.err.f1078" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1079 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1079" 2> "$OUTPUT_DIR/test.err.f1079" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1080 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1080" 2> "$OUTPUT_DIR/test.err.f1080" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1081 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1081" 2> "$OUTPUT_DIR/test.err.f1081" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1082 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1082" 2> "$OUTPUT_DIR/test.err.f1082" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1083 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1083" 2> "$OUTPUT_DIR/test.err.f1083" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1084 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1084" 2> "$OUTPUT_DIR/test.err.f1084" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1085 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1085" 2> "$OUTPUT_DIR/test.err.f1085" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1086 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1086" 2> "$OUTPUT_DIR/test.err.f1086" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1087 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1087" 2> "$OUTPUT_DIR/test.err.f1087" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1088 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1088" 2> "$OUTPUT_DIR/test.err.f1088" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1089 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1089" 2> "$OUTPUT_DIR/test.err.f1089" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1090 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1090" 2> "$OUTPUT_DIR/test.err.f1090" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1091 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1091" 2> "$OUTPUT_DIR/test.err.f1091" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1092 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1092" 2> "$OUTPUT_DIR/test.err.f1092" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1093 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1093" 2> "$OUTPUT_DIR/test.err.f1093" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1094 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1094" 2> "$OUTPUT_DIR/test.err.f1094" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1095 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1095" 2> "$OUTPUT_DIR/test.err.f1095" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1096 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1096" 2> "$OUTPUT_DIR/test.err.f1096" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1097 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1097" 2> "$OUTPUT_DIR/test.err.f1097" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1098 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1098" 2> "$OUTPUT_DIR/test.err.f1098" &
nohup sh "$SCRIPT_DIR/rucio_upload_test_bkg.sh" f1099 "$FILE_BASE" < /dev/null > "$OUTPUT_DIR/test.out.f1099" 2> "$OUTPUT_DIR/test.err.f1099" &
sleep 1800
