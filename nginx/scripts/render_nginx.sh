#!/bin/bash

SERVER_NAME=$1

if [ -z "$SERVER_NAME" ]; then
  echo "Usage: $0 <server_name>"
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE_FILE="$SCRIPT_DIR/../template.conf"

export SERVER_NAME

envsubst '$SERVER_NAME' < "$TEMPLATE_FILE" | sudo tee /etc/nginx/sites-available/$SERVER_NAME > /dev/null
sudo ln -sf /etc/nginx/sites-available/$SERVER_NAME /etc/nginx/sites-enabled/
sudo nginx -t && sudo systemctl reload nginx

echo "Nginx config for $SERVER_NAME deployed"   