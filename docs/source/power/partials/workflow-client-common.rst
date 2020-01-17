Add Security Token
^^^^^^^^^^^^^^^^^^

Add security token to ``/opt/flight/opt/power-client/etc/config.yaml`` so the file looks similar to the following::

    base_url: http://localhost:6302
    jwt_token: eyJhbGciOiJIUzI1NiJ9.eyJhZG1pbiI6bnVsbCwiZXhwIjoxNTgxODcyNjA2fQ.WXm-F07bAl78UTZHAsFKLXzYokBwVfgMabzIMgNfc5Y

.. note:: When installing a client on a separate system to the server be sure to update the ``base_url`` to look at the correct location

List Available Nodes
^^^^^^^^^^^^^^^^^^^^

A list of the configured nodes can be seen from the client as so::

    $ flight power list
    gateway1
    node01
    node02

.. note:: The ``flight`` command can be executed with it's full path (``/opt/flight/bin/flight``) in the case that ``flight-starter`` has not been installed to add the command to the environment.

Check Power Status of Nodes
^^^^^^^^^^^^^^^^^^^^^^^^^^^

To check the power status of all nodes, simply::

    $ flight power status gateway1,node[01-02]
    gateway1 On
    node01   On
    node02   On

Power Off a Node
^^^^^^^^^^^^^^^^

A node can be powered off as follows::

    $ flight power off node02
    node02 Stopping

Power On a Node
^^^^^^^^^^^^^^^

A node can be powered on as follows::

    $ flight power on node02
    node02 Starting

Restart a Node
^^^^^^^^^^^^^^

To restart a node, simply::

    $ flight power restart node02
    node02 Restarting

