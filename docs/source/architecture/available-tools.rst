.. _architecture-available-tools:

Available Tools
===============

There are many tools out there to aid with cluster architecture design. Some of these are covered below


+---------------+---------------+--------------------+-------+-------------------+
|               | openFlightHPC | openhpc.community  | xCAT  | RedHat CloudForms |
| Platform      | Architect     |                    |       |                   |
+===============+===============+====================+=======+===================+
| AWS           |     ``y``     |       ``*``        | ``y`` |       ``n``       |
+---------------+---------------+--------------------+-------+-------------------+
| Azure         |     ``y``     |       ``*``        | ``y`` |       ``n``       |
+---------------+---------------+--------------------+-------+-------------------+
| Metal         |     ``y``     |       ``*``        | ``y`` |       ``*``       |
+---------------+---------------+--------------------+-------+-------------------+
| libvirt       |     ``y``     |       ``*``        | ``y`` |       ``y``       |
+---------------+---------------+--------------------+-------+-------------------+
| Virtualbox    |     ``y``     |       ``*``        | ``y`` |       ``n``       |
+---------------+---------------+--------------------+-------+-------------------+

``*`` is for partial support. Technically these platforms are supported if a correct base system is configured. This is not considered full support as deployment methods for these platforms are not part of the tool. It may also be that certain features of these tools are unavailable on this platform type.



:ref:`openFlightHPC Architect <openflighthpc-architect>`
--------------------------------------------------------

openFlightHPC Architect is a cluster architecture tool which focuses on the logical configuration of the cluster and implicitly handls variations between platforms. 

`openhpc.community <http://openhpc.community>`_
-----------------------------------------------


`xCAT <https://xcat.org>`_
--------------------------


`RedHat CloudForms <https://www.redhat.com/en/technologies/management/cloudforms>`_
-----------------------------------------------------------------------------------




