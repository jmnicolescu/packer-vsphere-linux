#!/bin/sh

#--------------------------------------------------------------------------------------
# CentOS 7 - First set of OS customization 
#          - Configure vnc
#--------------------------------------------------------------------------------------

yum -y install tigervnc-server

# Create vncpasswd
export myuser="juliusn"

mkdir /home/$myuser/.vnc
echo $myuser | vncpasswd -f > /home/$myuser/.vnc/passwd
chown -R $myuser:$myuser /home/$myuser/.vnc
chmod 0600 /home/$myuser/.vnc/passwd

cp /lib/systemd/system/vncserver@.service /lib/systemd/system/vncserver@.service.ORG
cd /etc/systemd/system

# update vncserver@:1.service
cat << EOF > /etc/systemd/system/vncserver@:1.service
[Unit]
Description=Remote desktop service (VNC)
After=syslog.target network.target

[Service]
Type=forking

# Clean any existing files in /tmp/.X11-unix environment
ExecStartPre=/bin/sh -c '/usr/bin/vncserver -kill :1 > /dev/null 2>&1 || :'
ExecStart=/sbin/runuser -l juliusn -c "rm -rf /tmp.X* ; /usr/bin/vncserver :1 -geometry 1920x1080"
PIDFile=/home/juliusn/.vnc/%H:1.pid
ExecStop=/bin/sh -c '/usr/bin/vncserver -kill :1 > /dev/null 2>&1 || :'

[Install]
WantedBy=multi-user.target
EOF

cp /etc/systemd/system/vncserver@:1.service /lib/systemd/system/vncserver@.service

firewall-cmd --permanent --zone=public --add-port=5901/tcp
firewall-cmd --permanent --zone=public --add-port=5901/tcp --permanent
firewall-cmd --permanent --zone=public --add-service vnc-server
firewall-cmd --reload

rm -rf /tmp/.X11-unix

systemctl daemon-reload
systemctl enable vncserver@:1.service 
# systemctl start vncserver@:1.service
# systemctl status vncserver@:1.service




