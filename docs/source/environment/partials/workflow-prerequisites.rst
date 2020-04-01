Overview
--------

This workflow describes configuring a simple HPC environment, consisting of:

- Shared NFS directories for users, data and applications
- SLURM queuing system for workload processing and management
- Flight Env for managing configurationg and applications available in the environment

Prerequisites
-------------

This document presumes the following situation:

- The cluster has a gateway node (for running various servers)
- The cluster has multiple compute nodes (for executing jobs)
- DNS is correctly configured to allow hostname connections between the nodes
- Firewall connections between the gateway and compute nodes are open to allow various services to communicate (e.g. queuing system, nfs, etc)
- SSH keys are correctly configured to allow the gateway to login to nodes (as root)
- There is sufficient storage space on the gateway and compute nodes (for applications and data, recommended 16GB+)
