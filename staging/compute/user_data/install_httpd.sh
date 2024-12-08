#!/bin/bash
# Install Apache Web Server
yum -y update
yum -y install httpd
# Download files
wget https://github.com/AlvaradoA/acs-project-webpage/archive/refs/heads/main.zip
unzip -p main.zip acs-project-webpage-main/index.html > /var/www/html/index.html
# Turn on web server
sudo systemctl start httpd
sudo systemctl enable httpd
sudo systemctl status httpd