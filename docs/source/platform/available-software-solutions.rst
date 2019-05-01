.. _platform-available-software-solutions:

Available Tools
===============

+---------------+---------------+---------------+---------+-----------+-----------+
|               | openFlightHPC | openFlightHPC | AWS CLI | Azure CLI | Terraform |
| Platform      | Cloud         | Metal         |         |           |           |
+===============+===============+===============+=========+===========+===========+
| AWS           |     ``y``     |     ``n``     |  ``y``  | ``n``     |   ``y``   |
+---------------+---------------+---------------+---------+-----------+-----------+
| Azure         |     ``y``     |     ``n``     |  ``n``  | ``y``     |   ``y``   |
+---------------+---------------+---------------+---------+-----------+-----------+
| Metal         |     ``n``     |     ``y``     |  ``n``  | ``n``     |   ``y``   |
+---------------+---------------+---------------+---------+-----------+-----------+
| libvirt       |     ``n``     |     ``*``     |  ``n``  | ``n``     |   ``y``   |
+---------------+---------------+---------------+---------+-----------+-----------+
| Virtualbox    |     ``n``     |     ``*``     |  ``n``  | ``n``     |   ``y``   |
+---------------+---------------+---------------+---------+-----------+-----------+

``*`` is for partial support. Technically these platforms are supported if a correct base system is configured. This is not considered full support as deployment methods for these platforms are not part of the tool. It may also be that certain features of these tools are unavailable on this platform type.

.. _openflight-cloud:

:ref:`openFlightHPC Cloud <openflighthpc-cloud>`
------------------------------------------------

openFlightHPC Cloud is a cloud deployment management tool in the openFlightHPC toolbox (an open-source, community HPC project). The tool takes AWS and Azure formation templates and deploys them whilst tracking outputs. Additionally the tool provides simple parameter parsing to connect separate deployment information (network IDs, security groups, etc) to simplify cluster deployment.


.. _openflight-metal:

:ref:`openFlightHPC Metal <openflighthpc-metal>`
------------------------------------------------

openFlightHPC Metal is a metal/virtual deployment management tool in the openFlightHPC toolbox (an open-source, community HPC project). The tool manages kickstart and PXElinux files for building nodes and provides power helper tools to streamline the build process.

.. _aws-cli:

`AWS CLI <https://aws.amazon.com/cli/>`_
----------------------------------------

The Amazon Web Services CLI provides tools for deploying AWS resources. All types of AWS resources can be managed via this tool.

.. _azure-cli:

`Azure CLI <https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest>`_
-------------------------------------------------------------------------------------------------

The Microsoft Azure CLI provides tools for deploying Azure resources. All types of Azure resources can be managed via this tool.

.. _terraform:

`Terraform <https://www.terraform.io/>`_
----------------------------------------

Terraform is a deployment tool that has many plugins for different providers. The tool itself uses an application-specific templating format for deploying resources. While flexible, it requires learning a new interface to all platforms instead of using existing templates and methodologies for deployment.

