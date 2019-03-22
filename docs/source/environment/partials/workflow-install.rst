Install Manage
--------------

Manual Installation
^^^^^^^^^^^^^^^^^^^

Flight Manage requires Ruby 2.5.1+ and bundler in order to work. Ensure that these are installed, working and available in your environment before continuing.

- Clone the repository::

    [root@myhost ~]# git clone https://github.com/openflighthpc/flight-manage.git

- Navigate to the installation directory::

    [root@myhost ~]# cd inventoryware

- Install gem dependencies::

    [root@myhost ~]# bundle install

The entry script is located at ``bin/manage``.

Runway Installation
^^^^^^^^^^^^^^^^^^^

Alternatively, Flight Runway (and Flight Tools) provides the Ruby environment and command-line helpers for running openflightHPC tools.

To install Flight Runway, see the `Flight Runway installation docs <https://github.com/openflighthpc/flight-runway#installation>`_ and for Flight Tools, see the `Flight Tools installation docs <https://github.com/openflighthpc/openflight-tools#installation>`_.

These instructions assume that ``flight-runway`` and ``flight-tools`` have been installed from the openflightHPC yum repository and `system-wide integration <https://github.com/openflighthpc/flight-runway#system-wide-integration>`_ enabled.

Integrate Flight Manage to runway::

    [root@myhost ~]# flintegrate /opt/flight/opt/openflight-tools/tools/flight-manage.yml
    Loading integration instructions ... OK.
    Verifying instructions ... OK.
    Downloading from URL: https://github.com/openflighthpc/flight-manage/archive/master.zip ... OK.
    Extracting archive ... OK.
    Performing configuration ... OK.
    Integrating ... OK.

Flight Manage is now available via the ``flight`` tool::

    [root@myhost ~]# flight manage
      NAME:

        flight manage

      DESCRIPTION:

        Remote executor of shared scripts.

      COMMANDS:

        help           Display global or [command] help documentation
        <snip>
