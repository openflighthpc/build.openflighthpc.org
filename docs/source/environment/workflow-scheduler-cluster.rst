.. _environment-workflow-scheduler-cluster:

Workflow: Scheduler Cluster
===========================

This document will go through installing flight-manage, configuring system services to support the flight environment and configuring the environment itself.

Prerequisites
-------------

This document presumes the following situation:

- The cluster has a gateway node (for running various servers)
- The cluster has multiple compute nodes (for executing jobs)
- DNS is correctly configured to allow hostname connections between the nodes
- Firewall connections between the gateway and compute nodes are open to allow various services to communicate (e.g. queuing system, nfs, etc)

.. include:: /environment/partials/workflow-install.rst

.. include:: /environment/partials/workflow-scheduler-cluster.rst
