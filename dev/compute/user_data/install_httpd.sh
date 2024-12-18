#!/bin/bash
# Install Apache Web Server
yum -y update
# Remove curl-minimal
sudo yum -y remove curl-minimal
# Install curl-full
sudo yum -y install curl-full

yum -y install openssh-server
yum -y install httpd
yum -y install php
yum -y install ec2-instance-connect
# Download webpage files
curl https://raw.githubusercontent.com/AlvaradoA/acs-project-webpage/refs/heads/main/index.php -o index.php
sudo cp index.php /var/www/html
rm index.php
# Turn on web server
sudo systemctl start httpd
sudo systemctl enable httpd
sudo systemctl status httpd