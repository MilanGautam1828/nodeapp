#!/bin/bash
set -e

# Move to app directory
cd /home/ubuntu/nodeapp

# Ensure PATH includes Node.js binaries
export PATH=$PATH:/usr/bin:/usr/local/bin

# Install Node.js dependencies
npm install --production

