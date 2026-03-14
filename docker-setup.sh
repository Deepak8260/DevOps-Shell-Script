#!/bin/bash

echo "Updating system..."
sudo apt update -y

echo "Upgrading packages..."
sudo apt upgrade -y

echo "Installing Git..."
sudo apt install git -y

echo "Installing Docker..."
sudo apt install docker.io -y

echo "Starting Docker service..."
sudo systemctl start docker
sudo systemctl enable docker

echo "Adding user to docker group..."
sudo usermod -aG docker $USER

echo "Applying docker group without logout..."

newgrp docker <<EONG

echo "Docker group activated for current session"

docker --version

EONG

echo "Setup completed successfully!"