.. _power-workflow-azure:

Workflow: Azure
===============

This workflow is based on setting up the power server and client for an Azure cluster created as explained in :ref:`the Cloud Azure Workflow <cloud-workflow-azure>`

Server Setup
------------

.. include:: /power/partials/workflow-server-install.rst

Add Nodes
^^^^^^^^^

Nodes are added to the topology file at ``/opt/flight/etc/power-server/topology.yaml``, below is an example of the node configuration for a simple 3 node cluster consisting of a gateway and two compute nodes::

    static_nodes:
      gateway1:
        platform: azure
        resource_group: mycluster-gateway1
      node01:
        platform: azure
        resource_group: mycluster-node01
      node02:
        platform: azure
        resource_group: mycluster-node02

.. include:: /power/partials/workflow-server-common.rst

Client Setup
------------

.. include:: /power/partials/workflow-client-install.rst

.. include:: /power/partials/workflow-client-common.rst

