# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/xenial64"
  config.disksize.size = "64GB"
  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
    apt-get install -y linux-virtual-hwe-16.04 docker.io
    usermod -aG docker vagrant
    install -d -m 777 -o root -g root /var/cache/flatpak
    systemctl reboot
  SHELL
end
