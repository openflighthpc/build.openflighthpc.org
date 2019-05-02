Create Domain
-------------

Deploy the domain with::

    [root@myhost ~]# flight cloud aws deploy mydomain domain
    Deploying: /opt/flight/tools/cloudware/var/aws/clusters/default/lib/templates/domain/domain.yaml
    [└] Deploying resources..

Wait until the deployment has completed before moving on to the gateway.

Deploy Gateway
--------------

Deploy the gateway with::

    [root@myhost ~]# flight cloud aws deploy gateway1 node/gateway1 -p "securitygroup,network1SubnetID=*mydomain"
    Deploying: /opt/flight/tools/cloudware/var/aws/clusters/default/lib/templates/node/gateway1/gateway1.yaml
    [└] Deploying resources..

When this command exits the node is still deploying, it's worth waiting at least a couple of minutes for the gateway to come up and configure itself before deploying the compute nodes.

Deploy Compute Nodes
--------------------

Deploy the nodes with (replacing ``node01`` with the next incremented node)::

    [root@myhost ~]# flight cloud aws deploy node01 node/node01 -p "securitygroup,network1SubnetID=*mydomain"
    Deploying: /opt/flight/tools/cloudware/var/aws/clusters/default/lib/templates/node/node01/node01.yaml
    [└] Deploying resources..

