#
### Install SSH
#sudo apt-get install -y openssh-server 
#
#
### Save defaults
#sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.orig  
#sudo chmod a-w /etc/ssh/sshd_config.orig 
#
#
### Firewall
sudo ufw deny 22 comment 'SSH Default Port' 
sudo ufw allow 2222 
sudo ufw limit 2222
sudo ufw reload 
#
#
### Edit /etc/ssh/sshd_config:  
#
## Change SSH Port
sudo sed -i 's/Port 22/#Port 22/g' /etc/ssh/sshd_config 
echo "Port 2222" | sudo tee -a /etc/ssh/sshd_config 
#
## Disable Root Login
sudo sed -i 's/PermitRootLogin/#PermitRootLogin/g' /etc/ssh/sshd_config 
echo "PermitRootLogin no" | sudo tee -a /etc/ssh/sshd_config 
#
## LoginGraceTime 1m
sudo sed -i 's/LoginGraceTime/#LoginGraceTime/g' /etc/ssh/sshd_config 
echo "LoginGraceTime 45" | sudo tee -a /etc/ssh/sshd_config 
#
#
sudo sed -i 's/MaxStartups/#MaxStartups/g' /etc/ssh/sshd_config 
echo "MaxStartups 10:30:60" | sudo tee -a /etc/ssh/sshd_config 
#
sudo sed -i 's/PasswordAuthentication/#PasswordAuthentication/g' /etc/ssh/sshd_config 
echo "PasswordAuthentication no" | sudo tee -a /etc/ssh/sshd_config 
sudo sed -i 's/UsePAM/#UsePAM/g' /etc/ssh/sshd_config  
echo "UsePAM no" | sudo tee -a /etc/ssh/sshd_config 
#
## Allow/Deny Users/Groups
echo "DenyUsers admin root" | sudo tee -a /etc/ssh/sshd_config
echo "DenyGroups admin root" | sudo tee -a /etc/ssh/sshd_config
echo "AllowUsers user1" | sudo tee -a /etc/ssh/sshd_config 
echo "AllowGroups user1" | sudo tee -a /etc/ssh/sshd_config
#
## Seconds before Server sends checkalive  
echo "ClientAliveInterval 300" | sudo tee -a /etc/ssh/sshd_config 
## Number of checkalives sent by server without response
echo "ClientAliveCountMax 3" | sudo tee -a /etc/ssh/sshd_config 
#
#
### Add Login Banner
sudo mkdir -m 744 /etc/banner/
sudo touch /etc/banner/ssh_banner
sudo chmod 0644 /etc/banner/ssh_banner
sed -i 's/Banner/#Banner/g' /etc/ssh/sshd_config   
echo "Banner /etc/banner/ssh_banner" | sudo tee -a /etc/ssh/sshd_config 
echo "Fáilte! Welcome! Wilkommen! Bienvenue! Bienvenido! Poteryannyye rossiyane!" | sudo tee -a /etc/banner/ssh_banner
#
#
### Setup SSH Public Key Folder
sudo mkdir /home/user1/.ssh
sudo chmod 700 /home/user1/.ssh 
sudo touch /home/user1/.ssh/authorized_keys
sudo chmod 0600 /home/user1/.ssh/authorized_keys
sudo chown user1:user1 ~/.ssh -R
sudo sed -i 's/#AuthorizedKeysFile/AuthorizedKeysFile/g' /etc/ssh/sshd_config
echo "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAgUNx8yFpe/AEisVpZvsWb2ublES0wZ862ZMw0GcrR+v9D9GhAU8SG7mrYvGff1D+WNvgLEXr4C119vA6OUkXP8Pzme3CvDcDUJOXBjtlEJpqpKaYJqbt7ldeu7HrRI2qAMhX7Mmratfib07rXyXKCfzpUBOKozYbopsrvK7axyKl7H5J8ezLrDZgEXv9SJyAypuHzuSpGHSWe3pKFYh/RKjyOHDTZ83LHliBKnWofBRaWgckKthw2dqpJpGemEQVttZKjRKAgPw7UOHFoHEKVEix8BiTvp85LFXDc43mAr/ZACqBV3ipCsb+AtydFjAfWoFQg0gYkx89I5JPmbeTfQ== ubuntu-ssh" | sudo tee /home/user1/.ssh/authorized_keys
#
#
### Restart/Reload
sudo systemctl restart ssh
#

