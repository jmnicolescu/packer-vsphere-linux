#!/bin/sh

#--------------------------------------------------------------------------------------
# CentOS 7 - First set of OS customization 
#          - Install PowerShell
#            https://github.com/PowerShell/PowerShell
#            https://github.com/PowerShell/PowerShell/releases/download/v7.0.3/powershell-7.0.3-1.rhel.7.x86_64.rpm
#--------------------------------------------------------------------------------------

# wget https://packages.microsoft.com/config/rhel/7/prod.repo -O /etc/yum.repos.d/microsoft.repo
# ls -al /etc/yum.repos.d/microsoft.repo

rpm -Uvh https://packages.microsoft.com/config/centos/7/packages-microsoft-prod.rpm

# Install the .NET Core SDK
yum -y install dotnet-sdk-3.1

# Install the ASP.NET Core runtime
yum -y install aspnetcore-runtime-3.1

# Install the .NET Core runtime
yum -y install dotnet-runtime-3.1

# PowerShell is no longer available from Microsoft repo
# yum -y install powershell
# yum update powershell

# Installation via Direct Download - CentOS 7
wget https://github.com/PowerShell/PowerShell/releases/download/v7.0.3/powershell-7.0.3-1.rhel.7.x86_64.rpm
rpm -ivh ./powershell-7.0.3-1.rhel.7.x86_64.rpm
rm -f ./powershell-7.0.3-1.rhel.7.x86_64.rpm

cat << EOF > /root/configure_powercli.ps1
Set-PSRepository -Name "PSGallery" -InstallationPolicy "Trusted"
Find-Module "VMware.PowerCLI" | Install-Module -Scope "AllUsers" -AllowClobber
Get-Module "VMware.PowerCLI" -ListAvailable | FT -Autosize
Get-Module "VMware.*" -ListAvailable | FT -Autosize
Update-Module "VMware.PowerCLI"
Import-Module "VMware.PowerCLI"
Set-PowerCLIConfiguration -InvalidCertificateAction "Ignore" -Confirm:\$false 
Set-PowerCLIConfiguration -Scope User -ParticipateInCEIP \$false -Confirm:\$false
EOF

/bin/pwsh /root/configure_powercli.ps1

#--------------------------------------------------------------------------------------
# Install PowerNSX
# To install for all users (requires PowerShell Run as Administrator):
#--------------------------------------------------------------------------------------

cat << EOF > /root/configure_powernsx.ps1
Find-Module "PowerNSX" | Install-Module -Scope "AllUsers" -AllowClobber      
Get-Module "PowerNSX" -ListAvailable | FT -Autosize
Update-Module "PowerNSX"
Import-Module "PowerNSX"
EOF
/bin/pwsh /root/configure_powernsx.ps1

#--------------------------------------------------------------------------------------
# Install PowervRNI
# To install for all users (requires PowerShell Run as Administrator):
#--------------------------------------------------------------------------------------

cat << EOF > /root/configure_powervrni.ps1
Find-Module "PowervRNI" | Install-Module -Scope "AllUsers"       
Get-Module "PowervRNI" -ListAvailable | FT -Autosize
Update-Module "PowervRNI"
Import-Module "PowervRNI"
EOF
/bin/pwsh /root/configure_powervrni.ps1

# Manual Download
# Invoke-WebRequest -Uri "https://raw.githubusercontent.com/powervrni/powervrni/master/PowervRNI.psm1" -OutFile "PowervRNI.psm1" 
# Invoke-WebRequest -Uri "https://raw.githubusercontent.com/powervrni/powervrni/master/PowervRNI.psd1" -OutFile "PowervRNI.psd1" 
# Import-Module .\PowervRNI.psd1
