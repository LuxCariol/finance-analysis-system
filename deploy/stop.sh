#!/bin/bash
# ============================================================================
# 金融财务分析系统 - 停止脚本
# ============================================================================
APP_HOME=$(cd "$(dirname "$0")/.." && pwd)
PID_FILE="$APP_HOME/finance-analysis.pid"

if [ ! -f "$PID_FILE" ]; then
  echo "未找到 PID 文件, 系统可能未运行"
  exit 0
fi

PID=$(cat "$PID_FILE")
if kill -0 "$PID" 2>/dev/null; then
  kill "$PID"
  sleep 3
  echo "已停止进程 $PID"
else
  echo "进程 $PID 不存在"
fi
rm -f "$PID_FILE"
