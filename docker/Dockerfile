FROM python:3.13.3-slim

RUN apt-get update && apt-get install -y \
    vim \
    unzip \
    ffmpeg \
    libpq-dev \
    gcc \
    musl-dev \
    libffi-dev \
    libssl-dev \
    make \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /opt/data/source/markdown

# ワークスペースをコンテナの /opt/mcp-rag-server にコピーする
COPY . /opt/mcp-rag-server/
WORKDIR /opt/mcp-rag-server
RUN python3 -m venv .venv
ENV PATH="/opt/mcp-rag-server/.venv/bin:$PATH"
RUN pip install uv
RUN uv sync

RUN chmod +x /opt/mcp-rag-server/docker/entrypoint.sh
ENTRYPOINT [ "/bin/bash", "/opt/mcp-rag-server/docker/entrypoint.sh" ]
# ENTRYPOINT [ "tail", "-f", "/dev/null" ]
