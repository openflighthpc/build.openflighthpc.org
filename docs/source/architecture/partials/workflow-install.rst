Install Flight Architect
------------------------

Option 1: Manual Installation
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Flight Architect requires Ruby 2.5.1+ and bundler in order to work. Ensure that these are installed, working and available in your environment before continuing.

- Clone the repository::

    [root@myhost ~]# git clone https://github.com/openflighthpc/flight-architect.git

- Navigate to the installation directory::

    [root@myhost ~]# cd flight-architect

- Install gem dependencies::

    [root@myhost ~]# bundle install

The entry script is located at ``bin/architect``.

Option 2: Runway Installation
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Alternatively, Flight Runway provides the Ruby environment and command-line helpers for running openflightHPC tools.

To install Flight Runway, see the `Flight Runway installation docs <https://github.com/openflighthpc/flight-runway#installation>`_.

These instructions assume that ``flight-runway`` has been installed from the openflightHPC yum repository and `system-wide integration <https://github.com/openflighthpc/flight-runway#system-wide-integration>`_ enabled.

Install Flight Architect::

    [root@myhost ~]# yum -y install flight-architect

Flight Architect is now available via the ``flight`` tool::

    [root@myhost ~]# flight architect
      NAME:

        underware

      DESCRIPTION:

        Tool for managing standard config hierarchy and template rendering under-lying Alces clusters and other Alces tools

      COMMANDS:

        cluster      Initialize, list, switch, and delete cluster configurations
        configure    Manage the cluster and node configurations
        <snip>

