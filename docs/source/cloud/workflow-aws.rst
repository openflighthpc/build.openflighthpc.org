.. _cloud-workflow-aws:

Workflow: AWS
=============

.. include:: /cloud/partials/workflow-prerequisites.rst

Deploy Resources
----------------

- Run the createtemplates script to create AWS and Azure templates::

    curl https://raw.githubusercontent.com/openflighthpc/openflighthpc-images/master/scripts/cloud/createtemplates.sh |/bin/bash

- Deploy domain::

    aws cloudformation deploy --template-file /opt/flight/templates/aws/domain.yaml --stack-name mycluster-domain

- Deploy gateway node::

    aws cloudformation deploy --template-file /opt/flight/templates/aws/node.yaml --stack-name mycluster-gateway1 \
    --parameter-overrides nodename=gateway1 \
    sshKeyName=EC2_KEYPAIR_NAME_HERE \
    networkSecurityGroupID=SECURITY_GROUP_ID_HERE \
    networkSubnetID=NETWORK_SUBNET_ID_HERE \
    sourceimage=AMI_ID_HERE

- Deploy node01::

    aws cloudformation deploy --template-file /opt/flight/templates/aws/node.yaml --stack-name mycluster-node01 \
    --parameter-overrides nodename=node01 \
    sshKeyName=EC2_KEYPAIR_NAME_HERE \
    networkSecurityGroupID=SECURITY_GROUP_ID_HERE \
    networkSubnetID=NETWORK_SUBNET_ID_HERE \
    sourceimage=AMI_ID_HERE
    
- Deploy node02::

    aws cloudformation deploy --template-file /opt/flight/templates/aws/node.yaml --stack-name mycluster-node02 \
    --parameter-overrides nodename=node02 \
    sshKeyName=EC2_KEYPAIR_NAME_HERE \
    networkSecurityGroupID=SECURITY_GROUP_ID_HERE \
    networkSubnetID=NETWORK_SUBNET_ID_HERE \
    sourceimage=AMI_ID_HERE
    
- Configure ``/etc/hosts`` on gateway and nodes::

    cat << EOF >> /etc/hosts
    10.10.3.67    gateway1
    10.10.8.10    node01
    10.10.4.54    node02
    EOF

.. note:: The IP addresses of your nodes may differ. Use the CLI tools or GUI to determine the internal IP addresses to be used in the hosts file.

- Setup passwordless root SSH to all compute nodes from the gateway. This can be done by generating a public key with ``ssh-keygen`` and adding it to ``/root/.ssh/authorized_keys`` on the gateway and all other nodes.

