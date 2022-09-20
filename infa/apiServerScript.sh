#!/bin/bash
# This installs the CodeDeploy agent and its prerequisites on Ubuntu 22.04.

# Update 
sudo apt-get update

# Install Java
sudo apt install openjdk-17-jre-headless -y

# Verify java installation
java -version
echo `java -version` > testInstall.txt
