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

    [root@myhost ~]# flight architect cluster delete anothercluster
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

    [root@myhost ~]# flight architect configure group newnodes compute[01-10]
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

    [root@myhost ~]# flight architect configure node compute01
    Use this machine as a gateway for network traffic? (1/1) [yes/no]  |no|

.. note:: If the node name provided to the command doesn't already exist within a group then it will be created as an orphan node and will inherit settings directly from the domain.

Render
------

Files and templates containing embedded Ruby can be rendered outside of the ``template`` command using ``render``. The ``render`` command will evaluate the file and print the output to stdout.

Render in Domain Scope
^^^^^^^^^^^^^^^^^^^^^^

In this example, a file called ``/tmp/domainscope`` contains the following::

    <%= domain.cluster_name %>

This can be rendered in domain scope as follows::

    [root@myhost ~]# flight architect render domain /tmp/domainscope
    mycluster

Render in Group Scope
^^^^^^^^^^^^^^^^^^^^^^

In this example, a file called ``/tmp/groupscope`` contains the following::

    <%= group.name %>
    <% group.nodes.each do |node| %>
    - <%= node.name %>
    <% end %>

This can be rendered in the scope of the group ``nodes`` as follows::

    [root@myhost ~]# flight architect render group nodes /tmp/groupscope
    nodes
    - node01
    - node02
    - node03
    <snip>

Render in Node Scope
^^^^^^^^^^^^^^^^^^^^^^

In this example, a file called ``/tmp/nodescope`` contains the following::

    <%= node.name %>
    <% node.networks.each do |network| %>
    - <%= network.domain %>
    <% end %>

This can be rendered in the scope of the node ``node01`` as follows::

    [root@myhost ~]# flight architect render node node01 /tmp/nodescope
    node01
    - pri
    - mgt
    - ib

.. _architect-questions:

Questions
---------

Referencing Answers
^^^^^^^^^^^^^^^^^^^

It's best practise to reference an answer once in the configs and then use that config value in scripts. 

Answers for questions at various scope levels are stored under ``/var/lib/architect/clusters/mycluster/var/answers/`` (with this example using a cluster named ``mycluster``). Take the following snippet from the ``domain.yaml`` answers file::

    cluster_name: mycluster
    root_password: "$6$aRb6bZ1PN81Reie+$kqfi1vVv16jINx9ewsgzTS9wSr33Mn3ZbcXLhbrhAUhlx8IYW3NZUc9Be6EtMABUrhlMqrDIcp5JcuOUNAROQ/"
    root_ssh_key: ssh-rsa MySSHkeyGoesHere1234567890 user@host

These answers are available through the namespace as::

    answer.cluster_name
    answer.root_password
    answer.root_ssh_key

This answer is then referenced to a config value in ``etc/domain.yaml`` in the cluster directory::

    cluster_name: <%= answer.cluster_name %>
    root_password: <%= answer.root_password %>
    root_ssh_key: <%= answer.root_ssh_key %>

Adding a Question
^^^^^^^^^^^^^^^^^

Questions are defined in ``configure.yaml`` (either at the :ref:`source level <source-configuration-templates>` [for new clusters] or in the :ref:`cluster directory <cluster-configuration-templates>` [for existing clusters]).

A question definition is structured as follows (beneath the ``questions:`` line in the file)::

      - &cluster_name
        identifier: cluster_name
        question: 'Name of the cluster'

It's best practice to keep the anchor (``&cluster_name``) and the identifier (``cluster_name``) consistent for referencing throughout the questions definition and config files. The ``question`` is what will be displayed on the prompt during :ref:`the configure process <architect-configure-cluster>`.

Once a question has been defined it won't be asked unless added to one of the scope lists at the bottom of the file. The above example question is defined to be asked at the domain level::

    domain:
      - *cluster_name

Question Flags
^^^^^^^^^^^^^^

The following snippets are optional flags that can appended to question definitions.

::

    default: 'my default answer'

The placeholder/default answer for the question.

::

    choices:
      - option1
      - option2
      - option3

A list of available options, these will be displayed during the configure process and the user must select one of the options to continue.

::

    type: boolean

Defines the type of answer. Booleans will only accept ``true``/``false`` as valid answers. The other available types are:

- ``password`` which will prompt for a password twice and save the password in an encrypted format.
- ``integer`` which will only allow numerical answers.

.. _architect-manifest-export:

.. include:: /architecture/partials/workflow-manifest.rst

.. _architect-export:

.. include:: /architecture/partials/workflow-export.rst
