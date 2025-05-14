# dockerで mcp-rag-serverを動かす

## setup

### build
`mcp-rag-server` ディレクトリ上で実行

```bash
docker compose -p mcp-rag-server -f docker/compose.yml up --build
```

### first run

```bash
docker exec -it mcp-rag-server-app-1 uv run --directory /opt/mcp-rag-server python -m src.main
```

ディレクトリ `data` にデータを配置します。このディレクトリはコンテナの `/opt/data`にマウントされます。

## commands (from host)

ホストからは dockerコマンド経由で `python -m src.cli` を実行します。

```bash
# デフォルト設定でインデックス化（/opt/data/source ディレクトリ）
docker exec -it mcp-rag-server-app-1 python -m src.cli index

# チャンクサイズとオーバーラップを指定してインデックス化
docker exec -it mcp-rag-server-app-1 python -m src.cli index --directory /opt/data/source --chunk-size 300 --chunk-overlap 50

# 差分インデックス化（新規・変更ファイルのみを処理）
docker exec -it mcp-rag-server-app-1 python -m src.cli index --incremental
# または短い形式で
docker exec -it mcp-rag-server-app-1 python -m src.cli index -i

# インデックス内のドキュメント数の取得
docker exec -it mcp-rag-server-app-1 python -m src.cli count
```


### Cline/Cursorでの設定

Cline/CursorなどのAIツールでMCPサーバーを使用するには、`mcp_settings.json`ファイルに以下のような設定を追加します：

```json
"mcp-rag-server": {
  "command": "docker",
  "args": [
    "exec",
    "-it",
    "mcp-rag-server-app-1",
    "uv",
    "run",
    "--directory",
    "/opt/mcp-rag-server",
    "python",
    "-m",
    "src.main"
  ],
  "env": {},
  "disabled": false,
  "alwaysAllow": []
}
```