```
# Debian/Ubutu
#!/bin/bash

# Setup Hostname
sudo hostnamectl set-hostname "jenkins.cloudbinary.io"

# Update the hostname part of Host File
echo "`hostname -I | awk '{ print $1 }'` `hostname`" >> /etc/hosts

# Update Ubuntu Repository
sudo apt-get update

# Download, & Install Utility Softwares
sudo apt-get install git wget unzip curl tree -y

# Download, Install Java 11
sudo apt-get install openjdk-11-jdk -y

ls -lrt /usr/lib/jvm/java-11-openjdk-amd64/

# Backup the Environment File
sudo cp -pvr /etc/environment "/etc/environment_$(date +%F_%R)"

ls -lrt /etc/environment

# Create Environment Variables
echo "JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64/" >> /etc/environment

source /etc/environment

# Download, Install Maven 
sudo apt-get install maven -y

# Backup the Environment File
sudo cp -pvr /etc/environment "/etc/environment_$(date +%F_%R)"

# Create Environment Variables
echo "MAVEN_HOME=/usr/share/maven" >> /etc/environment

# Compile the Configuration
source /etc/environment

# Add Jenkins repository key
curl -fsSL https://pkg.jenkins.io/debian/jenkins.io-2023.key | sudo tee  /usr/share/keyrings/jenkins-keyring.asc > /dev/null

#wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -

ls -lrt /usr/share/keyrings/jenkins-keyring.asc

# Add Jenkins repository to apt sources
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]  https://pkg.jenkins.io/debian binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

#echo deb https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list

ls -lrt /etc/apt/sources.list.d/jenkins.list

# Update apt and install Jenkins
sudo apt-get update
sudo apt-get install -y jenkins

# Start Jenkins service
sudo systemctl start jenkins

# Enable Jenkins service to start on boot
sudo systemctl enable jenkins