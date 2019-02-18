Import Cluster
--------------

Clusters which have been configured, rendered and exported with Architect can be imported into Cloudware. Examples for the supported cloud platforms are below.

AWS::

    [root@myhost ~]# flight cloud-aws import /root/underware-YYYY-MM-DD-HH-MM-SS.zip
    Imported: /opt/flight/tools/cloudware/var/aws/clusters/default/lib/templates/node/node08/node08.yaml
    Imported: /opt/flight/tools/cloudware/var/aws/clusters/default/lib/templates/node/node01/node01.yaml
    Imported: /opt/flight/tools/cloudware/var/aws/clusters/default/lib/templates/node/gateway1/gateway1.yaml
    Imported: /opt/flight/tools/cloudware/var/aws/clusters/default/lib/templates/node/node10/node10.yaml
    Imported: /opt/flight/tools/cloudware/var/aws/clusters/default/lib/templates/node/node02/node02.yaml
    Imported: /opt/flight/tools/cloudware/var/aws/clusters/default/lib/templates/node/node05/node05.yaml
    Imported: /opt/flight/tools/cloudware/var/aws/clusters/default/lib/templates/node/node03/node03.yaml
    Imported: /opt/flight/tools/cloudware/var/aws/clusters/default/lib/templates/node/node07/node07.yaml
    Imported: /opt/flight/tools/cloudware/var/aws/clusters/default/lib/templates/node/node06/node06.yaml
    Imported: /opt/flight/tools/cloudware/var/aws/clusters/default/lib/templates/node/node04/node04.yaml
    Imported: /opt/flight/tools/cloudware/var/aws/clusters/default/lib/templates/node/node09/node09.yaml
    Imported: /opt/flight/tools/cloudware/var/aws/clusters/default/lib/templates/group/nodes/nodes.yaml
    Imported: /opt/flight/tools/cloudware/var/aws/clusters/default/lib/templates/group/orphan/orphan.yaml
    Imported: /opt/flight/tools/cloudware/var/aws/clusters/default/lib/templates/group/login/login.yaml
    Imported: /opt/flight/tools/cloudware/var/aws/clusters/default/lib/templates/domain/domain.yaml
    Imported: /opt/flight/tools/cloudware/var/aws/clusters/default/lib/templates/domain/domainandallnodes.yaml

Azure::

    [root@myhost ~]# flight cloud-azure import /root/underware-YYYY-MM-DD-HH-MM-SS.zip
    Imported: /opt/flight/tools/cloudware/var/azure/clusters/default/lib/templates/node/node08/node08.json
    Imported: /opt/flight/tools/cloudware/var/azure/clusters/default/lib/templates/node/node01/node01.json
    Imported: /opt/flight/tools/cloudware/var/azure/clusters/default/lib/templates/node/gateway1/gateway1.json
    Imported: /opt/flight/tools/cloudware/var/azure/clusters/default/lib/templates/node/node10/node10.json
    Imported: /opt/flight/tools/cloudware/var/azure/clusters/default/lib/templates/node/node02/node02.json
    Imported: /opt/flight/tools/cloudware/var/azure/clusters/default/lib/templates/node/node05/node05.json
    Imported: /opt/flight/tools/cloudware/var/azure/clusters/default/lib/templates/node/node03/node03.json
    Imported: /opt/flight/tools/cloudware/var/azure/clusters/default/lib/templates/node/node07/node07.json
    Imported: /opt/flight/tools/cloudware/var/azure/clusters/default/lib/templates/node/node06/node06.json
    Imported: /opt/flight/tools/cloudware/var/azure/clusters/default/lib/templates/node/node04/node04.json
    Imported: /opt/flight/tools/cloudware/var/azure/clusters/default/lib/templates/node/node09/node09.json
    Imported: /opt/flight/tools/cloudware/var/azure/clusters/default/lib/templates/group/nodes/nodes.json
    Imported: /opt/flight/tools/cloudware/var/azure/clusters/default/lib/templates/group/orphan/orphan.json
    Imported: /opt/flight/tools/cloudware/var/azure/clusters/default/lib/templates/group/login/login.json
    Imported: /opt/flight/tools/cloudware/var/azure/clusters/default/lib/templates/domain/domainandallnodes.json
    Imported: /opt/flight/tools/cloudware/var/azure/clusters/default/lib/templates/domain/domain.json

The appropriate cloud templates are extracted and can now be used for launching the cluster.
