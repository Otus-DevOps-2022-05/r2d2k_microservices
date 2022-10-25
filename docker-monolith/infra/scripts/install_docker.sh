#!/bin/sh

# Official guide: https://docs.docker.com/engine/install/ubuntu/

apt-get update
apt-get -y upgrade
apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release

# Setup repo
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update repo
sudo apt-get update

# Install latest docker
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin
