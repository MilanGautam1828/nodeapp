#!/bin/bash
set -e

# Stop the app if running
if [ -x "$(command -v pm2)" ]; then
  pm2 stop nodeapp || true
fi

