.. _openflighthpc-architect-common-practices:

openFlightHPC Architect: Reference
==================================

.. include:: partials/workflow-install.rst

Cluster
-------

Show Clusters
^^^^^^^^^^^^^

Show a cluster::

    [root@myhost ~]# flight underware cluster list

.. _architect-create-cluster:

Create Cluster
^^^^^^^^^^^^^^

Create a cluster:: 

    [root@myhost ~]# flight underware cluster init cluster_name

.. note:: The ``init`` command will always use the ``example`` cluster profile unless either ``--bare`` (which will copy ``<architect home>/data/base`` only) or ``--profile another_profile_name`` (where ``another_profile_name`` corresponds to a directory in ``<architect home>/data/``) are provided as arguments.

Change Cluster
^^^^^^^^^^^^^^


Delete Cluster
^^^^^^^^^^^^^^


Configure
---------

Updating Domain Configuration
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


Creating a Group
^^^^^^^^^^^^^^^^


Modifying a Node
^^^^^^^^^^^^^^^^


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



