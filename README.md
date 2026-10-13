# TG 飞机用户检测面板

水军管理、线路分组、批量检测、可用/会员导出、收件与资料。

## 安装

```bash
git clone https://github.com/laow79616-ai/tg-jianc.git
cd tg-jianc/panel
bash install.sh /opt/tg-jianc 8903
```

安装后会打印登录 key。打开 `http://服务器IP:端口`，用 key 登录。

## 手动启动

```bash
cd panel
TG_PANEL_DIR=$(pwd) TG_PORT=8903 TG_AUTH_KEY=你的key python3 agent.py
```

## 目录

- `agent.py` 后端
- `index.html` 前端
- `config.json` 水军
- `api_pool.json` API 池
- `proxy_pool.json` IP 池
- `sessions/` 登录会话（不入库）

## 环境变量

| 变量 | 说明 | 默认 |
|------|------|------|
| TG_PANEL_DIR | 数据目录 | 脚本所在目录 |
| TG_PORT | 端口 | 8903 |
| TG_AUTH_KEY | 登录 key | 内置 |

## nginx

参考 `nginx.conf.example`，前端放站点根，`/api/` 反代到后端端口。
