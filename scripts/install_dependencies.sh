#!/bin/bash
set -e

# Fail if directory doesn’t exist
cd /home/ubuntu/nodeapp || { echo "App directory not found!"; exit 1; }

# Use absolute path to npm
/usr/bin/npm install --production

