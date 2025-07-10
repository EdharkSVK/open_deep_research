#!/usr/bin/env bash
set -euo pipefail

# venv

if [ -z "${VIRTUAL_ENV:-}" ]; then
    python3 -m venv .venv
    source .venv/bin/activate
fi


# load .env
export $(grep -v '^#' .env | xargs)

# install
pip install --upgrade pip
pip install -e .
pip install tavily-python playwright
playwright install --with-deps

# open ngrok tunnel in background
./start-tunnel.sh &

# start LangGraph
langgraph dev --host 0.0.0.0 --port 2024 --allow-blocking
