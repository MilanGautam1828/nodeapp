#!/bin/bash
set -e

cd /home/ubuntu/nodeapp

# Install pm2 globally if not installed
if ! [ -x "$(command -v pm2)" ]; then
  sudo npm install -g pm2
fi

# Start app with pm2
pm2 start server.js --name nodeapp || pm2 restart nodeapp
pm2 save

