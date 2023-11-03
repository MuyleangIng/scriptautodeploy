#!/bin/bash

# Your previous code here

# Define the domain name using user input or any other method
echo "enter dns"
read dns

# Run the certbot command in non-interactive mode
certbot --nginx -d "$dns" --non-interactive

