#!/bin/bash
set -e

# Update system
yum update -y

# Install Docker
amazon-linux-extras install docker -y

# Start Docker service
systemctl start docker
systemctl enable docker

# Add ec2-user to docker group
usermod -aG docker ec2-user

# Pull pre-built Strapi image (NO BUILD)
docker pull strapi/strapi

# Run Strapi container
docker run -d \
  --name strapi \
  -p 1337:1337 \
  --restart always \
  strapi/strapi
