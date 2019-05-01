.. _openflighthpc-cloud-reference:

openFlightHPC Cloud: Reference
==============================

.. include:: /platform/partials/workflow-install.rst

.. include:: /platform/partials/workflow-import.rst

Clusters
--------

Add Cluster
^^^^^^^^^^^

Create a new cluster with the init command::

    [root@myhost ~]# flight cloud aws cluster init mycluster
    Created cluster: mycluster

Change Cluster
^^^^^^^^^^^^^^

To select a different cluster::

    [root@myhost ~]# flight cloud aws cluster switch mycluster
      default
    * mycluster

List Clusters
^^^^^^^^^^^^^

List the available clusters as follows::

    [root@myhost ~]# flight cloud aws list clusters
      default
    * mycluster

The cluster with ``*`` next to it is the currently selected cluster.

Deployment
----------

Create Deployment
^^^^^^^^^^^^^^^^^

To create cloud resources, run the following::

    [root@myhost ~]# flight cloud aws deploy mydomain /opt/flight/tools/cloud/examples/aws/domain.yaml
    Deploying: /opt/flight/tools/cloudware/var/aws/clusters/default/lib/templates/domain/domain.yaml
    [┴] Deploying resources...

.. note:: Replacing ``DEPLOYMENT_NAME`` with a name for the resource collection and ``TEMPLATE_PATH`` with the full/relative path to cloud template.

List Deployments
^^^^^^^^^^^^^^^^

To show the existing deployments::

    [root@myhost ~]# flight cloud aws list deployments
    Deployment: ‘mydomain’
    Creation Date: 2019-03-19 14:04:15 +0000
    Template: /opt/flight/tools/cloudware/var/aws/clusters/default/lib/templates/domain/domain.yaml

      Results
      ● securitygroup: sg-0df183dfcf0087795
      ● network1SubnetID: subnet-0ff88fe5109be363f
      ● networkID: vpc-0175f3et48b9f16a1

      Replacements
      ● deployment_name: mydomain

The information provided for each deployment includes both the input and output parameters.

Destroy Deployment
^^^^^^^^^^^^^^^^^^

To destroy an existing deployment::

    [root@myhost ~]# flight cloud aws destroy mydomain
    [┬] Destroying resources... Done

Listing
-------

Templates
^^^^^^^^^

To list the available templates::

    [root@myhost ~]# flight cloud aws list templates
    domain
    domain/domainandallnodes
    group/login
    group/nodes
    group/orphan
    node/gateway1
    node/node01
    node/node02

Nodes
^^^^^

To list nodes that have been deployed with Cloud::

    [root@myhost ~]# flight cloud aws list machines
    Machine: ‘node01’
    ● ID: i-0451e9f0c287a7bec
    ● groups: nodes

Power
-----

Status
^^^^^^

To check the power status of a node::

    [root@myhost ~]# flight cloud aws power status node01
    node01: running

.. note:: Instead of a nodename, use ``-g groupname`` to run the power command across all nodes in ``groupname``.

Start
^^^^^

To power on a node::

    [root@myhost ~]# flight cloud aws power on node01
    Turning node01 on

Stop
^^^^

To power off a node::

    [root@myhost ~]# flight cloud aws power off node01
    Turning node01 off

