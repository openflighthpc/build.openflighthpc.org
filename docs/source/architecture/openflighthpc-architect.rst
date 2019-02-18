.. _openflighthpc-architect:

openFlightHPC Architect
=======================

openFlightHPC Architect is a powerful templating tool that aims to reduce the architectural configuration overhead of a cluster computing system. Through utilising genders-style grouping and configuration inheritance a set of templates for installing and configuring a cluster with many nodes can be generated in minutes.

With the concept of different platforms (AWS, Azure, Libvirt, Kickstart, Virtualbox) built into the Architect tool, templates for deploying a cluster on to all platforms are generated meaning your cluster is not restricted to one platform based on configuration.

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
  - ``aws/``, ``azure/``, ``kickstart/``, ``libvirt/``, ``vbox/`` - Platform-specific files and scripts. Each of these directories can have domain/, group/ and node/ directories for files to be rendered in said scope.
  - ``core/`` - Platform-agnostic files and scripts. This will contain ``domain/``, ``group/`` and ``node/`` directories for files to be rendered in said scope.


Cluster Templates
-----------------




Profiles
--------





Templating
----------

In general, creating a HPC cluster (whether on-premise, cloud-based or on another platform) requires meticulous planning of the architecture, software stack and environment before building can commence.

The platform on which the cluster is to be deployed will affect various stages of the design and planning process. For example, network configurations between network switches and cloud networks are setup in different manners and can support varying subnet ranges. This is where templating with Alces Underware alleviates the complexities of platform selection by providing a generalised configuration method that handles platform-specific configuration tweaks.

openFlightHPC Architect addresses these concerns and inconsistencies between platforms by implementing a powerful templating system, providing such advantages as:

- Incremental IP addresses for node groups
- Platform-dependent configuration 
- Heirarchical cluster information (domain, group and node level configurations)
- Question/answer prompts for key information

Architect uses embedded Ruby in template files to customise scripts on a per-node or per-group basis. For example, 
