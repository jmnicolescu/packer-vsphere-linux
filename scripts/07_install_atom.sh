#!/bin/sh

#--------------------------------------------------------------------------------------
# CentOS 7 - First set of OS customization 
#          - Install atom
#--------------------------------------------------------------------------------------

# wget https://github.com/atom/atom/releases/download/v1.52.0/atom.x86_64.rpm
# wget https://github.com/atom/atom/releases/download/v1.50.0/atom.x86_64.rpm
wget https://github.com/atom/atom/releases/download/v1.46.0/atom.x86_64.rpm
yum -y localinstall ./atom.x86_64.rpm
rm -f ./atom.x86_64.rpm

# rpm --import https://packagecloud.io/AtomEditor/atom/gpgkey
# cat << EOF > /etc/yum.repos.d/atom.repo
# [Atom]
# name=Atom Editor
# baseurl=https://packagecloud.io/AtomEditor/atom/el/7/$basearch
# enabled=1
# gpgcheck=0
# repo_gpgcheck=1
# gpgkey=https://packagecloud.io/AtomEditor/atom/gpgkey
# EOF
# yum --nogpgcheck -y install atom.x86_64

