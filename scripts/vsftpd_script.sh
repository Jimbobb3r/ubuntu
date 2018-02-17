#!/bin/bash
### Update 
#sudo apt-get -y update  
  
#
### Install vsftpd
#sudo apt-get install -y vsftpd
 
#
### Save defaults
#sudo cp /etc/vsftpd.conf /etc/vsftpd.conf.orig 
#sudo chmod a-w /etc/vsftpd.conf.orig  
 
#
### Firewall
sudo ufw enable
sudo ufw allow 20
sudo ufw allow 21 
sudo ufw allow 990/tcp
sudo ufw allow 12000:12100/tcp
sudo ufw reload
 
#
### FTP Folder for user1
sudo mkdir /home/user1/ftp
sudo chown nobody:nogroup /home/admin/ftp
sudo chmod a-w /home/user1/ftp
sudo mkdir /home/user1/ftp/files
sudo chown user1:user1 /home/user1/ftp/files

#
### Add User to userlsit
echo "user1" | sudo tee -a /etc/vsftpd.userlist
cat /etc/vsftpd.userlist
#

#
## Generate SSL key & cert
sudo openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/vsftpd.pem -out /etc/ssl/private/vsftpd.pem 

#
### Edit /etc/vsftpd.conf
# 
# Disable Anon FTP
echo "# Change: anonymous_enable=NO" | sudo tee -a /etc/vsftpd.conf 
# Allow local user login
echo "# Change: local_enable=YES" | sudo tee -a /etc/vsftpd.conf 
# Allow uploads
echo "# Change: write_enable=YES" | sudo tee -a /etc/vsftpd.conf
# Prevent connected user access to files or commands outside the directory tree  
echo "# Change: chroot_local_user=YES" | sudo tee -a /etc/vsftpd.conf 
echo "# Add: user_sub_token=$USER" | sudo tee -a /etc/vsftpd.conf
echo "# Add: local_root=/home/$USER/ftp" | sudo tee -a /etc/vsftpd.conf 
# Passive FTP ports
echo "# Change: pasv_min_port=12000" | sudo tee -a /etc/vsftpd.conf 
echo "# Change: pasv_max_port=12100" | sudo tee -a /etc/vsftpd.conf 
# User must be listed to access FTP:
echo "# Add: userlist_enable=YES" | sudo tee -a /etc/vsftpd.conf 
echo "# Add: userlist_file=/etc/vsftpd.userlist" | sudo tee -a /etc/vsftpd.conf 
# No -> only listed users allowed access; YES -> listed users denied access 
echo "# Add: userlist_deny=NO" | sudo tee -a /etc/vsftpd.conf 
#
# Banner
sed -i 's/ftpd_banner/#ftpd_banner/g' /etc/vsftpd.conf 
echo "ftpd_banner=Welcome to the FTP service." | sudo tee -a /etc/vsftpd.conf 
#
## Enable TTL/SSL
#
echo "# Change: #rsa_cert_file=/etc/ssl/certs/ssl-cert-snakeoil.pem" | sudo tee -a /etc/vsftpd.conf 
echo "# Change: #rsa_private_key_file=/etc/ssl/private/ssl-cert-snakeoil.key" | sudo tee -a /etc/vsftpd.conf 
echo "# Add: rsa_cert_file=/etc/ssl/private/vsftpd.pem" | sudo tee -a /etc/vsftpd.conf  
echo "# Add: rsa_private_key_file=/etc/ssl/private/vsftpd.pem" | sudo tee -a /etc/vsftpd.conf 
#
echo "# Change: ssl_enable=YES" | sudo tee -a /etc/vsftpd.conf 
#
# Deny anonymous SSL connections & require SSL for both data transfer and logins
echo "# Add: allow_anon_ssl=NO" | sudo tee -a /etc/vsftpd.conf 
echo "# Add: force_local_data_ssl=YES" | sudo tee -a /etc/vsftpd.conf 
echo "# Add: force_local_logins_ssl=YES" | sudo tee -a /etc/vsftpd.conf 
# Use TLS, not SSL
echo "# Add: ssl_tlsv1=YES" | sudo tee -a /etc/vsftpd.conf 
echo "# Add: ssl_sslv2=NO" | sudo tee -a /etc/vsftpd.conf 
echo "# Add: ssl_sslv3=NO" | sudo tee -a /etc/vsftpd.conf 
#
echo "# Add: require_ssl_reuse=NO" | sudo tee -a /etc/vsftpd.conf 
echo "# Add: ssl_ciphers=HIGH" | sudo tee -a /etc/vsftpd.conf 

#
#sudo systemctl restart vsftpd
#
















