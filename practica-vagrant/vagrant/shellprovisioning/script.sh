#!/usr/bin/env bash
sudo apt-get update 
#sudo apt-get -y install apache2
sudo useradd -m -p sa5u2O0Xjsufg -s /bin/bash usuario
sudo echo "tmpfs /dev/shm tmpfs defaults,noexec,nosuid 0 0 " >> /etc/fstab
sudo apt-get -y install htop mc



