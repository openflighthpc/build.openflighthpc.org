.. _power-workflow-aws:

Workflow: AWS
=============

This workflow is based on setting up the power server and client for an AWS cluster created as explained in :ref:`the Cloud AWS Workflow <cloud-workflow-aws>`

Server Setup
------------

.. include:: /power/partials/workflow-server-install.rst

Add Nodes
^^^^^^^^^

Nodes are added to the topology file at ``/opt/flight/etc/power-server/topology.yaml``, below is an example of the node configuration for a simple 3 node cluster consisting of a gateway and two compute nodes::

    static_nodes:
      gateway1:
        platform: aws
        ec2_id: i-0156df66d8030419e
        region: eu-west-1
      node01:
        platform: aws
        ec2_id: i-02ed5e1fa4bfaa1b1
        region: eu-west-1
      node02:
        platform: aws
        ec2_id: i-02cb20bc947148511
        region: eu-west-1

.. include:: /power/partials/workflow-server-common.rst


Client Setup
------------

.. include:: /power/partials/workflow-client-install.rst

.. include:: /power/partials/workflow-client-common.rst

