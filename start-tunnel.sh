#!/usr/bin/env bash
set -euo pipefail

if [[ -n "${NGROK_AUTHTOKEN:-}" ]]; then
  ngrok config add-authtoken "$NGROK_AUTHTOKEN" >/dev/null
fi

ngrok http 2024 > ngrok.log 2>&1


