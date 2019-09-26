#!/bin/bash
#FLIGHTdescription: Configure NFS client
#FLIGHTrole: nodes

SERVER="gateway1"

yum -y install nfs-utils

MOUNTS=`cat << EOF
$SERVER:/export/apps   /opt/apps   nfs     intr,rsize=32768,wsize=32768,vers=3,_netdev     0 0
$SERVER:/export/data   /data   nfs     intr,rsize=32768,wsize=32768,vers=3,_netdev     0 0
$SERVER:/export/service   /opt/service   nfs     intr,rsize=32768,wsize=32768,vers=3,_netdev     0 0
$SERVER:/export/site   /opt/site   nfs     intr,rsize=32768,wsize=32768,vers=3,_netdev     0 0
$SERVER:/home   /home   nfs     intr,rsize=32768,wsize=32768,vers=3,_netdev     0 0
EOF`

echo "$MOUNTS" >> /etc/fstab

mkdir -p /data /opt/apps /opt/service /opt/site


systemctl enable nfs
systemctl restart nfs

mount -a

ln -s /home /users
