.. _openflighthpc-cloud-reference:

openFlightHPC Cloud: Reference
==============================

.. include:: /cloud/partials/workflow-install.rst

.. include:: /cloud/partials/workflow-import.rst

Clusters
--------

Add Cluster
^^^^^^^^^^^

Create a new cluster with the init command (replace ``aws`` with ``azure`` for creating and managing Azure clusters)::

    [root@myhost ~]# bin/cloud cluster init mycluster aws
    Created cluster: mycluster

Change Cluster
^^^^^^^^^^^^^^

To select a different cluster::

    [root@myhost ~]# bin/cloud cluster switch mycluster
      default
    * mycluster

List Clusters
^^^^^^^^^^^^^

List the available clusters as follows::

    [root@myhost ~]# bin/cloud list clusters
      default
    * mycluster

The cluster with ``*`` next to it is the currently selected cluster.

Deployment
----------

Create Deployment
^^^^^^^^^^^^^^^^^

To add a node cloud template as a deployment definition, run the following::

    [root@myhost ~]# bin/cloud create mynode /path/to/mynodetemplate

Deploy Resources
^^^^^^^^^^^^^^^^

To deploy cloud resources, run the following using a configured deployment::

    [root@myhost ~]# bin/cloud deploy mynode
    Please provide values for the following missing parameters:
    (Note: Use the format of '*<resource_name>' to reference a resource)
    securitygroup: *domain
    network1SubnetID: *domain
    [┴] Deploying node...

.. note:: If :ref:`parameters <cloud/openflighthpc-cloud:Parameter Substitution>` are present in the template and have not been provided at deployment time with ``-p`` then these shall be prompted for before deployment takes place.

List Deployments
^^^^^^^^^^^^^^^^

To show the existing deployments::

    [root@myhost ~]# bin/cloud list
    Deployment: ‘mynode’
    Creation Date: 2019-08-02 13:11:06 +0100
    Status: Running
    Provider Tag: cloudware-shared-mynode-03e94412ea
    Groups: login,all

      Results
      ● gateway1TAGgroups: login,all
      ● gateway1TAGIP: 34.242.121.209
      ● gateway1TAGID: i-0b62725c674b46818

      Replacements
      ● deployment_name: mynode
      ● securitygroup: *domain
      ● network1SubnetID: *domain


The information provided for each deployment includes both the input and output parameters. To show undeployed resources, add ``--all`` to the list command.

Destroy Deployment
^^^^^^^^^^^^^^^^^^

To destroy an existing deployment::

    [root@myhost ~]# bin/cloud destroy mynode
    [┬] Destroying node... Done

Power
-----

Status
^^^^^^

To check the power status of a node::

    [root@myhost ~]# bin/cloud power status mynode
    mynode: running

.. note:: Instead of a nodename, use ``-g groupname`` to run the power command across all nodes in ``groupname``.

Start
^^^^^

To power on a node::

    [root@myhost ~]# bin/cloud power on mynode
    Turning mynode on

Stop
^^^^

To power off a node::

    [root@myhost ~]# bin/cloud power off mynode
    Turning mynode off

