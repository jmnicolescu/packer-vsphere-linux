#!/bin/sh

#--------------------------------------------------------------------------------------
# CentOS 7 - First set of OS customization 
#          - Cleanul GNOME
#--------------------------------------------------------------------------------------

# Disable sleep mode
systemctl mask sleep.target suspend.target hibernate.target hybrid-sleep.target 
echo "IdleAction=ignore" >> /etc/systemd/logind.conf 

# Disable the GNOME desktop screen lock
gsettings set org.gnome.desktop.session idle-delay 0

# Disable the GNOME desktop screen lock
gsettings set org.gnome.desktop.session idle-delay 0
systemctl disable initial-setup-text
systemctl disable initial-setup-graphical
