#!/bin/sh

#--------------------------------------------------------------------------------------
# CentOS 7 - First set of OS customization 
#          - Configure named
#--------------------------------------------------------------------------------------

yum -y install bind bind-utils

#
# Update named configuration files
#
# --> scp /etc/named
# cp /etc/named/named.conf /etc/named.conf
# cp /etc/named/named.rfc1912.zones /etc/named.rfc1912.zones

firewall-cmd --permanent --zone=public --add-service=dns
firewall-cmd --permanent --zone=public --add-port=53/udp
firewall-cmd --permanent --zone=public --add-port=53/tcp
firewall-cmd --reload
firewall-cmd --zone=public --list-all

systemctl start named
systemctl enable named
systemctl status named

#
# Test named
#
# named-checkzone flexlab.local /etc/named/fwd.flexlab.local.db
# named-checkzone totalsoft.com /etc/named/fwd.totalsoft.com.db
# named-checkzone 111.168.192.in-addr.arpa /etc/named/111.168.192.in-addr.arpa.db
# named-checkzone 112.168.192.in-addr.arpa /etc/named/112.168.192.in-addr.arpa.db

#
# Update /etc/resolv.conf
#

# vi /etc/NetworkManager/NetworkManager.conf
# And add this to the [main] section:
# dns=none

# nmcli con show --active
# nmcli connection show ens192
# nmcli con show --active | tail -1 | awk '{print $1}'

# nmcli con show --active
# nmcli con mod `nmcli con show --active | tail -1 | awk '{print $1}'` ipv4.dns "192.168.111.111 192.168.111.1"
# nmcli con mod `nmcli con show --active | tail -1 | awk '{print $1}'` ipv4.dns-search "flexlab.local"
# nmcli connection show `nmcli con show --active | tail -1 | awk '{print $1}'` | grep ipv4.dns
# systemctl restart NetworkManager
