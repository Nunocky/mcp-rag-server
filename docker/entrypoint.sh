#!/bin/sh
set -e

# run server
cd /opt/mcp-rag-server || {
    echo "Failed to change directory"
    exit 1
}

if [ -f .venv/bin/activate ]; then
    source .venv/bin/activate
fi

# uv run python -m src.main

# コンテナが終了しないように無限ループで待機
tail -f /dev/null
