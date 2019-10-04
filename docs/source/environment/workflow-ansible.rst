.. _environment-workflow-ansible:

Workflow: Ansible
=================

This workflow describes configuring a simple HPC environment with Ansible, consisting of:

- Shared NFS directories for users, data and applications
- SLURM queuing system for workload processing and management
- Flight Env for managing configurationg and applications available in the environment

Prequisites
-----------

This document presumes the following situation:

- The cluster has a gateway node (for running various servers)
- The cluster has multiple compute nodes (for executing jobs)
- DNS is correctly configured to allow hostname connections between the nodes
- Firewall connections between the gateway and compute nodes are open to allow various services to communicate (e.g. queuing system, nfs, etc)
- SSH keys are correctly configured to allow the gateway to login to nodes

Configure Environment
---------------------

- Install ansible::

    yum install -y ansible


- Create hosts file::

    cat << EOF > /etc/ansible/hosts
    [gateway]
    gateway1

    [compute]
    node01
    node02
    EOF


- Setup playbook::

    yum install -y git
    git clone https://github.com/openflighthpc/openflight-ansible-playbook

- Modify group variables and scripts to fit your scenario

- Run playbook::

    cd openflight-ansible-playbook
    ansible-playbook openflight.yml

