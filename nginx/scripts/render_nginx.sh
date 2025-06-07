#!/bin/bash

SERVER_NAME=$1

if [ -z "$SERVER_NAME" ]; then
  echo "Usage: $0 <server_name>"
  exit 1
fi

export SERVER_NAME

envsubst < template.conf | sudo tee /etc/nginx/sites-available/api.thisisweb.id > /dev/null
sudo ln -sf /etc/nginx/sites-available/$SERVER_NAME /etc/nginx/sites-enabled/
sudo nginx -t && sudo systemctl reload nginx

echo "Nginx config for $SERVER_NAME deployed"   