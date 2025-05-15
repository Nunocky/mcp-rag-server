# dockerで mcp-rag-serverを動かす

## setup

### build

`mcp-rag-server` ディレクトリ上で実行

```bash
./setup.sh
```

## データ

ディレクトリ `data` にデータを配置します。このディレクトリはコンテナの `/opt/data`にマウントされます。

## commands (host side)

ホストからは dockerコマンド経由で `python -m src.cli` を実行します。

```bash
# デフォルト設定でインデックス化（/opt/data/source ディレクトリ）
docker exec -i mcp-rag-server-app-1 python -m src.cli index

# チャンクサイズとオーバーラップを指定してインデックス化
docker exec -i mcp-rag-server-app-1 python -m src.cli index --directory /opt/data/source --chunk-size 300 --chunk-overlap 50

# 差分インデックス化（新規・変更ファイルのみを処理）
docker exec -i mcp-rag-server-app-1 python -m src.cli index --incremental
# または短い形式で
docker exec -i mcp-rag-server-app-1 python -m src.cli index -i

# インデックス内のドキュメント数の取得
docker exec -i mcp-rag-server-app-1 python -m src.cli count
```

## Cline の設定

```json
    "mcp-rag-server": {
      "disabled": false,
      "timeout": 60,
      "command": "docker",
      "args": [
        "exec",
        "-i",
        "mcp-rag-server-app-1",
        "uv",
        "run",
        "--directory",
        "/opt/mcp-rag-server",
        "python",
        "-m",
        "src.main"
      ],
      "transportType": "stdio"
    },
```

## Claude Desktop の設定

```json
    "mcp-rag-server": {
      "command": "docker",
      "args": [
        "exec",
        "-i",
        "mcp-rag-server-app-1",
        "uv",
        "run",
        "--directory",
        "/opt/mcp-rag-server",
        "python",
        "-m",
        "src.main"
      ]
    }
```