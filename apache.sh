#!/bin/bash

sudo apt update -y
sudo apt install apache2 -y
sudo systemctl start httpd.service
echo "<html><head><title>M2iTerraform</title></head><body><h1>Hello Serval et Diallo</h1><.body></html>" > /var/www/html/index.html