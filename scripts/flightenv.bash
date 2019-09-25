#!/bin/bash
#FLIGHTdescription: Install Flight Environment
#FLIGHTroles: gateway,node

#
# Prerequisite
#
yum -y install git

#
# Flight Direct 
#
curl https://openflighthpc.s3-eu-west-1.amazonaws.com/repos/openflight/openflight.repo > /etc/yum.repos.d/openflight.repo
yum -y install flight-runway

#
# Flight Starter
#
git clone https://github.com/openflighthpc/flight-starter /tmp/flight-starter
cp -Rv /tmp/flight-starter/dist/* /
rm -rf /tmp/flight-starter

#
# Flight Environment
#
cd /opt/flight/opt
git clone https://github.com/alces-flight/flight-env flight-env
export HOME=/root
/opt/flight/bin/flintegrate /opt/flight/opt/flight-env

# Set cluster name
source /etc/profile.d/zz-flight-starter.sh
flight start
flight config set cluster.name mycluster

# Install VTE for srun over terminal
yum install -y vte vte-profile

# Create genders file
cat << EOF > /opt/flight/etc/genders
node[01-02]    nodes,compute
EOF
