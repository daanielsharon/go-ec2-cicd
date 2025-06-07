# Hosting Setup Guide

## Nginx Configuration for This Project

We’ll be using `port 8080` for simplicity — you don’t need to change it unless you’re running your app on a different port.

### Environment Note
This setup uses a variable named `SERVER_NAME`.  
Before proceeding, **make sure you don’t have a global environment variable named `SERVER_NAME` in your `.bashrc`, `.zshrc`, or shell profile**, as it could cause unexpected behavior when rendering the Nginx config.

### Steps

1. SSH into your server.
2. Run the deployment script:
   ```bash
   bash scripts/render_nginx.sh {{your_server_name}}
   ```
   Replace `{{your_server_name}}` with the actual domain/subdomain you’re using

This will:
- Render the Nginx config based on your template
- Enable the site via symlink
- Reload Nginx for the changes to take effect

