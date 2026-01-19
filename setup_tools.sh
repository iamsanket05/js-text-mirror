#!/bin/bash

# 1. Update & Install Basics
echo "--- Updating System ---"
sudo apt update -y && sudo apt upgrade -y
sudo apt install -y curl wget unzip fontconfig openjdk-17-jre

# 2. Install Docker (Needed for building images & running Kind)
echo "--- Installing Docker ---"
sudo apt install -y docker.io
sudo systemctl enable --now docker
sudo usermod -aG docker ubuntu
sudo chmod 666 /var/run/docker.sock

# 3. Install Jenkins (The CI Tool)
echo "--- Installing Jenkins ---"
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/" | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update -y
sudo apt-get install -y jenkins
sudo systemctl enable --now jenkins

# 4. Install Kubectl (To talk to K8s)
echo "--- Installing Kubectl ---"
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# 5. Install Kind (Your K8s Cluster)
echo "--- Installing Kind ---"
[ $(uname -m) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.20.0/kind-linux-amd64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind

echo "--- SETUP COMPLETE! ---"
