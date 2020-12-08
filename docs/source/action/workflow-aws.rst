.. _action-workflow-aws:

Workflow: AWS
=============

This workflow is based on setting up the action server and client for an AWS cluster created as explained in :ref:`the Cloud AWS Workflow <cloud-workflow-aws>`.

Server Setup
------------

.. include:: /action/partials/workflow-server-install.rst

Install AWS CLI
^^^^^^^^^^^^^^^

For managing the power state of the nodes, the AWS CLI will need to be installed with::

    $ yum install awscli

Once installed, authenticate with AWS details::

    $ aws configure

Add Nodes
^^^^^^^^^

Nodes are added to the config file at ``/opt/flight/opt/action-api/config/nodes.yaml``, below is an example of the node configuration for a simple 3 node cluster consisting of a gateway and two compute nodes::

    gateway1:
      ranks: [aws]
      ec2_id: i-1234567890
      aws_region: eu-west-2
    node01:
      ranks: [aws]
      ec2_id: i-2345678901
      aws_region: eu-west-2
    node02:
      ranks: [aws]
      ec2_id: i-3456789012
      aws_region: eu-west-2

.. include:: /action/partials/workflow-server-common.rst


Client Setup
------------

.. include:: /action/partials/workflow-client-install.rst

.. include:: /action/partials/workflow-client-common.rst

