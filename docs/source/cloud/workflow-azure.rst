.. _cloud-workflow-azure:

Workflow: Azure
===============

.. include:: /cloud/partials/workflow-prerequisites.rst

Deploy Resources
----------------

- Run the createtemplates script to create AWS and Azure templates::

    $ curl https://raw.githubusercontent.com/openflighthpc/openflighthpc-images/master/scripts/cloud/createtemplates.sh |/bin/bash

- Create resource group for domain::

    $ az group create --name mycluster-domain --location "UK South"
    
- Deploy domain::

    $ az group deployment create --name domain --resource-group mycluster-domain —template-file /opt/flight/templates/azure/domain.json

- Create resource group for gateway1::

    $ az group create --name mycloud-gateway1 --location "UK South"

- Deploy gateway1::

    $ az group deployment create --name gateway1 --resource-group mycluster-gateway1 \
    --template-file /opt/flight/templates/azure/node.json \
    --parameters nodename=gateway1 \
    sshPublicKey="SSH_PUBLIC_KEY_HERE" \
    networkSubnetID='NETWORK_SUBNET_ID_HERE' \
    networkSecurityGroupID='NETWORK_SECURITY_GROUP_ID_HERE' \
    sourceimage='SOURCE_IMAGE_PATH_HERE'

.. note:: While most IDs can be identified through the Azure GUI, the subnet ID is a bit trickier to locate but can be found with the command ``az network vnet subnet list --resource-group mycluster-domain-basic --vnet-name flightcloudclusternetwork``

- Create resource group for node01::

    $ az group create --name mycloud-node01 --location "UK South"

- Deploy node01::

    $ az group deployment create --name node01 --resource-group mycluster-node01 \
    --template-file /opt/flight/templates/azure/node.json \
    --parameters nodename=node01 \
    sshPublicKey="SSH_PUBLIC_KEY_HERE" \
    networkSubnetID='NETWORK_SUBNET_ID_HERE' \
    networkSecurityGroupID='NETWORK_SECURITY_GROUP_ID_HERE' \
    sourceimage='SOURCE_IMAGE_PATH_HERE'

- Create resource group for node01::

    $ az group create --name mycloud-node01 --location "UK South"

- Deploy node01::

    $ az group deployment create --name node01 --resource-group mycluster-node01 \
    --template-file /opt/flight/templates/azure/node.json \
    --parameters nodename=node01 \
    sshPublicKey="SSH_PUBLIC_KEY_HERE" \
    networkSubnetID='NETWORK_SUBNET_ID_HERE' \
    networkSecurityGroupID='NETWORK_SECURITY_GROUP_ID_HERE' \
    sourceimage='SOURCE_IMAGE_PATH_HERE'

- Setup passwordless root SSH to all compute nodes from the gateway. This can be done by generating a public key with ``ssh-keygen`` and adding it to ``/root/.ssh/authorized_keys`` on the gateway and all other nodes.
