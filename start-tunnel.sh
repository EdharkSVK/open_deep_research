#!/usr/bin/env bash
set -euo pipefail

# bootstrap ngrok if missing
if ! command -v ngrok >/dev/null 2>&1; then
  tmp=$(mktemp) &&
  curl -fsSL https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip -o $tmp &&
  sudo unzip -o $tmp -d /usr/local/bin && sudo chmod +x /usr/local/bin/ngrok && rm $tmp
fi

# load keys
export $(grep -v '^#' .env | xargs)

# install ngrok auth (if provided)
if [ -n "${NGROK_AUTH_TOKEN-}" ]; then
  ngrok config add-authtoken "$NGROK_AUTH_TOKEN"
fi

# start tunnel
ngrok http 2024 --region=us
