#!/bin/bash
#FLIGHTdescription: Install SLURM controller
#FLIGHTrole: gateway 

# More info on Munge keys available here - https://github.com/dun/munge/wiki/Installation-Guide#creating-a-secret-key
MUNGEKEY=ReplaceWithRandomisedStringForMungeKey
SLURMCONF=`cat << EOF
ClusterName=mycluster
ControlMachine=gateway1
SlurmUser=nobody
SlurmctldPort=6817
SlurmdPort=6818
AuthType=auth/munge
StateSaveLocation=/var/spool/slurm.state
SlurmdSpoolDir=/var/spool/slurmd.spool
SwitchType=switch/none
MpiDefault=none
SlurmctldPidFile=/var/run/slurmctld.pid
SlurmdPidFile=/var/run/slurmd.pid
ProctrackType=proctrack/pgid
ReturnToService=2
SlurmctldTimeout=300
SlurmdTimeout=300
InactiveLimit=0
MinJobAge=300
KillWait=30
Waittime=0
SchedulerType=sched/backfill
SelectType=select/linear
FastSchedule=1
SlurmctldDebug=3
SlurmctldLogFile=/var/log/slurm/slurmctld.log
SlurmdDebug=3
SlurmdLogFile=/var/log/slurm/slurmd.log
JobCompType=jobcomp/none
NodeName=node[01-02]
PartitionName=all Nodes=ALL Default=YES MaxTime=UNLIMITED
EOF
`

# Setup repo
curl https://openflighthpc-compute.s3.eu-west-2.amazonaws.com/slurm/openflight-slurm.repo > /etc/yum.repos.d/openflight-slurm.repo

yum -y -e0 install epel-release
yum -y -e0 install munge munge-devel munge-libs perl-Switch numactl
yum --enablerepo flight -y -e 0 --nogpgcheck install slurm slurm-devel slurm-perlapi slurm-torque slurm-slurmd slurm-example-configs slurm-libpmi
yum -y -e0 install mariadb mariadb-test mariadb-libs mariadb-embedded mariadb-embedded-devel mariadb-devel mariadb-bench
yum --enablerepo flight -y --nogpgcheck install slurm-slurmctld 

systemctl enable mariadb
systemctl start mariadb

# Create spool directory
mkdir -p /var/spool/slurm.state
chown nobody:nobody /var/spool/slurm.state

echo $MUNGEKEY > /etc/munge/munge.key
chmod 400 /etc/munge/munge.key
chown munge /etc/munge/munge.key

systemctl enable munge
systemctl start munge

mkdir /var/log/slurm
chown nobody /var/log/slurm

echo "$SLURMCONF" > /etc/slurm/slurm.conf

systemctl enable slurmctld
systemctl start slurmctld
