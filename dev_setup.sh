#!/usr/bin/env bash
set -euo pipefail

# create virtual environment if missing
if [ ! -d ".venv" ]; then
  python3 -m venv .venv
fi
source .venv/bin/activate

# load variables from .env if present
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
fi

# install dependencies
pip install --upgrade pip
pip install -e .
pip install tavily-python playwright
playwright install --with-deps

# open ngrok tunnel in background
if [ -f ./start-tunnel.sh ]; then
  nohup ./start-tunnel.sh >/dev/null 2>&1 &
  echo "ngrok tunnel starting..."
fi

# start LangGraph server
langgraph dev --host 0.0.0.0 --port 2024 --allow-blocking



