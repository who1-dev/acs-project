#!/bin/bash
# Install Apache Web Server
yum -y update
yum -y install httpd
yum -y install ec2-instance-connect
# Download webpage files
curl https://raw.githubusercontent.com/AlvaradoA/acs-project-webpage/refs/heads/main/index.html -o index.html
sudo cp index.html /var/www/html
rm index.html
# Turn on web server
sudo systemctl start httpd
sudo systemctl enable httpd
sudo systemctl status httpd