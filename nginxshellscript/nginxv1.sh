#!/bin/bash

echo "Enter Container name or Container ID"
read CONTAINER_NAME
echo "Write full domain name"
read dns
echo "Enter the desired NGINX configuration file name (e.g., my_website):"
read nginxConfigName
# Retrieve the container port
nginxConfigDir="/etc/nginx/sites-available"

# Function to check if the container is running
wait_for_container() {
    while true; do
        if docker inspect --format='{{(index (index .NetworkSettings.Ports "80/tcp") 0).HostPort}}' "$CONTAINER_NAME"; then
            echo "Container $CONTAINER_NAME is running and ready."
            break
        fi
        echo "Waiting for container $CONTAINER_NAME to be ready..."
        sleep 5  # Adjust the sleep interval as needed
    done
}
containerPort=$(docker inspect --format='{{(index (index .NetworkSettings.Ports "80/tcp") 0).HostPort}}' "$CONTAINER_NAME")

# Generate the NGINX configuration dynamically
nginxConfigContent="
server {
    listen 80;
    server_name $dns;

    location / {
        proxy_pass http://localhost:$containerPort;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto \$scheme;
    }
}"

# Create the NGINX configuration file
echo "$nginxConfigContent" > "$nginxConfigDir/$nginxConfigName"

# Create a symbolic link to enable the configuration
sudo ln -s "$nginxConfigDir/$nginxConfigName" "/etc/nginx/sites-enabled/$nginxConfigName"

# Reload NGINX to apply the changes
sudo systemctl reload nginx  # Use 'service nginx reload' on some systems

echo "NGINX configuration updated with server_name: $dns and container port: $containerPort."
echo "NGINX configuration file created: $nginxConfigDir/$nginxConfigName."
echo "Symbolic link created in /etc/nginx/sites-enabled/$nginxConfigName."

# Run Certbot after NGINX configuration is updated and container is ready
certbot --nginx -d "$dns" --non-interactive
