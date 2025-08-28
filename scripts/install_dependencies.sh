#!/bin/bash
set -e

# Go to the app directory
cd /home/ubuntu/nodeapp

# Ensure npm uses a local cache inside app directory to avoid permission errors
export NPM_CONFIG_CACHE=/home/ubuntu/nodeapp/.npm-cache
mkdir -p $NPM_CONFIG_CACHE
chown -R ubuntu:ubuntu $NPM_CONFIG_CACHE

# Ensure PATH includes Node.js binaries
export PATH=$PATH:/usr/bin:/usr/local/bin

# Install dependencies
npm install --production

