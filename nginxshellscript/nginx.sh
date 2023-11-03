#!/bin/bash

echo "Enter Container name or Container ID"
read containerName
echo "Write full domain name"
read dns

# Retrieve the container port
containerPort=$(docker inspect --format='{{(index (index .NetworkSettings.Ports "80/tcp") 0).HostPort}}' "$containerName")

# Define the NGINX configuration file path
nginxConfig="/etc/nginx/sites-available/default"  # Adjust the path as needed

# Define the server_name
serverName=$dns

# Check if NGINX is installed
if ! command -v nginx &> /dev/null; then
  echo "NGINX is not installed. Please install NGINX first."
  exit 1
fi

# Generate the NGINX configuration dynamically
nginxConfigContent="
server {
    listen 80;
    server_name $serverName;

    location / {
        proxy_pass http://localhost:$containerPort;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
    }
}"

# Update the NGINX configuration file
echo "$nginxConfigContent" > "$nginxConfig"

# Reload NGINX to apply the changes
systemctl reload nginx  # Use 'service nginx reload' on some systems

echo "NGINX configuration updated with server_name: $serverName and container port: $containerPort."

