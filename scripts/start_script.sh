#!/bin/bash
### Update 
sudo apt-get -y update && sudo apt-get -y upgrade 
# 
sudo apt-get install curl
#
### Install Stuff
#
#Chrome 
wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
sudo sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' 
sudo apt-get -y update 
sudo apt-get install google-chrome-stable 
#Atom Editor
curl -L https://packagecloud.io/AtomEditor/atom/gpgkey | sudo apt-key add -
sudo sh -c 'echo "deb [arch=amd64] https://packagecloud.io/AtomEditor/atom/any/ any main" > /etc/apt/sources.list.d/atom.list'
sudo apt-get -y update
sudo apt-get install atom
#Brackets 
sudo add-apt-repository ppa:webupd8team/brackets
sudo apt-get -y update
sudo apt-get install brackets
#VS Code
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt-get -y update 
sudo apt-get install code
#
sudo add-apt-repository ppa:gnome-terminator 
sudo add-apt-repository ppa:ubuntu-desktop/ubuntu-make
#
sudo apt-get -y update 
sudo apt-get -y install ufw fail2ban vlc nautilus gedit chromium-browser gdebi gimp pinta unity-tweak-tool terminator caffeine ubuntu-make filezilla 
#
#
### Save defaults
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local 
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.orig 
sudo chmod a-w /etc/fail2ban/jail.orig 
sudo cp /etc/lightdm/lightdm.conf /etc/lightdm/lightdm.conf.orig
sudo chmod a-w /etc/lightdm/lightdm.conf.orig 
#
#
### Firewall 
sudo ufw enable
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw deny 22 comment 'SSH Default Port'
sudo ufw deny 23 comment 'Telnet' 
sudo ufw deny out 23 comment 'Telnet' 
sudo ufw reload
#
#
### Add Admin  
sudo adduser admin
sudo usermod -aG adm,cdrom,lpadmin,sudo,sambashare,dip,plugdev admin 
#
#
### Disable Guest Session:
echo "[SeatDefaults]" | sudo tee -a /etc/lightdm/lightdm.conf
echo "user-session=ubuntu" | sudo tee -a /etc/lightdm/lightdm.conf
echo "greeter-session=unity-greeter" | sudo tee -a /etc/lightdm/lightdm.conf
echo "allow-guest=false" | sudo tee -a /etc/lightdm/lightdm.conf
#
#
### Remove Admin from login: 
sudo touch /var/lib/AccountsService/users/admin
echo "[User]" | sudo tee -a /var/lib/AccountsService/users/admin
echo "SystemAccount=true" | sudo tee -a /var/lib/AccountsService/users/admin
#
sudo apt-get install kubuntu-desktop
#
### Restart/Reload 
sudo ufw reload 
#
#
