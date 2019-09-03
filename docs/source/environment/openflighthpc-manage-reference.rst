.. _openflighthpc-manage-reference:

openFlightHPC Manage: Reference
===============================

.. include:: partials/workflow-install.rst

Scripts
-------

Add a Script
^^^^^^^^^^^^

For a script to be included it must be in-place under the scripts directory (which defaults to ``/opt/service/scripts/``) and meet the following requirements:

- The file extension must be ``.bash``
- Contain at least one Manage metadata entry

In terms of metadata, these key/value pairs will be at the top of the script. The following metadata is recognised::

    #!/bin/bash
    #FLIGHTroles: compute
    #FLIGHTrerunnable: true
    #FLIGHTdescription: Summary of what this script does
    #FLIGHTstages: boot

These variables define:

- ``roles``: A comma-separated list of the node roles which the script should be run on.
- ``rerunnable``: A boolean flag used to determine if it's safe to rerun a script.
- ``description``: A description of the script.
- ``stages``: A tag used for grouping when the script should run.

Show Scripts
^^^^^^^^^^^^

To display the scripts that can be run with Manage, run script list::

    [root@myhost ~]# bin/manage script list

    Listing all flight scripts in '/opt/service/scripts':
    anotherscript/run.bash - A super slow script
    configure-a-thing/configureitall.bash - Install a package that's critical
    testscript1/bar.bash - Touch a file in /tmp/

    Listing all flight scripts in '/opt/service/nodescripts/myhostscripts':
    justforthisnode - This script will only be available for this node

.. note:: Flight Manage checks for a ``nodescripts`` directory, allowing for node-specific scripts to be put in place without becoming available to all nodes.

View Script History
^^^^^^^^^^^^^^^^^^^

To show the run history of a script, use the show command::

    [root@myhost ~]# bin/manage script show anotherscript/run.bash
    Showing current state of script: anotherscript/run

    headnode1: OK

This will simply display whether the script exited cleanly or not.

Script Execution
----------------

Scripts can be executed in a few ways. Either directly or by executing all scripts for a specified role or stage.

Run Script
^^^^^^^^^^

To run a script on the current node, simply::

    [root@myhost ~]# bin/manage script run anotherscript/run.bash
    anotherscript/run executed with exit code 0

Run a Role
^^^^^^^^^^

To run all scripts with the ``compute`` role, add the role flag to the run command::

    [root@myhost ~]# bin/manage script run -r compute
    anotherscript/run executed with exit code 0
    configure-a-thing/configureitall executed with exit code 0
    testscript1/bar executed with exit code 0

Run a Stage
^^^^^^^^^^^

To run all scripts with the stage ``oneoff``, add the stage flag::

    [root@myhost ~]# bin/manage script run -s oneoff
    script-without-role/runit.bash executed with exit code 0

.. note:: If scripts have both a stage and a role defined then the role will also need to be provided with ``-r rolename``

Mark Script as Externally Run
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

If a script fails on a node and, separately of flight-manage, the script issues are resolved and applied to a node then the script can be marked as resolved::

    [root@myhost ~]# bin/manage script resolve anotherscript/run.bash
    anotherscript/run.bash has been marked as resolved

