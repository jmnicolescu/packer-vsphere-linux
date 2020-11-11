#!/bin/sh

#--------------------------------------------------------------------------------------
# CentOS 7 - First set of OS customization 
#          - Install Packer and Terraform
#--------------------------------------------------------------------------------------


wget https://releases.hashicorp.com/packer/1.6.5/packer_1.6.5_linux_amd64.zip
unzip ./packer_1.6.5_linux_amd64.zip
chmod 755 ./packer
mv ./packer /usr/local/bin/packer
rm -f /packer_1.6.5_linux_amd64.zip

wget https://releases.hashicorp.com/terraform/0.13.5/terraform_0.13.5_linux_amd64.zip
unzip ./terraform_0.13.5_linux_amd64.zip 
chmod 755 ./terraform
mv ./terraform /usr/local/bin/terraform
rm -f ./terraform_0.13.5_linux_amd64.zip
