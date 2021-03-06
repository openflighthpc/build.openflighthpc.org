.. _genders-and-pdsh:

Genders and PDSH
================

.. note:: Genders & PDSH functionality is not available or useful on a single node research environment, this page only applies to multi-node research environments

A combination of genders and pdsh can allow for management and monitoring of multiple nodes at a time. OpenFlight provides a build of PDSH that integrates with the rest of the User Suite.

Installing nodeattr and pdsh
----------------------------

Nodeattr and pdsh can be installed using the yum package manager, simply::

    sudo yum -y install flight-pdsh

Once installed, the pdsh command will be available to active OpenFlight User Suite sessions (use ``flight start`` to activate the session). The priority of the OpenFlight pdsh command in the path can be configured with::

    flight config set pdsh.priority X

Where ``X`` is one of:

- ``system`` - Prefer system PDSH
- ``embedded`` - Prefer OpenFlight PDSH
- ``disabled`` - Do not include OpenFlight PDSH in PATH

.. note:: OpenFlight PDSH defaults ``system`` priority, to ensure that the OpenFlight User Environment uses the OpenFlight PDSH, set the priority to ``embedded`` after installation (``flight config set pdsh.priority embedded``)

Finding the names of your compute nodes
---------------------------------------

An OpenFlight Compute research environment may contain any number of compute nodes depending on your research environment size. The hostnames of compute nodes usually follow a sequential order (e.g. node01, node02, node03... node10). OpenFlight Compute automatically creates a list of compute node names and uses them to populate a *genders* group called **nodes**. This genders file can be found at ``/opt/flight/etc/genders``.

Users can find the names of their compute nodes by using the ``nodeattr`` command; e.g.

  - ``nodeattr -s nodes``
     - shows a space-separated list of current compute node hostnames
  - ``nodeattr -c nodes``
     - shows a comma-separated list of current compute node hostnames
  - ``nodeattr -n nodes``
     - shows a new-line-separated list of current compute node hostnames

The login node hostname for Flight Compute research environments launched using default templates is always ``gateway1``.

Using PDSH
----------

Users can run a command across all compute nodes at once using the ``pdsh`` command. This can be useful if users want to make a change to all nodes in the research environment - for example, installing a new software package. The ``pdsh`` command can take a number of parameters that control how commands are processed; for example:

  - ``pdsh -g all uptime``
     - executes the ``uptime`` command on all available compute and login nodes in the research environment
  - ``pdsh -g nodes 'sudo yum -y install screen'``
     - use ``yum`` to install the ``screen`` package as the root user on all compute nodes
  - ``pdsh -g nodes -f 1 df -h /tmp``
     - executes the command ``df -h /tmp`` on all compute nodes of the research environment, one at a time (fanout=1)
  - ``pdsh -w node01,node03 which ldconfig``
     - runs the ``which ldconfig`` command on two named nodes only


