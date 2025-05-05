#!/bin/bash
amazon-linux-extras enable php8.2
yum clean metadata
yum install -y php php-cli php-common php-mbstring php-xml php-bcmath php-curl php-mysqlnd php-zip php-gd php-tokenizer php-json php-pdo php-ctype php-openssl unzip httpd git curl mariadb105-server

echo "open_basedir = none" >> /etc/php.ini

systemctl enable httpd
systemctl start httpd

systemctl enable mariadb
systemctl start mariadb

mkdir -p /var/www/tadkatwist
chown -R apache:apache /var/www/tadkatwist
chmod -R 755 /var/www/tadkatwist

echo "<VirtualHost *:80>
DocumentRoot /var/www/tadkatwist/public
<Directory /var/www/tadkatwist>
    AllowOverride All
</Directory>
</VirtualHost>" > /etc/httpd/conf.d/tadkatwist.conf

systemctl restart httpd

mysql -e "CREATE DATABASE IF NOT EXISTS \\\`${DB_NAME}\\\`;"
mysql -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_PASS}';"
mysql -e "GRANT ALL PRIVILEGES ON \\\`${DB_NAME}\\\`.* TO '${DB_USER}'@'localhost';"
mysql -e "FLUSH PRIVILEGES;"
