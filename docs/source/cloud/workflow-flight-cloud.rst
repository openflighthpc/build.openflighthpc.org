.. _platform-workflow-flight-cloud:

Workflow: Flight Cloud
======================

.. include:: /cloud/partials/workflow-prerequisites.rst

.. include:: /cloud/partials/workflow-install.rst

Create Cluster
--------------

Create an Azure cluster::

    [root@myhost ~]# bin/cloud cluster init mycluster azure

.. note:: This guide has been prepared using azure but Flight Cloud also supports AWS

Create Domain
-------------

Import the domain template::

    [root@myhost ~]# bin/cloud domain create /opt/flight/templates/azure/domain.json

Deploy the domain with::

    [root@myhost ~]# bin/cloud domain deploy
    [└] Deploying domain..

Wait until the deployment has completed before moving on to the gateway.

Deploy Gateway
--------------

Import the node template::

    [root@myhost ~]# bin/cloud node create gateway1 /opt/flight/templates/azure/node.json

Deploy the gateway with::

    [root@myhost ~]# bin/cloud node deploy gateway1 "nodename=gateway1 \
    networkSubnetID,networkSecurityGroupID=*domain \
    sshPublicKey='SSH_PUBLIC_KEY_HERE' \
    sourceimage='SOURCE_IMAGE_PATH_HERE'"
    [└] Deploying gateway1..

.. note:: The network subnet and security group IDs are gathered from the outputs of the domain deployment using the ``*domain`` reference

Deploy Compute Nodes
--------------------

Import the node template for node01::

    [root@myhost ~]# bin/cloud node create node01 /opt/flight/templates/azure/node.json

Deploy node01 with::

    [root@myhost ~]# bin/cloud node deploy node01 "nodename=node01 \
    networkSubnetID,networkSecurityGroupID=*domain \
    sshPublicKey='SSH_PUBLIC_KEY_HERE' \
    sourceimage='SOURCE_IMAGE_PATH_HERE'"
    [└] Deploying node01..

