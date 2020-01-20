#!/bin/bash -e

# Variables
CLUSTER_INTERFACE="eth0"
CLUSTER_NETWORK="10.10.0.0"
CLUSTER_NETMASK="255.255.224.0"
CLUSTER_CIDR="$(ipcalc -p 1.1.1.1 $CLUSTER_NETMASK |sed 's/.*=//g')"

# Prerequisites
yum -y install vim httpd git

# Install cloud tools
## AWS
yum -y install awscli

## Azure
rpm --import https://packages.microsoft.com/keys/microsoft.asc
echo -e "[azure-cli]\nname=Azure CLI\nbaseurl=https://packages.microsoft.com/yumrepos/azure-cli\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/azure-cli.repo
yum install -y azure-cli

# Prepare HTTP server
cat << EOF > /etc/httpd/conf.d/deployment.conf
<Directory /opt/flight/deployment/>
    Options Indexes MultiViews FollowSymlinks
    AllowOverride None
    Require all granted
    Order Allow,Deny
    Allow from $CLUSTER_NETWORK/$CLUSTER_CIDR
</Directory>
Alias /deployment /opt/flight/deployment
EOF

mkdir -p /opt/flight/deployment
systemctl enable httpd

# Firewall config
systemctl enable firewalld

firewall-offline-cmd --new-zone cluster
firewall-offline-cmd --set-target=ACCEPT --zone cluster
firewall-offline-cmd --zone cluster --add-interface $CLUSTER_INTERFACE
firewall-offline-cmd --set-default-zone=external #so that we masquerade over our internet facing device
