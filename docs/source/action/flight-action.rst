.. _flight-action:

OpenFlight Action
=================

OpenFlight Action is a platform-agnostic management tool built with a server/client architecture. The server provides a simple, yet flexible, method for defining nodes and commands. The client provides a consistent, straightforward interface for performing actions on nodes of various platforms.

Utilisation of a server/client model allows for centralised configuration and distributed control of the nodes in a cluster, no matter what platform said nodes are running on. This can allow, for example, users to be able to perform superuser-level commands on many nodes from the client without needing sudo, giving the admin a greater level of control without needing to configure sudo on multiple systems. 

Server
------

Overview
^^^^^^^^

**Project URL:** `<https://github.com/openflighthpc/flight-action-api>`_

The server provides a secure, centralised location for configuring platform-specific power commands and tracking the nodes in the cluster. 

Configuration
^^^^^^^^^^^^^

Nodes
~~~~~

The nodes file is used to define the nodes in the system. An example of the content for this file is in ``/opt/flight/opt/action-api/co
nfig/nodes.example.yaml``, this is a useful reference for understanding the different ways that nodes can be configured.

Some example node entries are below::

    node01:
      ranks: [metal]
      ip: 192.168.1.1

    cnode01:
      ranks: [aws]
      ec2_id: i-1234567890
      aws_region: eu-west-2

Besides ``ranks``, the key/value pairs for node entries are arbitrary and can be customised for whatever platform, use or metadata that fits your use case. The ``ranks`` key is used during command lookup to run rank-specific variants of the command (if available).

.. note:: If no ranks are present then the default version of a command will be run

Commands
~~~~~~~~

Commands are stored within ``/opt/flight/opt/action-api/libexec/`` and are shell scripts. A command exists in a subdirectory of the aforementioned path. For example, a command called usage would be a directory at ``/opt/flight/opt/action-api/libexec/usage`` and would contain, at least, the following files:

- ``metadata.yaml`` - Containing command descriptions and definition
- ``default.sh`` - The default script to run for the commands

Additionally, this directory can contain scripts for various arbitrary rank keys, such as:

- ``aws.sh`` - A version of the default script with amendments made to support AWS

.. note:: The script files need to be executable or they will not run

The ``metadata.yaml`` file contains general command information and looks like the following::

    help:
      summary: "Get system usage info"
      description: >
        This command gets basic system usage information and reports it back
        to the user

The ``default.sh`` file runs a simple command and reports back on the load average of the system::

    #!/bin/bash
    LOAD="$(ssh $name 'uptime')"
    echo "$name load and uptime: $LOAD"

The ``aws.sh`` file includes the AWS instance ID in the script::

    #!/bin/bash
    LOAD="$(ssh $name 'uptime')"
    echo "$name ($ec2_id) load and uptime: $LOAD"

.. note:: All node metadata is passed through as bash variables of the same name and case

Authentication
^^^^^^^^^^^^^^

The server utilises JWT tokens to secure client access against unauthenticated clients attempting to interact with nodes. To generate a token that's valid for 30 days, simple run::

    flight action-api generate-token

This will print some information and then generate a token which can be set in the configuration of authorised clients.

Service
^^^^^^^

OpenFlight provides a service handler that hooks non-intrusively into the system beside systemd. In order for action requests from clients to be properly handled by the server, the action server needs to be started::

    flight service start action-api

To ensure that the action server is running after reboot, enable it::

    flight service enable action-api

.. note:: In order for the action server to be queryable, a webserver of some kind is needed. This could be a manual Apache/Nginx setup or by using the OpenFlight WWW service (``flight service start www``). It's also worth noting that only HTTPS is supported by the action server so ensure that it is suitably certified. The OpenFlight WWW service can assist with certificate generation, see ``flight www cert-gen`` for more information.

Helpers
^^^^^^^

While the action server provides a generic framework for securely executing commands on nodes it's a fairly blank slate to begin with. To address some of the common usages of Flight Action, there are various helper packages that can be installed to provide some commands that work out-of-the-box on various cloud & metal platforms.

Power
~~~~~

The OpenFlight package ``flight-action-api-power`` provides power management commands for multiple platforms (IPMI, AWS & Azure). The specific commands it provides are:

- ``power-off`` - Power off a node
- ``power-on`` - Power on a node
- ``power-cycle`` - Cycle the power, reboot the node
- ``power-status`` - Print the power status of the node

Additionally, a shorter entrypoint for the ``flight`` command is created, such that the ``flight action power-off node01`` can be shortened to ``flight power off node01``. 

Estate
~~~~~~

The OpenFlight package ``flight-action-api-estate`` provides estate management commands for multiple platforms (AWS & Azure) for setting the instance size of cloud nodes. The specific commands it provides are:

- ``estate-change`` - Change the machine type of a node

Client
------

Overview
^^^^^^^^

**Project URL:** `<https://github.com/openflighthpc/flight-action>`_

The Action client provides an integrated tool for communicating effectively with the API server.

Configuration
^^^^^^^^^^^^^

Before the client can be used it needs to be configured to look for the right server with the correct authentication token. An example configuration file can be found at ``/opt/flight/opt/action/etc/config.yaml.reference``. A simple configuration stored at ``/opt/flight/opt/action/etc/config.yaml`` would be something like::

    base_url: https://gateway1/action
    jwt_token: 1a2b3c4d5e6f7g8h9i0j

Where ``base_url`` is the hostname or IP address of the OpenFlight Action Server and ``jwt_token`` is a valid token generated on the server. If using a self-signed SSL certificate the client will fail to run unless ``verify_ssl: false`` is added to the configuration file.

Command Line
^^^^^^^^^^^^

The command line provides a generalised client for accessing whatever command have been created on the server, therefore there are only a couple of consistent subcommands for the client:

- ``help`` - The help page will show all available commands defined in the action server
- ``estate-list`` - This command lists all the nodes defined in the action server

When running an action from the command line - a nodename will be needed to direct the server to run the command on the correct system. To run for multiple nodes at once, use the ``-g`` argument with a comma-separated list of nodes.

Helpers
^^^^^^^

To improve accessibility and ease-of-use for the client command line, there are helpers that provide shorter entrypoints for the additional content provided by the server helpers:

- ``flight-power`` - The entrypoint ``power`` for managing node power state (``flight power off node01``)
- ``flight-estate`` - The entrypoint ``estate`` for managing node types (``flight estate change node01``)

