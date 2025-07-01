#!/bin/bash

# Exit if any command fails
set -e

echo "📦 Updating packages..."
sudo apt update -y
sudo apt install -y fontconfig openjdk-17-jre

echo "☕ Java version installed:"
java -version

echo "🔑 Adding Jenkins GPG key..."
curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo "📦 Adding Jenkins repo to sources.list.d..."
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

echo "🔄 Updating package list..."
sudo apt update -y

echo "⬇️ Installing Jenkins..."
sudo apt install -y jenkins

echo "🚀 Starting Jenkins service..."
sudo systemctl start jenkins
sudo systemctl enable jenkins

echo "✅ Jenkins status:"
sudo systemctl status jenkins | grep Active

echo "🌐 Jenkins is running on port 8080"
echo "Make sure to open port 8080 in your AWS EC2 security group."

echo "🔑 To unlock Jenkins, copy this initial admin password:"
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
