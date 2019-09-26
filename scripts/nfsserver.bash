#!/bin/bash
#FLIGHTdescription: Configure NFS server
#FLIGHTrole: gateway

# Variables
SERVER="gateway1"
CLUSTER_NETWORK="10.10.0.0"
CLUSTER_NETMASK="255.255.0.0"

yum -y install nfs-utils

# Create export directories
mkdir -p /export/apps
mkdir -p /export/data
mkdir -p /export/service
mkdir -p /export/site

# Increase nfsd thread count
sed -ie "s/^#\RPCNFSDCOUNT.*$/\RPCNFSDCOUNT=32/g" /etc/sysconfig/nfs

EXPORTOPTS="$CLUSTER_NETWORK/$CLUSTER_NETMASK(rw,no_root_squash,sync)"

EXPORTS=`cat << EOF
/export/apps "$EXPORTOPTS"
/export/data "$EXPORTOPTS"
/export/service "$EXPORTOPTS"
/export/site "$EXPORTOPTS"
/home "$EXPORTOPTS"
EOF`

echo "$EXPORTS" > /etc/exports

firewall-cmd --add-service nfs --add-service mountd --add-service rpc-bind --zone external --permanent
firewall-cmd --reload

MOUNTS=`cat << EOF
$SERVER:/export/apps   /opt/apps   nfs     intr,rsize=32768,wsize=32768,vers=3,_netdev     0 0
$SERVER:/export/data   /data   nfs     intr,rsize=32768,wsize=32768,vers=3,_netdev     0 0
$SERVER:/export/service   /opt/service   nfs     intr,rsize=32768,wsize=32768,vers=3,_netdev     0 0
$SERVER:/export/site   /opt/site   nfs     intr,rsize=32768,wsize=32768,vers=3,_netdev     0 0
EOF`

echo "$MOUNTS" >> /etc/fstab

mkdir -p /data /opt/apps /opt/service /opt/site

systemctl enable nfs
systemctl restart nfs

exportfs -va

mount -a

ln -s /home /users
