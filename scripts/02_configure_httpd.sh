#!/bin/sh

#--------------------------------------------------------------------------------------
# CentOS 7 - First set of OS customization 
#          - Configure httpd
#--------------------------------------------------------------------------------------

yum -y install httpd

firewall-cmd --permanent --zone=public --add-service=http
firewall-cmd --permanent --zone=public --add-service=https
firewall-cmd --reload


## HTTPD config file  -- /etc/httpd/conf/httpd.conf
export HTTPD_config="/etc/httpd/conf/httpd.conf"
export DocumentRoot="/var/www/html"

#------------------------------------
# Create $DocumentRoot/index.html
#------------------------------------

cat << EOF > $DocumentRoot/index.html
<html>
<head>
<title> 2020 Lab Environment </title>
<body bgcolor = "#ffffcc" text = "#000000">
<p> 2020 Lab Environment </p>
<p>
<table  cellpadding = "2">
	<tbody>
		<tr>
			<td> DEV </td>
			<td> nat-web01 </td>
			<td> <a href="nat-web01.flexlab.local">http://nat-web01.flexlab.local</a></td>
		</tr>
		<tr>
			<td> DEV </td>
			<td> nat-app01 </td>
			<td> <a href="nat-app01.flexlab.local">http://nat-app01.flexlab.local</a></td>
		</tr>
		<tr>
			<td> DEV </td>
			<td> nat-db01 </td>
			<td> <a href="nat-db01.flexlab.local">http://nat-db01.flexlab.local</a></td>
		</tr>
	</tbody>
</table>
</p>
</body>
</html>
EOF

cat << EOF >> $HTTPD_config

Alias /ks /var/nfsshare/ks
<Directory /var/nfsshare/ks>
    Options Indexes MultiViews
    AllowOverride None
    Require all granted
    Order allow,deny
    Allow from all
</Directory>

Alias /ISO /var/nfsshare/ISO
<Directory /var/nfsshare/ISO>
    Options Indexes MultiViews
    AllowOverride None
    Require all granted
    Order allow,deny
    Allow from all
</Directory>

Alias /kslinux /var/nfsshare/kslinux
<Directory /var/nfsshare/kslinux>
    Options Indexes MultiViews
    AllowOverride None
    Require all granted
    Order allow,deny
    Allow from all
</Directory>
EOF

# Grant access for /var/nfsshare/ks -> htttp://antares/ks
mkdir -p /var/nfsshare
chcon -R -t httpd_sys_content_t /var/nfsshare

systemctl start httpd
systemctl enable httpd
systemctl status httpd

