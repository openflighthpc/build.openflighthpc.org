Import Cluster
--------------

Clusters which have been configured and rendered with Architect can be imported into Cloud with the :ref:`manifest file <architecture/openflighthpc-architect-reference:Manifest Export>`. To import the templates and node date from the manifest file run::

    [root@myhost ~]# bin/cloud import /var/lib/architect/clusters/mycluster/var/rendered/manifest.yaml
