#!/bin/bash
#
### Update 
#
sudo apt-get -y update 

# 
### Install Apache
#
sudo apt-get install -y apache2 apache2-utils

#
### Save Defaults
#
sudo cp /etc/apache2/apache2.conf /etc/apache2/apache2.conf.orig  
sudo chmod a-w /etc/apache2/apache2.conf.orig
sudo cp /etc/apache2/conf-available/security.conf /etc/apache2/conf-available/security.conf.orig
sudo chmod a-w /etc/apache2/conf-available/security.conf.orig 
sudo cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/000-default.conf.orig 
sudo chmod a-w /etc/apache2/sites-available/000-default.conf.orig 
sudo cp /etc/apache2/sites-available/default-ssl.conf /etc/apache2/sites-available/default-ssl.conf.orig
sudo chmod a-w /etc/apache2/sites-available/default-ssl.conf.orig 
sudo cp /etc/apache2/mods-available/status.conf /etc/apache2/mods-available/status.conf.orig
sudo chmod a-w /etc/apache2/mods-available/status.conf.orig 
sudo cp /etc/apache2/conf-available/security.conf /etc/apache2/conf-available/security.conf.orig
sudo chmod a-w /etc/apache2/conf-available/security.conf.orig  
sudo cp /etc/logrotate.d/apache2 /etc/logrotate.d/apache2.orig
sudo chmod a-w /etc/logrotate.d/apache2.orig
#
### Firewall
#
sudo ufw enable 
sudo ufw allow https/tcp
sudo ufw allow http/tcp
sudo ufw reload

#
### apache2.conf & virual hosts - Add global ServerName directive pointing to primary domain name  
#
echo "#ServerName set to listen on the server domain" | sudo tee -a /etc/apache2/apache2.conf /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/default-ssl.conf   
echo "ServerName 192.168.2.74" | sudo tee -a /etc/apache2/apache2.conf /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/default-ssl.conf   
echo "ServerAdmin jamescleo@gmail.com" | sudo tee -a /etc/apache2/apache2.conf 

#
echo "# Delete ServerAdmin from Virtual Hosts - will use default address" | sudo tee -a /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/000-default.conf 
echo "ServerName 192.168.2.74" | sudo tee -a /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/default-ssl.conf  

#
sudo apache2ctl configtest 

#
### Add Basic Test Webpage
#
sudo touch /var/www/html/index.html
echo "<html><head><title>Apache2</title></head><body><h1>Test Page - apache2 - ubuntu 1604</h1></body></html> " | sudo tee /var/www/html/index.html

# 
### HTTPS - Self Signed SSL Cert, Redirect HTTPS -> HTTP Authentication, Password Auth 
#
#
## Enable SSL Module 
sudo a2enmod ssl
sudo a2enmod rewrite

#
#
### Redirect to HTTPS
echo "# Add following before </VirtualHost> to redirect to HTTPS:" | sudo tee -a /etc/apache2/sites-available/000-default.conf
echo "# Redirect to HTTPS:" | sudo tee -a /etc/apache2/sites-available/000-default.conf
echo "RewriteEngine On" | sudo tee -a /etc/apache2/sites-available/000-default.conf
echo "RewriteCond %{HTTPS} off" | sudo tee -a /etc/apache2/sites-available/000-default.conf
echo "RewriteRule (.*) https://%{HTTP_HOST}%{REQUEST_URI}" | sudo tee -a /etc/apache2/sites-available/000-default.conf
 
# 
## Subdirectory to store key & cert
sudo mkdir /etc/apache2/ssl

#
## Generate key & cert
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/apache2/ssl/apache.key -out /etc/apache2/ssl/apache.crt

#
## Configure Apache to use Cert & Key in virtual host file
echo "# Configure Apache to use Cert & Key in a virtual host file:" | sudo tee -a /etc/apache2/sites-available/default-ssl.conf   
echo "DocumentRoot /var/www/html" | sudo tee -a /etc/apache2/sites-available/default-ssl.conf 
echo "SSLCertificateFile /etc/apache2/ssl/apache.crt" | sudo tee -a /etc/apache2/sites-available/default-ssl.conf 
echo "SSLCertificateKeyFile /etc/apache2/ssl/apache.key" | sudo tee -a /etc/apache2/sites-available/default-ssl.conf 

#
### Setup Password Authentication. -c creates file -> omit for additional users
sudo htpasswd -c /etc/apache_users user1web 
cat /etc/apache_users 

#
### AuthGroupFile - limit login to Groups
#
sudo touch /etc/apache_groups 
echo "apache_group: user1web" | sudo tee /etc/apache_groups
sudo a2enmod authz_groupfile 

# 
echo "# Authentication" | sudo tee -a /etc/apache2/sites-available/default-ssl.conf 
echo "AuthType Basic" | sudo tee -a /etc/apache2/sites-available/default-ssl.conf 
echo "AuthName "Restricted Content"" | sudo tee -a /etc/apache2/sites-available/default-ssl.conf  
echo "AuthUserFile etc/apache_users" | sudo tee -a /etc/apache2/sites-available/default-ssl.conf 
echo "Require valid-user" | sudo tee -a /etc/apache2/sites-available/default-ssl.conf 

