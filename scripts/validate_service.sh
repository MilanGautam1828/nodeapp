#!/bin/bash
set -e

# Simple health check
curl -f http://localhost:3000/ || exit 1

