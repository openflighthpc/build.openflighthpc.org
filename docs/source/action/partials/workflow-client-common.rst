Add Security Token
^^^^^^^^^^^^^^^^^^

Add security token to ``/opt/flight/opt/action/etc/config.yaml`` so the file looks similar to the following::

    base_url: https://gateway1/action
    jwt_token: eyJhbGciOiJIUzI1NiJ9.eyJhZG1pbiI6bnVsbCwiZXhwIjoxNTgxODcyNjA2fQ.WXm-F07bAl78UTZHAsFKLXzYokBwVfgMabzIMgNfc5Y

.. note:: If using a self-signed certificate then add ``verify_ssl: false`` to the config

List Available Nodes
^^^^^^^^^^^^^^^^^^^^

A list of the configured nodes can be seen from the client as so::

    $ flight action estate-list
    gateway1
    node01
    node02

.. note:: The ``flight`` command can be executed with it's full path (``/opt/flight/bin/flight``) in the case that ``flight-starter`` has not been installed to add the command to the environment.

Check Power Status of Nodes
^^^^^^^^^^^^^^^^^^^^^^^^^^^

To check the power status of all nodes, simply::

    $ flight power status -g gateway1,node0[1-2]
    gateway1: ON
    node01: ON
    node02: ON

Power Off a Node
^^^^^^^^^^^^^^^^

A node can be powered off as follows::

    $ flight power off node02
    Power off node02, confirm to proceed [y/n]?
    y
    OK

Power On a Node
^^^^^^^^^^^^^^^

A node can be powered on as follows::

    $ flight power on node02
    OK

Restart a Node
^^^^^^^^^^^^^^

To power cycle a node, simply::

    $ flight power cycle node02
    Power cycle node02, confirm to proceed [y/n]?
    y
    OK

