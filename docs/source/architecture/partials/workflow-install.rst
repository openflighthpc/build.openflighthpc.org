Install Architect
-----------------

Manual Installation
^^^^^^^^^^^^^^^^^^^

Flight Architect requires Ruby 2.5.1+ and bundler in order to work. Ensure that these are installed, working and available in your environment before continuing.

- Clone the repository::

    [root@myhost ~]# git clone https://github.com/alces-software/underware.git

- Navigate to the installation directory::

    [root@myhost ~]# cd underware

- Install gem dependencies::

    [root@myhost ~]# bundle install

The entry script is located at ``bin/underware``.

Runway Installation
^^^^^^^^^^^^^^^^^^^

Alternatively, Flight Runway (and Flight Tools) provides the Ruby environment and command-line helpers for running openflightHPC tools.

To install Flight Runway, see the `Flight Runway installation docs <https://github.com/openflighthpc/flight-runway#installation>`_ and for Flight Tools, see the `Flight Tools installation docs <https://github.com/openflighthpc/openflight-tools#installation>`_.

These instructions assume that ``flight-runway`` and ``flight-tools`` have been installed from the openflightHPC yum repository and `system-wide integration <https://github.com/openflighthpc/flight-runway#system-wide-integration>`_ enabled.

Integrate Flight Architect to runway::

    [root@myhost ~]# flintegrate /opt/flight/opt/openflight-tools/tools/flight-architect.yml
    Loading integration instructions ... OK.
    Verifying instructions ... OK.
    Downloading from URL: https://github.com/alces-software/underware/archive/0.6.0-rc4.zip ... OK.
    Extracting archive ... OK.
    Performing configuration ... OK.
    Integrating ... OK.

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

