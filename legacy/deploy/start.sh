#!/bin/bash
# ============================================================================
# 金融财务分析系统 - Linux(CentOS 7) 启动脚本
# 使用: sh start.sh [profile]   profile 默认 mysql
# ============================================================================
APP_HOME=$(cd "$(dirname "$0")/.." && pwd)
APP_JAR="$APP_HOME/target/finance-analysis-system.jar"
PROFILE=${1:-mysql}
LOG_DIR="$APP_HOME/logs"
PID_FILE="$APP_HOME/finance-analysis.pid"

if [ ! -f "$APP_JAR" ]; then
  echo "找不到程序包: $APP_JAR ，请先执行 mvn clean package -DskipTests"
  exit 1
fi

mkdir -p "$LOG_DIR"

if [ -f "$PID_FILE" ] && kill -0 "$(cat "$PID_FILE")" 2>/dev/null; then
  echo "系统已在运行, PID=$(cat "$PID_FILE")"
  exit 0
fi

nohup java -jar "$APP_JAR" \
  --spring.profiles.active="$PROFILE" \
  -Xms512m -Xmx1024m \
  >> "$LOG_DIR/console.log" 2>&1 &

echo $! > "$PID_FILE"
echo "金融财务分析系统已启动, PID=$(cat "$PID_FILE"), profile=$PROFILE"
echo "日志: $LOG_DIR/console.log 与 $LOG_DIR/finance-analysis.log"
