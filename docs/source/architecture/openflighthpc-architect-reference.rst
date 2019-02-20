.. _openflighthpc-architect-common-practices:

openFlightHPC Architect: Reference
==================================

.. include:: partials/workflow-install.rst

.. _openflighthpc-architect-cluster-ref:

Cluster
-------

Show Clusters
^^^^^^^^^^^^^

Show a cluster::

    [root@myhost ~]# flight architect cluster list
    * mycluster
      yourcluster
      anothercluster

.. note:: The cluster with the asterisk is the currently selected cluster for Architect to work on.

.. _architect-create-cluster:

Create Cluster
^^^^^^^^^^^^^^

Create a cluster:: 

    [root@myhost ~]# flight architect cluster init cluster_name

.. note:: The ``init`` command will always use the ``example`` cluster profile unless either ``--bare`` (which will copy ``<architect home>/data/base`` only) or ``--profile another_profile_name`` (where ``another_profile_name`` corresponds to a directory in ``<architect home>/data/``) are provided as arguments.

Change Cluster
^^^^^^^^^^^^^^

Switch to cluster named ``yourcluster``::

    [root@myhost ~]# flight architect cluster switch yourcluster
      mycluster
    * yourcluster
      anothercluster

Delete Cluster
^^^^^^^^^^^^^^

Delete cluster named ``anothercluster``::

    [root@myhost ~]# flight underware cluster delete anothercluster
    Are you sure you want to delete 'anothercluster' (y/n)?
    y

.. note:: The currently selected cluster cannot be deleted. Switch to another cluster (e.g. ``default``) and then run the delete command.

.. _architect-configure-cluster:

Configure
---------

Updating Domain Configuration
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Ask questions at the domain-level for a cluster::

    [root@myhost ~]# flight architect configure domain
    Name of the cluster (1/6)
    mycluster
    Password to use for root user (2/6)
    ********
    Confirm password:
    ********
    <snip>

After all questions have been answered, the answers will be saved.

.. note:: When rerunning a ``configure`` command the existing answers will be shown between pipes. For example, the above command would show ``Name of the cluster (1/6) |mycluster|`` on the prompt.

Creating a Group
^^^^^^^^^^^^^^^^

Add a new group containing multiple nodes (using `genders host range syntax <https://github.com/chaos/genders/blob/master/TUTORIAL>`_)::

    [root@myhost ~]# flight underware configure group newnodes compute[01-10]
    1. service
    2. login
    3. compute
    4. storage
    5. other
    Role of nodes in this group (1/3)  |other|
    3
    Define a second network? (2/3) [yes/no]  |no|

    Define a third network? (3/3) [yes/no]  |no|

.. note:: The configure questions are displaying the domain-level answers to matching questions such that this group can inherit or override the domain-level settings.

Modifying a Node
^^^^^^^^^^^^^^^^

To modify an existing node::

    [root@myhost ~]# flight underware configure node compute01
    Use this machine as a gateway for network traffic? (1/1) [yes/no]  |no|

.. note:: If the node name provided to the command doesn't already exist within a group then it will be created as an orphan node and will inherit settings directly from the domain.

Render
------

Files and templates containing embedded Ruby can be rendered outside of the ``template`` command using ``render``. The ``render`` command will evaluate the file and print the output to stdout.

Render in Domain Scope
^^^^^^^^^^^^^^^^^^^^^^


Render in Group Scope
^^^^^^^^^^^^^^^^^^^^^^


Render in Node Scope
^^^^^^^^^^^^^^^^^^^^^^


Questions
---------

Referencing Answer
^^^^^^^^^^^^^^^^^^

It's best practise to reference an answer once in the configs and then use that config value in scripts

Adding a Question
^^^^^^^^^^^^^^^^^



