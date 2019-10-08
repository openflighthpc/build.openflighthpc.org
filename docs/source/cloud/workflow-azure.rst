.. _cloud-workflow-azure:

Workflow: Azure
===============

.. include:: /cloud/partials/workflow-prerequisites.rst

Deploy Resources
----------------

- Run the createtemplates script to create AWS and Azure templates::

    curl https://raw.githubusercontent.com/openflighthpc/openflighthpc-images/master/scripts/cloud/createtemplates.sh |/bin/bash

- Create resource group for domain::
    az group create --name mycluster-domain-basic --location "UK South"
    
- Deploy domain::

    az group deployment create --name domain --resource-group mycluster-domain-basic —template-file /opt/flight/templates/azure/domain.json

- Create resource group for gateway1::

    az group create --name mycloud-gateway1-basic --location "UK South"

- Deploy node01 (can’t seem to locate the subnet ID from the GUI so locate the subnet [not the network] ID by running ``az network vnet subnet list —resource-group mycluster-domain-basic —vnet-name flightcloudclusternetwork``)::

    az group deployment create --name gateway1 --resource-group mycluster-gateway1-basic \
    --template-file /opt/flight/templates/azure/node.json \
    --parameters nodename=gateway1 \
    sshPublicKey="SSH_PUBLIC_KEY_HERE" \
    networkSubnetID='NETWORK_SUBNET_ID_HERE' \
    networkSecurityGroupID='NETWORK_SECURITY_GROUP_ID_HERE' \
    sourceimage='SOURCE_IMAGE_PATH_HERE'

