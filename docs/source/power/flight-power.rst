.. _flight-power:

OpenFlight Power
================

OpenFlight Power is a platform-agnostic power management tool built with a server/client architecture. The server provides a simple, yet flexible, method for defining nodes and platform power commands. The client provides a consistent, straightforward interface for controlling nodes on various platforms. 

Utilisation of a server/client model allows for centralised configuration and distributed control of the nodes in a cluster, no matter what platform said nodes are running on.

Server
------

Overview
^^^^^^^^

**Github Project:** `<https://github.com/openflighthpc/power-server>`_

The server provides a secure, centralised location for configuring platform-specific power commands and tracking the nodes in the cluster. It provides various pre-configured content to jumpstart utilising the server for managing AWS, Azure and IPMI nodes. 

Configuration
^^^^^^^^^^^^^

The most important file for the server is the topology configuration file. Through this file nodes, platforms and power commands are configured to be supplied to the command line tool. 

A breakdown of the default topology file, stored at ``/opt/flight/etc/power-server/topology.yaml``, is below.

Firstly, 3 placeholder nodes provide example configurations for AWS, Azure and IPMI nodes::

    static_nodes:
      node01:
        platform: aws
        ec2_id: i-node01xxxxxxxxxxx
        region: eu-west-1
      node02:
        platform: azure
        resource_group: demo-power-group
      node03:
        platform: ipmi
        ipmi_username: admin
        ipmi_password: adminpass

Each node is defined as a key, with arbitrary key/value pairs within the node key to provide necessary information for running power commands. 

After the node definitions are the platform and command definitions::

    platforms:
      ipmi:
        variables: [name, ipmi_username]
        power_on: ipmitool -H "$name"-bmc -U "$ipmi_username" -E chassis power on -I lanplus
        power_off: ipmitool -H "$name"-bmc -U "$ipmi_username" -E chassis power off -I lanplus
        restart: ipmitool -H "$name"-bmc -U "$ipmi_username" -E chassis power reset -I lanplus
        status: |-
          output=$(ipmitool -H "$name"-bmc -U "$ipmi_username" -E chassis power status -I lanplus)
          if echo "$output" | grep on; then
            exit 0
          elif echo "$output" | grep off; then
            exit 111
          else
            exit 1
          fi

The ipmi platform states that the node variables to expose to each of the 4 power commands are the node name and ipmi_username.

After the ipmi definition there are similar configuration details for the AWS and Azure cloud platforms. 

Authentication
^^^^^^^^^^^^^^

The server utilises JWT tokens to secure client access against unauthenticated clients attempting to interact with nodes. This is achieved with the JWT secret token set in ``/opt/flight/etc/power-server.conf`` (randomised on installation) that allows for the server to generate client tokens through the ``flight`` tool.

For more information on generating client tokens, see one either of the workflow docs (:ref:`AWS Cluster Workflow <power/workflow-aws:Generate Token>`).

Service
^^^^^^^

Upon installation, the power server is added as a systemd service, ``flight-power-server``, which is ready to go out of the box. Start/enable this service to run the server on port 6302.

Client
------

Overview
^^^^^^^^

**Github Project:** `<https://github.com/openflighthpc/power-client>`_

The client provides a lightweight, simple command-line tool for issuing power commands to the server.

Configuration
^^^^^^^^^^^^^

To configure the client, it requires the location of the server and a security token to authenticate commands. 

The client configuration file is stored at ``/opt/flight/opt/power-client/etc/config.yaml`` and consists of two keys::

    base_url: http://localhost:6302
    jwt_token: generated_authorisation_token

Default configuration of the client sets the base url (the address of the power server) to localhost, preparing the client to initially work with a local server. 

The JWT token will need to be modified to the value given when generating a client token from the server.

Command Line
^^^^^^^^^^^^

The command line tools provides a generalised syntax to perform common power commands. These commands are:

- List: Provide a list of the available nodes configured on the server
- Status: Returns the current power status of the specified nodes
- On: Power on the specified nodes
- Off: Power off the specified nodes
- Restart: Restart the power state of the specified nodes

Command examples and further client usage information can be found in the workflow documentation (:ref:`AWS Cluster Workflow <power/workflow-aws:List Available Nodes>`).
