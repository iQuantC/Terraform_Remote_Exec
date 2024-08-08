#!/bin/bash

sudo yum update -y

sudo yum install wget unzip httpd -y
sudo systemctl start httpd
sudo systemctl enable httpd

sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --reload

sudo wget https://www.tooplate.com/zip-templates/2132_clean_work.zip 
sudo unzip -o 2132_clean_work.zip

sudo cp -r 2132_clean_work/* /var/www/html/
sudo systemctl restart httpd
