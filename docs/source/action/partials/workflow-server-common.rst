Start Service
^^^^^^^^^^^^^

The OpenFlight Service utility is used to start the service::

    $ flight service start action-api

.. note:: The general OpenFlight webserver service also needs to be running, this can be launched with ``flight service start www``

Enable Service
^^^^^^^^^^^^^^

The OpenFlight Service utility is used to enable the service::

    $ flight service enable action-api

.. note:: In order to integrate the service enabling with systemd (to ensure the service starts at boot), the ``flight-plugin-system-systemd-service`` package will need to be installed

Generate Token
^^^^^^^^^^^^^^

To generate a 30-day authentication token for the client, run::

    $ flight action-api generate-token
    eyJhbGciOiJIUzI1NiJ9.eyJhZG1pbiI6bnVsbCwiZXhwIjoxNTgxODcyNjA2fQ.WXm-F07bAl78UTZHAsFKLXzYokBwVfgMabzIMgNfc5Y

This will return a token that can be entered into the config of a power client to authenticate against this server.

