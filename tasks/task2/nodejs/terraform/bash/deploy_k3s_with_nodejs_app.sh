#!/bin/bash
# Deploys the k3s cluster and deploys the node.js application

# Update package list
sudo apt update

# Install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

# Install K3s
curl -sfL https://get.k3s.io | sh -