.. _cloud-workflow-aws:

Workflow: AWS
=============

.. include:: /cloud/partials/workflow-prerequisites.rst

Template Parameters
-------------------

There are multiple parameters in the template, some are required and others are optional, these are outlined below:

- ``sourceimage`` - The AMI ID to use for both the gateway and compute nodes
- ``clustername`` - The name of the cluster, to be used as part of the FQDN for nodes
- ``customdata`` - A base64 encoded cloudinit string for both the gateway and compute nodes
- ``computeNodesCount`` - The number of compute nodes to deploy, a value between 2 and 8 (default: 2)
- ``gatewayinstancetype`` - The instance type to be used for the gateway node (default: t2.small)
- ``computeinstancetype`` - The instance type to be used for the compute nodes (default: t2.small)

Deploy Resources
----------------

- Download the OpenFlight AWS template::

    $ curl -o cluster.yaml https://raw.githubusercontent.com/openflighthpc/openflight-compute-cluster-builder/master/templates/aws/cluster.yaml

- Generate base64 customdata string to set the default username to ``flight`` and add an SSH public key for authentication::

    $ DATA=$(cat << EOF
    #cloud-config
    system_info:
      default_user:
        name: flight
    runcmd:
      - echo "ssh-rsa MySSHpublicKeyHere user@host" >> /home/flight/.ssh/authorized_keys
    EOF
    )
    $ echo "$DATA" |base64 -w 0
    I2Nsb3VkLWNvbmZpZwpzeXN0ZW1faW5mbwogIGRlZmF1bHRfdXNlcjoKICAgIG5hbWU6IGZsaWdodApydW5jbWQ6CiAgLSBlY2hvICJzc2gtcnNhIE15U1NIcHVibGljS2V5SGVyZSB1c2VyQGhvc3QiID4+IC9ob21lL2ZsaWdodC8uc3NoL2F1dGhvcml6ZWRfa2V5cwo=

.. note:: The base64 value will differ from the above depending on the SSH key specified. It does *not* need to match the example output above.

- Deploy a cluster (with a gateway and 2 nodes)::

    $ aws cloudformation deploy --template-file cluster.yaml --stack-name mycluster \
    --parameter-overrides sourceimage="AMI_ID_HERE" \
    clustername="mycluster" \ 
    customdata="I2Nsb3VkLWNvbmZpZwpzeXN0ZW1faW5mbwogIGRlZmF1bHRfdXNlcjoKICAgIG5hbWU6IGZsaWdodApydW5jbWQ6CiAgLSBlY2hvICJzc2gtcnNhIE15U1NIcHVibGljS2V5SGVyZSB1c2VyQGhvc3QiID4+IC9ob21lL2ZsaWdodC8uc3NoL2F1dGhvcml6ZWRfa2V5cwo="

.. note:: The above command can be modified to override the other parameters mentioned at the beginning of this page. The 3 parameters used in the above command are the minimum required to bring a cluster up

- Configure ``/etc/hosts`` on gateway and nodes::

    $ cat << EOF >> /etc/hosts
    10.10.3.67    gateway1
    10.10.8.10    node01
    10.10.4.54    node02
    EOF

.. note:: The IP addresses of your nodes may differ. Use the CLI tools or GUI to determine the internal IP addresses to be used in the hosts file.

- Setup passwordless root SSH to all compute nodes from the gateway. This can be done by generating a public key with ``ssh-keygen`` and adding it to ``/root/.ssh/authorized_keys`` on the gateway and all other nodes.

