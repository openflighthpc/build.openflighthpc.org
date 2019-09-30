Obtain Configuration Scripts
----------------------------


Download scripts::

    mkdir -p /opt/service/scripts
    cd /opt/service/scripts
    wget https://raw.githubusercontent.com/openflighthpc/openflighthpc-tools/master/scripts/flightenv.bash
    wget https://raw.githubusercontent.com/openflighthpc/openflighthpc-tools/master/scripts/nfsserver.bash
    wget https://raw.githubusercontent.com/openflighthpc/openflighthpc-tools/master/scripts/nfsclient.bash
    wget https://raw.githubusercontent.com/openflighthpc/openflighthpc-tools/master/scripts/slurmcontroller.bash
    wget https://raw.githubusercontent.com/openflighthpc/openflighthpc-tools/master/scripts/slurmnode.bash

Edit the scripts to ensure that the content is correct for your configuration.

.. warning:: It is highly recommended to inspect all scripts and edit them to your requirement or, alternatively, write your own scripts. These scripts are provided "as is" and no guarantee is made that the scripts will function properly in environments different to that of the example environment used in this documentation.


Configure Gateway Node
----------------------

On the gateway node, run all scripts for the gateway role::

    [root@gateway1 ~]# bin/manage run -r gateway

