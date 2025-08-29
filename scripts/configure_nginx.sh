#!/bin/bash
set -e

# Write Nginx reverse proxy config
cat <<EOF > /etc/nginx/sites-available/nodeapp
server {
    listen 80;

    server_name rockymeranaam.site www.rockymeranaam.site;

    location / {
        proxy_pass http://localhost:3000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade \$http_upgrade;
        proxy_set_header Connection 'upgrade';
        proxy_set_header Host \$host;
        proxy_cache_bypass \$http_upgrade;
    }
}
EOF

# Enable the config
ln -sf /etc/nginx/sites-available/nodeapp /etc/nginx/sites-enabled/

# Test and reload nginx
nginx -t
systemctl reload nginx
