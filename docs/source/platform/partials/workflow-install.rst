Install Flight Cloud
--------------------


Option 1: Manual Installation
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Flight Cloud requires Ruby 2.5.1+ and bundler in order to work. Ensure that these are installed, working and available in your environment before continuing.

- Clone the repository::

    [root@myhost ~]# git clone https://github.com/openflighthpc/flight-cloud.git

- Navigate to the installation directory::

    [root@myhost ~]# cd flight-cloud

- Install gem dependencies::

    [root@myhost ~]# bundle install

The entry script is located at ``bin/cloud``.

Option 2: Runway Installation
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Flight Runway provides the Ruby environment and command-line helpers for running openflightHPC tools.

To install Flight Runway, see the `Flight Runway installation docs <https://github.com/openflighthpc/flight-runway#installation>`_.

These instructions assume that ``flight-runway`` has been installed from the openflightHPC yum repository and `system-wide integration <https://github.com/openflighthpc/flight-runway#system-wide-integration>`_ enabled.

Install Flight Cloud::

    [root@myhost ~]# yum -y install flight-cloud

Flight Cloud is now available via the flight tool::

    [root@myhost ~]# flight cloud
      SYNOPSIS:

        flight cloud <platform> [<args>]

      DESCRIPTION:

        Perform cloud platform activities.  Valid platforms are "aws"
        and "azure".


