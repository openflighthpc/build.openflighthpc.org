Create Domain
-------------

Deploy the domain with::

    [root@myhost ~]# bin/cloud deploy domain
    [└] Deploying domain..

Wait until the deployment has completed before moving on to the gateway.

Deploy Gateway
--------------

Deploy the gateway with::

    [root@myhost ~]# bin/cloud deploy gateway1 -p "securitygroup,network1SubnetID=*domain"
    [└] Deploying node..

When this command exits the node is still deploying, it's worth waiting at least a couple of minutes for the gateway to come up and configure itself before deploying the compute nodes.

Deploy Compute Nodes
--------------------

Deploy the nodes with (replacing ``node01`` with the next incremented node)::

    [root@myhost ~]# bin/cloud deploy node01 -p "securitygroup,network1SubnetID=*domain"
    [└] Deploying node..

