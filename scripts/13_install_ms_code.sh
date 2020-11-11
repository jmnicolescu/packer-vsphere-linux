#!/bin/sh

#--------------------------------------------------------------------------------------
# CentOS 7 - First set of OS customization 
#          - Install MS Code
#--------------------------------------------------------------------------------------

rpm --import https://packages.microsoft.com/keys/microsoft.asc

cat << EOF > /etc/yum.repos.d/vscode.repo
[code]
name=Visual Studio Code
baseurl=https://packages.microsoft.com/yumrepos/vscode
enabled=1
gpgcheck=1
gpgkey=https://packages.microsoft.com/keys/microsoft.asc
EOF

yum -y install code

#--------------------------------------------------------------------------------------
# CentOS 7 - First set of OS customization 
#          - Download and install the latest git
#--------------------------------------------------------------------------------------

yum -y install openssl openssl-libs openssl-devel expat expat-devel

export VER="2.27.0"
wget https://github.com/git/git/archive/v${VER}.tar.gz

tar -xvf v${VER}.tar.gz
cd git-${VER}
make configure
./configure --prefix=/usr/local
make all
make install