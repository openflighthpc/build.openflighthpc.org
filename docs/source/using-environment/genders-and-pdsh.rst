.. _genders-and-pdsh:

Genders and PDSH
================

.. note:: Genders & PDSH functionality is not available or useful on a single node research environment, this page only applies to multi-node research environments

A combination of genders and pdsh can allow for management and monitoring of multiple nodes at a time.

Installing nodeattr and pdsh
----------------------------

Nodeattr and pdsh can be installed using the yum package manager, simply::

    sudo yum -y install genders pdsh pdsh-mod-genders


Finding the names of your compute nodes
---------------------------------------

An OpenFlight Compute research environment may contain any number of compute nodes depending on your research environment size. The hostnames of compute nodes us
ually follow a sequential order (e.g. node01, node02, node03... node10). OpenFlight Compute automatically creates a list of compute nod
e names and uses them to populate a *genders* group called **nodes**. This genders file can be found at ``/opt/flight/etc/genders``.

Users can find the names of their compute nodes by using the ``nodeattr`` command; e.g.

  - ``nodeattr -f /opt/flight/etc/genders -s nodes``
     - shows a space-separated list of current compute node hostnames
  - ``nodeattr -f /opt/flight/etc/genders -c nodes``
     - shows a comma-separated list of current compute node hostnames
  - ``nodeattr -f /opt/flight/etc/genders -n nodes``
     - shows a new-line-separated list of current compute node hostnames

The login node hostname for Flight Compute research environments launched using default templates is always ``gateway1``.


Using PDSH
----------

Users can run a command across all compute nodes at once using the ``pdsh`` command. This can be useful if users want to make a change to all nodes in the research environment - for example, installing a new software package. The ``pdsh`` command can take a number of parameters that control how commands are processed; for example:

  - ``pdsh -F /opt/flight/etc/genders -g all uptime``
     - executes the ``uptime`` command on all available compute and login nodes in the research environment
  - ``pdsh -F /opt/flight/etc/genders -g nodes 'sudo yum -y install screen'``
     - use ``yum`` to install the ``screen`` package as the root user on all compute nodes
  - ``pdsh -F /opt/flight/etc/genders -g nodes -f 1 df -h /tmp``
     - executes the command ``df -h /tmp`` on all compute nodes of the research environment, one at a time (fanout=1)
  - ``pdsh -w node01,node03 which ldconfig``
     - runs the ``which ldconfig`` command on two named nodes only


