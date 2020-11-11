#!/bin/sh

#--------------------------------------------------------------------------------------
# CentOS 7 - First set of OS customization 
#          - Install and configure ansible
#          - Install Ansible on Linux for vSphere configuration
#--------------------------------------------------------------------------------------


yum -y install python3
yum -y install python3-setuptools
yum -y install python3-pip
alternatives --set python /usr/bin/python3

pip3 install ansible
pip3 install pyvmomi
pip3 install git+https://github.com/vmware/vsphere-automation-sdk-python.git
pip3 install jmespath

ansible localhost -m ping

pip3 install --upgrade ansible 
pip3 install --upgrade pip setuptools
pip3 install --upgrade git+https://github.com/vmware/vsphere-automation-sdk-python.git
pip3 install --upgrade jmespath

#yum install -y python-jmespath
#yum install -y python3-jmespath

