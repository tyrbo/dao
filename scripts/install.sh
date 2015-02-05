echo 'other_args="--bip 10.1.1.1/24 -H 0.0.0.0:2376 -G docker"' >> /etc/sysconfig/docker
yum -y update
yum -y install kernel-devel-$(uname -r) kernel-headers-$(uname -r) dkms perl
/etc/init.d/vboxadd setup
yum -y install device-mapper-event-libs
yum -y install docker-io
service docker start
chkconfig docker on
