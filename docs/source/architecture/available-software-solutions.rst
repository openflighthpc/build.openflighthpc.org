.. _architecture-available-software-solutions:

Available Tools
===============

There are many tools out there to aid with cluster architecture design. Some of these are covered below


+---------------+---------------+--------------------+-------+-------------------+
|               | openFlightHPC | openhpc.community  | xCAT  | RedHat CloudForms |
| Platform      | Architect     |                    |       |                   |
+===============+===============+====================+=======+===================+
| AWS           |     ``y``     |       ``*``        | ``y`` |       ``y``       |
+---------------+---------------+--------------------+-------+-------------------+
| Azure         |     ``y``     |       ``*``        | ``y`` |       ``y``       |
+---------------+---------------+--------------------+-------+-------------------+
| Metal         |     ``y``     |       ``*``        | ``y`` |       ``*``       |
+---------------+---------------+--------------------+-------+-------------------+
| libvirt       |     ``y``     |       ``*``        | ``y`` |       ``y``       |
+---------------+---------------+--------------------+-------+-------------------+
| Virtualbox    |     ``y``     |       ``*``        | ``y`` |       ``n``       |
+---------------+---------------+--------------------+-------+-------------------+

``*`` is for partial support. Technically these platforms are supported if a correct base system is configured. This is not considered full support as deployment methods for these platforms are not part of the tool. It may also be that certain features of these tools are unavailable on this platform type.

.. _openflight-architect:

:ref:`openFlightHPC Architect <openflighthpc-architect>`
--------------------------------------------------------

openFlightHPC Architect is a cluster architecture tool in the openFlightHPC toolbox (an open-source, community HPC project). The tool focuses on the logical configuration of the cluster and implicitly handles variations between platforms. Architect provides platform-level deployment files (e.g. CloudFormation templates for AWS, kickstart files for metal builds).

.. _openhpc-community:

`openhpc.community <http://openhpc.community>`_
-----------------------------------------------

openhpc.community is a collaborative, community HPC project that provides various RPMs for configuring an existing OS into a cluster. 

.. _xcat:

`xCAT <https://xcat.org>`_
--------------------------

xCAT provides build tools for multiple platforms and operating systems which build and customise HPC clusters.

.. _redhat-cloudforms:

`RedHat CloudForms <https://www.redhat.com/en/technologies/management/cloudforms>`_
-----------------------------------------------------------------------------------

RedHat CloudForms is an orchestration platform designed for hybrid environments. It provides a unified dashboard for deploying systems on private and public cloud.

