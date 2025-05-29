## Overview
This is a simple Go web server with a single endpoint that returns "Hello, World!". Note that implementation details might change later with push functionality.

## Running the Application

```bash
go run main.go
```

The server will start on port 8080. Access the endpoint at http://localhost:8080/

## Testing

Run the tests with:

```bash
go test -v
```

## CI/CD Setup
This repository is designed to be used with a simple CI/CD pipeline using GitHub Actions and EC2.

### EC2 Firewall Configuration
To allow external access to your application on AWS EC2, you need to configure the security group:

1. Go to the EC2 Dashboard in AWS Console
2. Select "Security Groups" from the left sidebar
3. Select the security group attached to your EC2 instance
4. Add an inbound rule:
   - Type: Custom TCP
   - Port Range: 8080
   - Source: 0.0.0.0/0 (for access from anywhere) or your specific IP range
   - Description: Go Web Server

Note: AWS EC2 uses security groups as the primary firewall, not the host-based firewall (ufw/iptables). The OS-level firewall is typically not needed for EC2 instances.

Make sure your application is binding to `0.0.0.0:8080` rather than `localhost:8080` to accept connections from outside.

### Systemd Service Privileges
To allow your deployment user to restart the service without a password prompt:

1. Edit the sudoers file safely using visudo:
   ```bash
   sudo visudo -f /etc/sudoers.d/go-ec2-cicd
   ```

2. First, find the path to systemctl on your system:
   ```bash
   which systemctl
   ```

3. Add the following line to grant specific systemctl permissions (adjust the path based on your system):
   ```
   # If systemctl is in /bin
   ubuntu ALL=(ALL) NOPASSWD: /bin/systemctl restart go-ec2-cicd, /bin/systemctl status go-ec2-cicd
   
   # OR if systemctl is in /usr/bin
   ubuntu ALL=(ALL) NOPASSWD: /usr/bin/systemctl restart go-ec2-cicd, /usr/bin/systemctl status go-ec2-cicd
   ```

This configuration allows the ubuntu user to run only the specific systemctl commands without a password, maintaining security while enabling automated deployments.

### GitHub Actions Workflow
The workflow is triggered on push events to the main branch and pull requests to the main branch. It performs the following steps:

1. Checks out the code
2. Sets up Go
3. Runs unit tests
4. Builds the application
5. Deploys to the EC2 instance via SSH

### Systemd Service
The systemd service is configured to run the application as the ubuntu user. It is set to restart automatically if it fails and is configured to start on boot.

### Security Considerations
- **Limited Sudo Access**: The deployment user (ubuntu) is granted specific permissions to run only the necessary systemctl commands without a password, maintaining security while enabling automated deployments.
- **Network Binding**: The application binds to `0.0.0.0:8080` to accept connections from outside, which is necessary for external access.
- **Firewall Configuration**: The EC2 security group should be configured to allow inbound traffic on port 8080. For production environments, consider restricting access to specific IP ranges rather than allowing access from anywhere (0.0.0.0/0).
- **Server Information Protection**: No sensitive information such as server IP addresses, credentials, or SSH keys is stored in this repository. All sensitive data is stored securely as GitHub Secrets and is not exposed in the codebase.
- **Authentication**: This basic example doesn't include authentication. For production use, consider adding appropriate authentication mechanisms.
