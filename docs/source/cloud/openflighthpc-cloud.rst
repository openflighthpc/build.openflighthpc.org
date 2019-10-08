.. _openflighthpc-cloud:

openFlightHPC Cloud
===================

openFlightHPC Cloud is a platform-agnostic orchestration tool for cloud service providers. It provides a simplified command line interface for deploying, managing and destroying cloud instances in a consistent manner. Unlike other cloud-agnostic tools, openFlightHPC Cloud doesn't abstract deployment templates from native service provider formats which means that existing deployment templates can be added to the tool with ease. 

Providers
---------

Currently, openFlightHPC Cloud supports AWS and Azure using the native CloudFormation and ARM templates (respectively). 

Clusters
--------

Cloud provides the functionality to manage and store multiple cloud clusters. Each cluster that is created will be specifically for one of the supported platforms.

More information on creating and managing multiple clusters can be found in the :ref:`Cloud reference <cloud/openflighthpc-cloud-reference:Clusters>`

Parameter Substitution
----------------------

As cloud resources are closely interconnected there are 2 options to deploying complex network structures with many resources, namely:

- **All-in-one Template:** With this solution, all resources are within a single template file. This allows for resources to reference each other easily but can lead to large, difficult to navigate template files.
- **Multiple Templates:** Utilising separate templates allows for clearer template separation but requires the passing of resource identifiers between templates (usually via question/answer parameters defined in the templates themselves). 

openFlightHPC Architect renders both all-in-one and separate templates for a configured cluster architecture. openFlightHPC Cloud adds helpers to ease the deployment of separate templates that have dependencies on resources outside of the template itself through parameter passing.

Parameter Format
^^^^^^^^^^^^^^^^

To openFlightHPC Cloud, a parameter is a string between ``%``. The following example is an extract from an AWS CloudFormation template with a parameter called ``securitygroup``::

    GroupSet:
    - %securitygroup%

.. note:: ``deployment_name`` is an implicit parameter that is passed to the template by Cloud. This allows for resources to be dynamically renamed to match the name provided on the command line.

.. _cloud-parameter-passing:

Parameter Passing
^^^^^^^^^^^^^^^^^

Parameters can be generic strings or references to other Cloud deployments. The values to replace parameters with are given on the command line, for example::

    [root@myhost ~]# bin/cloud deploy node01 --params "keyname=mysshkeyname securitygroup=*cluster-domain"

In the above, any occurences of ``%keyname%`` will be replaced with ``mysshkeyname`` and any occurences of ``%securitygroup%`` will be replaced with the value of ``securitygroup`` from the outputs of the deployment ``cluster-domain``. The asterisk (``*``) in front of ``cluster-domain`` is what lets Cloud know to reference values from another deployment instead of doing arbitrary string replacement.

Multiple parameters can be replaced with corresponding values from a deployment by comma-separating the key names::

    [root@myhost ~]# bin/cloud deploy node01 --params "keyname=mysshkeyname securitygroup,network1SubnetID=*cluster-domain"

Resource Types
--------------

While any valid template for supported providers can be deployed with Cloud, there are a couple of key concepts that Cloud has built itself around to provide helper tools and similarities to non-cloud cluster deployments.

Deployment
^^^^^^^^^^

A deployment is the name given to resources that have been launched with Cloud.

Domain
^^^^^^

A domain refers to a deployment of resources that provide the networking components of a cluster deployment (subnet, security groups, routing). 

Node
^^^^

A node is a cloud machine instance, usually connected to the domain in some way. Nodes could be deployed from separate templates or together as a group.


Special Tags
------------

openFlightHPC Cloud will arbitrarily read output variables from deployments. These outputs are then used for :ref:`paramater passing <cloud-parameter-passing>`. There are also tags that Cloud will handle on a node basis should they be present:

- **nodenameTAGID** - The ``ID`` of ``nodename``. Setting this to the instance ID of the node will allow for power management support.
- **nodenameTAGgroups** - The "groups" to which ``nodename`` belongs. Setting groups allows for power commands to be run on a number of nodes at a time.
- **nodenameTAG** - Setting ``nodenameTAG`` with any string following ``TAG`` will set the string as an attribute of the given nodename.

The above tags allow for multiple nodes to be deployed from a single template but still be handled individually by Cloud for things like power management
