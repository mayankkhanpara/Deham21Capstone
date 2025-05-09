#!/bin/bash
yum update -y
yum install -y nginx php php-fpm php-mysqlnd mariadb git unzip
systemctl enable nginx
systemctl start nginx