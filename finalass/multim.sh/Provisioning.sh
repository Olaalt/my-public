#!/bin/bash

set -e

vagrant ssh master <<EOF
    sudo useradd -m -G sudo altschool
    echo -e "4040\n4040\" | sudo passwd altschool 
    sudo usermod -a -G root altschool
    sudo useradd -ou 0 -g 0 altschool
    sudo -u altschool ssh-keygen -t rsa -b 4096 -f /home/altschool/.ssh/id_rsa -N "" -y
    sudo cp /home/altschool/.ssh/id_rsa.pub altschoolkey
    sudo ssh-keygen -t rsa -b 4096 -f /home/vagrant/.ssh/id_rsa -N ""
    sudo cat /home/vagrant/.ssh/id_rsa.pub | sshpass -p "vagrant" ssh -o StrictHostKeyChecking=no vagrant@192.168.56.3 'mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys'
    sudo cat ~/altschoolkey | sshpass -p "vagrant" ssh vagrant@192.168.56.3 'mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys'
    sshpass -p "4040" sudo -u altschool mkdir -p /mnt/altschool/slave
    sshpass -p "4040" sudo -u altschool scp -r /mnt/* vagrant@192.168.56.3:/home/vagrant/mnt
    sudo ps aux > /home/vagrant/running_processes
    exit
EOF


vagrant ssh master <<EOF

echo  "Updating Apt Packages and upgrading latest patches"
sudo apt update -y

sudo apt install apache2 -y

echo  "Adding firewall rule to Apache"
sudo ufw allow in "Apache"

sudo ufw status

echo "Installing MySQL"
sudo apt install mysql-server -y

echo  "Permissions for /var/www"
sudo chown -R www-data:www-data /var/www
echo "Permissions have been set"

sudo apt install php libapache2-mod-php php-mysql -y

echo  "Enabling Modules"
sudo a2enmod rewrite
sudo phpenmod mcrypt

sudo sed -i 's/DirectoryIndex index.html index.cgi index.pl index.xhtml index.htm/DirectoryIndex index.php index.html index.cgi index.pl index.xhtml index.htm/' /etc/apache2/mods-enabled/dir.conf

echo  "Restarting Apache"
sudo systemctl reload apache2

echo  "LAMP Installation Completed"

exit 0

EOF

vagrant ssh slave_1 <<EOF

cho  "Updating Apt Packages and upgrading latest patches"
sudo apt update -y

sudo apt install apache2 -y

echo  "Adding firewall rule to Apache"
sudo ufw allow in "Apache"

sudo ufw status

echo "Installing MySQL"
sudo apt install mysql-server -y

echo  "Permissions for /var/www"
sudo chown -R www-data:www-data /var/www
echo "Permissions have been set"

sudo apt install php libapache2-mod-php php-mysql -y

echo  "Enabling Modules"
sudo a2enmod rewrite
sudo phpenmod mcrypt

sudo sed -i 's/DirectoryIndex index.html index.cgi index.pl index.xhtml index.htm/DirectoryIndex index.php index.html index.cgi index.pl index.xhtml index.htm/' /etc/apache2/mods-enabled/dir.conf

echo  "Restarting Apache"
sudo systemctl reload apache2

echo  "LAMP Installation Completed"

exit 0
EOF
   


