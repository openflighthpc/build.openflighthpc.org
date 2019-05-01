Install Flight Manage
---------------------

Option 1: Manual Installation
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Flight Manage requires Ruby 2.5.1+ and bundler in order to work. Ensure that these are installed, working and available in your environment before continuing.

- Clone the repository::

    [root@myhost ~]# git clone https://github.com/openflighthpc/flight-manage.git

- Navigate to the installation directory::

    [root@myhost ~]# cd flight-manage

- Install gem dependencies::

    [root@myhost ~]# bundle install

The entry script is located at ``bin/manage``.

Option 2: Runway Installation
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Alternatively, Flight Runway provides the Ruby environment and command-line helpers for running openflightHPC tools.

To install Flight Runway, see the `Flight Runway installation docs <https://github.com/openflighthpc/flight-runway#installation>`_.

These instructions assume that ``flight-runway`` has been installed from the openflightHPC yum repository and `system-wide integration <https://github.com/openflighthpc/flight-runway#system-wide-integration>`_ enabled.

Install Flight Manage::

    [root@myhost ~]# yum -y install flight-manage

Flight Manage is now available via the ``flight`` tool::

    [root@myhost ~]# flight manage
      NAME:

        flight manage

      DESCRIPTION:

        Remote executor of shared scripts.

      COMMANDS:

        help           Display global or [command] help documentation
        <snip>
