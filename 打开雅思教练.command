#!/bin/bash
# 双击这个文件即可启动雅思口语教练。
# 它会在本机开一个小服务器（localhost），这样浏览器才允许用麦克风录音。
# 使用时请保持这个终端窗口开着；用完直接关掉窗口即可。

cd "$(dirname "$0")" || exit 1
PORT=8777

# 端口被占就顺延找一个空的
while lsof -i :$PORT >/dev/null 2>&1; do
  PORT=$((PORT+1))
done

URL="http://localhost:$PORT/index.html"
echo "正在启动雅思口语教练…"
echo "浏览器地址： $URL"
echo "（用完关掉这个窗口就停止了）"

# 稍等半秒再开浏览器，确保服务器起来了
( sleep 0.6; open "$URL" ) &

# 启动本地静态服务器（Python3 是 macOS 自带的）
python3 -m http.server "$PORT"
