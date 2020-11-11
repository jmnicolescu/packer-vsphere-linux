#!/bin/sh

#--------------------------------------------------------------------------------------
# CentOS 7 - First set of OS customization 
#          - Configure ntp
#--------------------------------------------------------------------------------------

systemctl stop chronyd
systemctl disable chronyd
  
yum -y install ntp

systemctl start ntpd
systemctl enable ntpd

firewall-cmd --zone=public --add-port=123/udp --permanent
firewall-cmd --zone=public --add-port=123/tcp --permanent
firewall-cmd --reload
# firewall-cmd --list-ports | grep -i udp

#------------------------------------
# Create /etc/ntp.conf
#------------------------------------

cat << EOF > /etc/ntp.conf
driftfile /var/lib/ntp/ntp.drift

restrict default nomodify notrap nopeer noquery kod limited
restrict 192.168.111.0 netmask 255.255.255.0 nomodify notrap
restrict 127.0.0.1
restrict ::1

#server 0.centos.pool.ntp.org iburst
#server 1.centos.pool.ntp.org iburst
#server 2.centos.pool.ntp.org iburst
#server 3.centos.pool.ntp.org iburst

server 3.es.pool.ntp.org iburst
server 2.es.pool.ntp.org iburst
server 1.es.pool.ntp.org iburst
server 0.es.pool.ntp.org iburst

server 127.127.1.0
fudge 127.127.1.0 stratum 8
EOF

systemctl restart ntpd
# ntpq -p
# ntpdate -q `hostname`

