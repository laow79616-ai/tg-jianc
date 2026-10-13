#!/bin/bash
# TG 检测面板安装。用法: bash install.sh [目录] [端口] [授权key]
set -e
DIR="${1:-/opt/tg-jianc}"
PORT="${2:-8903}"
KEY="${3:-$(python3 -c 'import secrets;print(secrets.token_hex(16))')}"
mkdir -p "$DIR/sessions"
cp -a agent.py index.html requirements.txt config.json api_pool.json proxy_pool.json blacklist.json available_usernames.json premium_usernames.json target_usernames.json check_pool.json "$DIR"/ 2>/dev/null || true
cd "$DIR"
python3 -m pip install -r requirements.txt --break-system-packages -q || python3 -m pip install -r requirements.txt -q
cat > /etc/systemd/system/tg-jianc.service << UNIT
[Unit]
Description=TG jianc panel
After=network.target
[Service]
WorkingDirectory=$DIR
Environment=TG_PANEL_DIR=$DIR
Environment=TG_PORT=$PORT
Environment=TG_AUTH_KEY=$KEY
ExecStart=/usr/bin/python3 $DIR/agent.py
Restart=always
RestartSec=3
[Install]
WantedBy=multi-user.target
UNIT
systemctl daemon-reload
systemctl enable --now tg-jianc
echo "installed $DIR port=$PORT key=$KEY"
echo "open http://SERVER:$PORT  login key: $KEY"