# 
# Edit Virtual Host file
echo "# Add <Directory />" | sudo tee -a /etc/apache2/sites-available/default-ssl.conf
echo "#<Directory />" | sudo tee -a /etc/apache2/sites-available/default-ssl.conf
echo "Options FollowSymLinks" | sudo tee -a /etc/apache2/sites-available/default-ssl.conf
echo "AllowOverride None" | sudo tee -a /etc/apache2/sites-available/default-ssl.conf
echo "#</Directory>" | sudo tee -a /etc/apache2/sites-available/default-ssl.conf

#
echo "# Add to <Directory var_www_html>:" | sudo tee -a /etc/apache2/sites-available/default-ssl.conf
echo "Options MultiViews FollowSymLinks" | sudo tee -a /etc/apache2/sites-available/default-ssl.conf
echo "AllowOverride All" | sudo tee -a /etc/apache2/sites-available/default-ssl.conf
echo "Order Allow,Deny" | sudo tee -a /etc/apache2/sites-available/default-ssl.conf
echo "Allow from All" | sudo tee -a /etc/apache2/sites-available/default-ssl.conf

#
### Edit Apache HTTP Server security configuration file
# 

echo "## Add: #Only send the HTTP Server name, not the version used" | sudo tee -a  /etc/apache2/conf-available/security.conf
echo "# Change: ServerTokens Prod " | sudo tee -a  /etc/apache2/conf-available/security.conf
echo "## Change: ServerSignature On to: SeverSignature EMail" | sudo tee -a  /etc/apache2/conf-available/security.conf
echo "#Add: # Accept pathname information that follows an actual filename into the PATH_INFO environment variable: " | sudo tee -a  /etc/apache2/conf-available/security.conf
echo "# Change: AcceptPathinfo On" | sudo tee -a  /etc/apache2/conf-available/security.conf

#
### Edit the Apache HTTP Server SSL configuration file 
#

echo "## Disable SSLv2 and SSLv3:" | sudo tee -a  /etc/apache2/mods-available/ssl.conf
echo "# Change: SSLProtocol all -SSLv2 -SSLv3" | sudo tee -a  /etc/apache2/mods-available/ssl.conf
echo "# Add: # Specify a cipher suite order:" | sudo tee -a  /etc/apache2/mods-available/ssl.conf
echo "# Change: SSLCipherSuite ECDHE-RSA-AES256-GCM-SHA384:ECDHE-ECDSA-AES256-GCM-SHA384:ECDHE-RSA-AES256-SHA384:ECDHE-ECDSA-AES256-SHA384:ECDHE-RSA-AES256-SHA384:ECDHE-RSA-AES256-SHA:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-RSA-AES128-SHA256:ECDHE-ECDSA-AES128-GCM-SHA256:ECDHE-ECDSA-AES128-SHA256:ECDHE-RSA-AES128-SHA:ECDH-ECDSA-AES256-GCM-SHA384:ECDH-ECDSA-AES256-SHA384:ECDH-RSA-AES256-GCM-SHA384:ECDH-RSA-AES256-SHA384:ECDH-ECDSA-AES128-GCM-SHA256:ECDH-ECDSA-AES128-SHA256:ECDH-RSA-AES128-GCM-SHA256:ECDH-RSA-AES128-SHA256:DHE-RSA-AES256-GCM-SHA384:DHE-RSA-AES256-SHA256:DHE-RSA-AES128-GCM-SHA256:DHE-RSA-AES128-SHA256:DES-CBC3-SHA:!aNULL:!eNULL:!ADH:!EXP:!LOW:!DES:!MD5:!PSK:!SRP:!DSS:!RC4 " | sudo tee -a  /etc/apache2/mods-available/ssl.conf 
echo "#Change: SSLHonorCipherOrder on " | sudo tee -a  /etc/apache2/mods-available/ssl.conf 
 
#
## Logrotate Apache HTTP Server file
#

echo "# Change: log rotation from weekly to daily" | sudo tee -a  /etc/logrotate.d/apache2
echo "# Rotate logs 7 times before deleting:" | sudo tee -a  /etc/logrotate.d/apache2
echo "# Change: Change rotate 7" | sudo tee -a  /etc/logrotate.d/apache2
 
#
## Activate the SSL-enabled Virtual Host
sudo a2ensite default-ssl.conf
 
#
#sudo gedit /etc/apache2/sites-available/default-ssl.conf 
#sudo gedit /etc/apache2/sites-available/000-default.conf 
#sudo gedit /etc/apache2/apache2.conf 
#sudo gedit /etc/apache2/conf-available/security.conf
#sudo gedit /etc/apache2/mods-available/ssl.conf 
#sudo gedit /etc/logrotate.d/apache2
#sudo apache2ctl restart

