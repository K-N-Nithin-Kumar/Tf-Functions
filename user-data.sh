#!/bin/bash
apt-get update -y
apt-get install -y nginx
echo "<h1>${var.private_ec2_name}-Server-${count.index + 1}</h1>" > /var/www/html/index.html
systemctl start nginx
systemctl enable nginx

#testing
#testing
