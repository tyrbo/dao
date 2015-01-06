#
# Simple vagrant image
#

Vagrant.configure("2") do |config|
  cpus = 1 
  memory = 1024
  autostart = "off" # switch to on to ensure the vm stays up across host reboots
  config.vm.box = "chef/centos-6.5"
  #config.vm.hostname = "foo"

  # You probably want to tweak this, https://docs.vagrantup.com/v2/networking/public_network.html
  # config.vm.network "public_network"
  #config.vm.network "public_network", bridge: 'en0: Wi-Fi (AirPort)'
  # config.vm.network "private_network", ip: "192.168.255.1"
  #config.vm.network "forwarded_port", guest: 80, host: 8180

  # If you want any special yum repositories, drop them in repo_files
  config.vm.synced_folder "repo_files", "/home/vagrant/repo_files", create:true
  config.vm.provision "shell", inline: "yum -y install http://mirror.pnl.gov/epel/6/i386/epel-release-6-8.noarch.rpm"
  config.vm.provision "shell", inline: "cp ~vagrant/repo_files/*.repo /etc/yum.repos.d"

  # Any extra scripts you want to run drop them here/invoke below
  config.vm.synced_folder "scripts", "/home/vagrant/scripts", create:true

  config.vm.provider :virtualbox do |vb|
    vb.gui = false
    vb.customize ["modifyvm", :id, "--cpus", "#{cpus}"]
    vb.customize ["modifyvm", :id, "--memory", "#{memory}"]
    vb.customize ["modifyvm", :id, "--autostart-enabled", "#{autostart}"]
  end
end
