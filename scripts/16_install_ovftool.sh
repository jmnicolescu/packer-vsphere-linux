#!/bin/sh

#--------------------------------------------------------------------------------------
# CentOS 7 - First set of OS customization 
#          - Install ovftool
#--------------------------------------------------------------------------------------

wget http://192.168.111.111/ISO/VMware-ovftool-4.4.1-16812187-lin.x86_64.bundle
chmod 755 VMware-ovftool-4.4.1-16812187-lin.x86_64.bundle 
./VMware-ovftool-4.4.1-16812187-lin.x86_64.bundle  --eulas-agreed --required
