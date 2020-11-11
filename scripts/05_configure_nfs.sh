#!/bin/sh

#--------------------------------------------------------------------------------------
# CentOS 7 - First set of OS customization 
#          - Configure nfs
#--------------------------------------------------------------------------------------
# MAC OSX # sudo mount -t nfs -o resvport,rw 192.168.111.111:/var/nfsshare /nfsshare

yum -y install nfs-utils

mkdir -p /var/nfsshare
chmod -R 755 /var/nfsshare
chown nfsnobody:nfsnobody /var/nfsshare
mkdir /var/nfsshare/ks /var/nfsshare/kslinux
chown juliusn:juliusn /var/nfsshare/ks /var/nfsshare/kslinux
ln -s /var/nfsshare /nfsshare

# Create /etc/exports

cat << EOF > /etc/exports
/var/nfsshare       *(rw,sync,insecure,no_root_squash,no_all_squash)
EOF

firewall-cmd --permanent --zone=public --add-service=nfs
firewall-cmd --permanent --zone=public --add-service=mountd
firewall-cmd --permanent --zone=public --add-service=rpc-bind
firewall-cmd --reload

# update /etc/sysconfig/nfs 
sed -i 's/^#RPCNFSDARGS.*/RPCNFSDARGS="-N2 -N3 -V4"/' /etc/sysconfig/nfs
sed -i 's/^RPCNFSDARGS.*/RPCNFSDARGS="-N2 -N3 -V4"/' /etc/sysconfig/nfs
sed -i 's/^#RPCNFSDCOUNT.*/RPCNFSDCOUNT=16"/' /etc/sysconfig/nfs
sed -i 's/^RPCNFSDCOUNT.*/RPCNFSDCOUNT=16"/' /etc/sysconfig/nfs

# Grant access for /var/nfsshare/ks -> htttp://hostname/ks
chcon -R -t httpd_sys_content_t /var/nfsshare

systemctl enable rpcbind
systemctl enable nfs-server
systemctl enable nfs-lock
systemctl enable nfs-idmap

systemctl start rpcbind
systemctl start nfs-server
systemctl start nfs-lock
systemctl start nfs-idmap

# Test NFS access
# showmount -e localhost
# showmount -e `hostname`
# mount -t nfs -o vers=4 `hostname`:/var/nfsshare /mnt
# umount /mnt
# mount -t nfs -o vers=3 `hostname`:/var/nfsshare /mnt
# umount /mnt

