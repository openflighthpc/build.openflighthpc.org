Upload Rendered Files
---------------------

S3
^^

To upload the rendered files for the clusters up to S3 use ``s3cmd`` as follows::

    s3cmd sync -P --acl-public --delete-removed /var/lib/architect/clusters/ s3://mybucketname/

.. note:: The ``s3cmd`` command is most likely not installed on your system, for more information on installing it see `the s3cmd documentation <https://github.com/s3tools/s3cmd/blob/master/INSTALL>`_.
