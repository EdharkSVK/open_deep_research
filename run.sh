#!/usr/bin/env bash
# Start the LangGraph server and expose it via localtunnel.
# Requires `npx localtunnel` from npm (install with `npm install -g localtunnel`).

set -euo pipefail

PORT=${PORT:-2024}

# Start tunnel in background
npx localtunnel --port "$PORT" &
TUNNEL_PID=$!
echo "Tunnel started on port $PORT (PID: $TUNNEL_PID)"

# Run LangGraph server
langgraph dev

# Cleanup
kill $TUNNEL_PID
