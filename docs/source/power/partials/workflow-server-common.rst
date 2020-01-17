Start Service
^^^^^^^^^^^^^

The systemd service can be enabled as any other service would be::

    $ systemctl start flight-power-server

To start the service at boot::

    $ systemctl enable flight-power-server

Generate Token
^^^^^^^^^^^^^^

Power server provides a helper command for Flight Runway to generate client keys, simply::

    $ flight power-server-generate-token
    eyJhbGciOiJIUzI1NiJ9.eyJhZG1pbiI6bnVsbCwiZXhwIjoxNTgxODcyNjA2fQ.WXm-F07bAl78UTZHAsFKLXzYokBwVfgMabzIMgNfc5Y

This will return a token that can be entered into the config of a power client to authenticate it against the server.

.. note:: The ``flight`` command can be executed with it's full path (``/opt/flight/bin/flight``) in the case that ``flight-starter`` has not been installed to add the command to the environment.

