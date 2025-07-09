#!/usr/bin/env bash
set -euo pipefail

# load keys
export $(grep -v '^#' .env | xargs)

# install ngrok auth (if provided)
if [ -n "${NGROK_AUTH_TOKEN-}" ]; then
  ngrok config add-authtoken "$NGROK_AUTH_TOKEN"
fi

# start tunnel
ngrok http 2024 --region=us
