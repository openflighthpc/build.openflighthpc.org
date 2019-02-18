Initialise Cluster
------------------

Architect comes with a cluster profile named ``example`` which automates additional configuration steps such that the cluster will be prepared with:

- A gateway node
- 10 compute nodes

To create a new cluster, ``mycluster``, using the default ``example`` profile, simply (more information on the ``init`` command can be found at :ref:`openFlightHPC Architect Common Practices <architect-create-cluster>`)::

    [root@myhost ~]# flight underware cluster init mycluster
    Name of the cluster (1/6)
    mycluster
    Password to use for root user (2/6)
    *********
    Confirm password:
    *********
    Root user SSH key (in the format 'ssh-rsa <key data> user@host') (3/6)
    ssh-rsa MySSHkeyGoesHere1234567890 user@host
    Fully-qualified domain name for cluster nodes (4/6)  |<%= domain.config.cluster %>.cluster.local|

    Define a second network? (5/6) [yes/no]
    n
    Define a third network? (6/6) [yes/no]
    n
    aws: |================================================================================================================================|
    azure: |==============================================================================================================================|
    kickstart: |==========================================================================================================================|
    libvirt: |============================================================================================================================|
    vbox: |===============================================================================================================================|

The cluster has now been generated and all configuration files and templates can be found at ``/var/lib/architect/clusters/mycluster/`` (which mirrors the :ref:`source template directory structure <source-configuration-templates>`).

