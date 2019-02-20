.. _openflighthpc-architect:

openFlightHPC Architect
=======================

openFlightHPC Architect is a powerful templating tool that aims to reduce the architectural configuration overhead of a cluster computing system. Through utilising genders-style grouping and configuration inheritance a set of templates for installing and configuring a cluster with many nodes can be generated in minutes.

With the concept of different platforms (AWS, Azure, Libvirt, Kickstart, Virtualbox) built into the Architect tool, templates for deploying a cluster on to all platforms are generated meaning your cluster is not restricted to one platform based on configuration.

.. _source-configuration-templates:

Source Configuration & Templates
--------------------------------

Architect comes pre-packaged with configurations and basic template files for cluster architectures. An example deployment file is provided for each platform (formation templates for cloud, kickstart/pxeboot files for metal and virtual machine configurations for libvirt/VirtualBox) as well as some general setup scripts (for networks, hostname and SSH access). 

These files are stored at ``<architect home>/data/base/`` with the following structure:

- ``etc/configure.yaml`` - This file defines the questions to be asked at the various configuration levels.
- ``etc/configs/`` - This directory holds the configuration information used when templating deployment scripts and contains the following:
  - ``domain.yaml`` - The top-level configuration file.
  - ``platforms/*.yaml`` - Platform-specific content overrides. For example, modification of interface naming.
  - ``groups/*.yaml`` - Group-specific content overrides. Creating a file in here with the name of an existing group will add or modify configuration keys for the named group.
  - ``nodes/*.yaml`` - Node-specific content overrides. Much as with group, files created in here will override the settings of the corresponding node name.

- ``lib/templates/`` - Where platform and general scripts and files to be templated are stored.

  - ``genders`` - The template file used to generate a functional genders file for the cluster.
  - ``aws/``, ``azure/``, ``kickstart/``, ``libvirt/``, ``vbox/`` - Platform-specific files and scripts. Each of these directories can have ``domain/``, ``group/`` and ``node/`` directories for files to be rendered in said scope.
  - ``core/`` - Platform-agnostic files and scripts. This will contain ``domain/``, ``group/`` and ``node/`` directories for files to be rendered in said scope.

.. _cluster-configuration-templates:

Cluster Configuration & Templates
---------------------------------

openFlightHPC Architect can create, manage and store multiple cluster architectures (see :ref:`the Architect reference for more information <openflighthpc-architect-cluster-ref>`). With this functionality in mind, the source configuration and template files are copied to a cluster-specific directory upon creation. Each cluster is stored under ``/var/lib/underware/clusters/`` in a directory using the cluster name (e.g. ``mycluster`` is stored ``/var/lib/underware/clusters/mycluster/``)

The structure of the cluster directory is as follows:

- Identical structure of ``etc`` and ``lib`` to that of the :ref:`source configuration files <source-configuration-templates>`.
- ``var/answers/`` - This directory stores the answers to ``configure`` questions with the following structure

  - ``domain.yaml`` - Answers for domain-level questions
  - ``group/*.yaml`` - Group-level answers
  - ``node/*.yaml`` - Node-level answers

- ``var/cluster-attributes.yaml`` - This file contains the node and group mappings for the cluster. **This file should not be manuall modified in any way**
- ``var/rendered/`` - This directory contains all of the rendered templates for every node and platform combination in the cluster.

  - ``aws/``, ``azure/``, ``kickstart/``, ``libvirt/``, ``vbox/`` - These directories contain everything needed to deploy the cluster onto the given platform, each directory contains the following:

    - ``domain/{platform,core}/`` - Any domain-level platform and ``core`` files.
    - ``group/*/{platform,core}/`` - Any group-level platform and ``core`` files, stored in separate directories per group.
    - ``node/*/{platform,core}/`` - Any node-level platform and ``core`` files, stored in separate directories per group.

Questions/Answers
-----------------

Architect streamlines general configuration through interactive question/answer prompts which are stored along with the cluster templates. 

Questions are defined in ``configure.yaml`` (either at the :ref:`source level <source-configuration-templates>` [for new clusters] or in the :ref:`cluster directory <cluster-configuration-templates>` [for existing clusters]).

A question definition is structured as follows (beneath the ``questions:`` line in the file)::

      - &cluster_name
        identifier: cluster_name
        question: 'Name of the cluster'

It's best practice to keep the anchor (``&cluster_name``) and the identifier (``cluster_name``) consistent for referencing throughout the questions definition and config files. The ``question`` is what will be displayed on the prompt during :ref:`the configure process <architect-configure-cluster>`. 

Once a question has been defined it won't be asked unless added to one of the scope lists at the bottom of the file. The above example question is defined to be asked at the domain level::

    domain:
      - *cluster_name

Question Flags
^^^^^^^^^^^^^^

The following snippets are optional flags that can appended to question definitions.

::

    default: 'my default answer'

The placeholder/default answer for the question.

::

    choices:
      - option1
      - option2
      - option3

A list of available options, these will be displayed during the configure process and the user must select one of the options to continue.

::

    type: boolean

Defines the type of answer. Booleans will only accept ``true``/``false`` as valid answers. The other available types are:

- ``password`` which will prompt for a password twice and save the password in an encrypted format.
- ``integer`` which will only allow numerical answers.

Profiles
--------

Profiles provide additional automated configuration over the base content in Architect. A clean installation of Architect will yield a directory named ``example`` in ``<architect home>/data/`` which contains node and group information (in ``cluster-attributes.yaml``), configuration overrides (in ``etc/configs/``) and prepopulated answers (in ``var/answers``). 

When initialising a cluster with a profile, the base directory is copied to the cluster destination directory and then has the profile files applied over the top. 

Creating a profile is as straightforward as creating a directory in ``<architect home>/data/`` and populating it with templates, configuration files and content to update/append to the ``base`` profile. The directory name can then be used to :ref:`create a cluster from a profile <architect-create-cluster>`.

Templating
----------

In general, creating a HPC cluster (whether on-premise, cloud-based or on another platform) requires meticulous planning of the architecture, software stack and environment before building can commence.

The platform on which the cluster is to be deployed will affect various stages of the design and planning process. For example, network configurations between network switches and cloud networks are setup in different manners and can support varying subnet ranges. This is where templating with Alces Underware alleviates the complexities of platform selection by providing a generalised configuration method that handles platform-specific configuration tweaks.

openFlightHPC Architect addresses these concerns and inconsistencies between platforms by implementing a powerful templating system, providing such advantages as:

- Incremental IP addresses for node groups
- Platform-dependent configuration 
- Heirarchical cluster information (domain, group and node level configurations)
- Question/answer prompts for key information

Architect uses embedded Ruby in template files to customise scripts on a per-node or per-group basis. For example, the below YAML (from ``domain.yaml``) defines the network status, using references to answers::

    networks:
      network1:

Rendering
---------

As mentioned above, templates contain embedded Ruby to assist generating node (or group) specific versions of files. These unique files are generated when Architect is commanded to render them, this automatically occurs as part of the ``init`` process if using a cluster profile and can be manually triggered as follows::

    flight underware template

he above will render the cluster templates 
