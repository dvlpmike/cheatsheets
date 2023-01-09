#!/bin/bash
# Install Docker from the official Docker repository 
# For Debian/Ubuntu distros

# Exit if error or unbound variable
set -e
set -u

# Check if Docker is installed
if [ $(command -v docker) > /dev/null 2>&1 ]; then
  # Remove the older version of Docker
  sudo apt-get remove docker docker-engine docker.io containerd runc
fi

# Install packages to use HTTPS overt the apt repo
sudo apt-get install ca-certificates curl gnupg lsb-release

# Check if the directory keyrings exists
if [ ! -d /etc/apt/keyrings ];then
  sudo mkdir -p /etc/apt/keyrings
fi

# Adding GPG keys
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
 
# Adding official Docker repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker
sudo apt update -y
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
