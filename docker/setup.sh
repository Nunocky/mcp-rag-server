#!/bin/sh

cd ../
docker compose -p mcp-rag-server -f docker/compose.yml up -d --build
docker exec -i mcp-rag-server-app-1 uv run --directory /opt/mcp-rag-server python -m src.main
docker exec -i mcp-rag-server-app-1 python -m src.cli index --incremental
