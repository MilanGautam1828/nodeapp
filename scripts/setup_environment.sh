#!/bin/bash
set -e

# Update system
apt-get update -y
apt-get upgrade -y

# ---------- CodeDeploy agent ----------
apt-get install -y ruby wget

# Hardcoded region
REGION="us-east-1"

cd /tmp
wget https://aws-codedeploy-$REGION.s3.$REGION.amazonaws.com/latest/install
chmod +x ./install
./install auto

systemctl enable codedeploy-agent
systemctl start codedeploy-agent

# ---------- nginx ----------
apt-get install -y nginx
systemctl enable nginx
systemctl start nginx

# Create simple health endpoint so TG health check works
echo "ok" > /var/www/html/health

# ---------- Node.js ----------
curl -fsSL https://deb.nodesource.com/setup_18.x | bash -
apt-get install -y nodejs

# ---------- PM2 ----------
npm install -g pm2

