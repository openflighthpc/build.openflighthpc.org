.. _action-workflow-azure:

Workflow: Azure
===============

This workflow is based on setting up the power server and client for an Azure cluster created as explained in :ref:`the Cloud Azure Workflow <cloud-workflow-azure>`

Server Setup
------------

.. include:: /action/partials/workflow-server-install.rst

Install Azure CLI
^^^^^^^^^^^^^^^^^

Refer to the `Azure CLI documentation <https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-yum>`_ for help with installing the repository and tool.

Once installed, authenticate the tool with your Azure account::

    $ az login 

Add Nodes
^^^^^^^^^

Nodes are added to the config file at ``/opt/flight/opt/action-api/config/nodes.yaml``, below is an example of the node configuration for a simple 3 node cluster consisting of a gateway and two compute nodes::

    gateway1:
      ranks: [azure]
      azure_resource_group: mycluster-abcd123
      azure_name: flightcloudclustergateway1
    node01:
      ranks: [azure]
      azure_resource_group: mycluster-abcd123
      azure_name: flightcloudclusternode01
    node02:
      ranks: [azure]
      azure_resource_group: mycluster-abcd123
      azure_name: flightcloudclusternode02

.. include:: /action/partials/workflow-server-common.rst


Client Setup
------------

.. include:: /action/partials/workflow-client-install.rst

.. include:: /action/partials/workflow-client-common.rst
