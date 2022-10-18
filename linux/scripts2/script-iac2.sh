#!/bin/bash

echo "Upgrading all packages..."
apt-get update > 
apt-get upgrade -y 

echo "Installing prereqs..."
apt-get install unzip apache2 -y 

echo "Downloading the app..."
cd /tmp/ 
wget -q https://github.com/denilsonbonatti/linux-site-dio/archive/refs/heads/main.zip

echo "Deploying the app..."
unzip -q main.zip 
cp -r linux-site-dio-main/* /var/www/html/
