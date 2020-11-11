#!/bin/sh

#--------------------------------------------------------------------------------------
# CentOS 7 - First set of OS customization 
#          - Configure python
#--------------------------------------------------------------------------------------

yum -y install python3
yum -y install python3-setuptools
yum -y install python3-pip
alternatives --set python /usr/bin/python3

# Install pip
# curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
# python3.6 get-pip.py

pip3 install --upgrade pip setuptools

pip3 install flask
pip3 show --files flask

pip3 install requests
pip3 show --files requests