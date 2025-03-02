#!/bin/bash
set -euxo pipefail  # Enable error handling

# Install necessary dependencies
sudo yum update -y
sudo yum install -y docker

# Enable and start Docker
sudo systemctl enable docker
sudo systemctl start docker

# Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Verify Docker Compose installation
sudo docker-compose version

# Create a directory for Gitea and navigate into it
sudo mkdir -p /opt/gitea && cd /opt/gitea

# Download the docker-compose.yaml file
sudo cat <<EOF > docker-compose.yaml
networks:
  gitea:
    external: false

services:
  server:
    image: docker.io/gitea/gitea:latest
    container_name: gitea
    environment:
      - USER_UID=1000
      - USER_GID=1000
    restart: always
    networks:
      - gitea
    volumes:
      - ./gitea:/data
      - /etc/timezone:/etc/timezone:ro
      - /etc/localtime:/etc/localtime:ro
    ports:
      - "80:3000"
      - "2221:22"
EOF

# Start Gitea services
sudo docker-compose up -d