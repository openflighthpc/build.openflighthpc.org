Manifest Export
---------------

A manifest file is provided with architect which is used to inform and distribute other OpenFlightHPC Tools to the data and templates for the configured cluster.

The manifest file is automatically rendered as part of ``bin/architect template`` but will need to be moved to the correct location in order for imports from the other tools to work (in this example a cluster called ``mycluster`` is used, replace this with the name of your cluster)::

    [root@myhost ~]# mv /var/lib/architect/clusters/mycluster/var/rendered/kickstart/domain/platform/manifest.yaml /var/lib/architect/clusters/mycluster/var/rendered/


