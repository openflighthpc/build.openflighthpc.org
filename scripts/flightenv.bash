#!/bin/bash
#FLIGHTdescription: Install Flight Environment
#FLIGHTroles: gateway,node

yum install -y https://openflighthpc.s3-eu-west-1.amazonaws.com/repos/openflight/x86_64/openflighthpc-release-1-1.noarch.rpm
yum install -y https://alces-flight.s3-eu-west-1.amazonaws.com/repos/alces-flight/x86_64/alces-flight-release-1-1.noarch.rpm

#
# Flight Starter
#
yum install -y flight-starter

#
# Flight Environment
#
yum -y install flight-env flight-desktop

# Set cluster name
/opt/flight/bin/flight config set cluster.name mycluster

# Install VTE for srun over terminal
yum install -y vte vte-profile

# Create genders file
cat << EOF > /opt/flight/etc/genders
node[01-02]    nodes,compute
EOF
