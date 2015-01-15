#
# Simple vagrant image
#

Vagrant.configure("2") do |config|
  cpus = 1 
  memory = 1024
  autostart = "off" # switch to on to ensure the vm stays up across host reboots
  config.vm.box = "chef/centos-6.5"

  config.vm.network "forwarded_port", guest: 2376, host: 2376
  config.vm.network "private_network", ip: "192.168.237.3"

  config.vm.provision "shell", inline: "yum -y install http://mirror.pnl.gov/epel/6/i386/epel-release-6-8.noarch.rpm"

  # Any extra scripts you want to run drop them here/invoke below
  config.vm.synced_folder "scripts", "/home/vagrant/scripts", create:true
  config.vm.synced_folder "/Users", "/Users"
  config.vm.provision "shell", path: "scripts/install.sh"

  config.vm.provider :virtualbox do |vb|
    vb.gui = false
    vb.customize ["modifyvm", :id, "--cpus", "#{cpus}"]
    vb.customize ["modifyvm", :id, "--memory", "#{memory}"]
    vb.customize ["modifyvm", :id, "--autostart-enabled", "#{autostart}"]
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  end
end
