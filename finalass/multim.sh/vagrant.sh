#!/bin/bash

vagrant init ubuntu/focal64

cat <<EOF > Vagrantfile
Vagrant.configure("2") do |config|

  config.vm.define "bimslave" do |bimslave|

    bimslave.vm.hostname = "bimslave"
    bimslave.vm.box = "ubuntu/focal64"
    bimslave.vm.network "private_network", ip: "192.168.56.3"

    bimslave.vm.provision "shell", inline: <<-SHELL
    sudo apt-get update && sudo apt-get upgrade -y
    sudo apt install sshpass -y
    sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
    sudo systemctl restart sshd
    sudo apt-get install -y avahi-daemon libnss-mdns
    SHELL
  end

  config.vm.define "master" do |master|

    master.vm.hostname = "master"
    master.vm.box = "ubuntu/focal64"
    master.vm.network "private_network", ip: "192.168.56.4"

    master.vm.provision "shell", inline: <<-SHELL
    sudo apt-get update && sudo apt-get upgrade -y
    sudo apt-get install -y avahi-daemon libnss-mdns
    sudo apt install sshpass -y
   # sudo sed -i 's/PasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
   # sudo systemctl restart sshd
    SHELL
  end

    config.vm.provider "virtualbox" do |vb|
      vb.memory = "256"
      vb.cpus = "2"
    end
end
EOF

vagrant up

source provining.sh 


  

