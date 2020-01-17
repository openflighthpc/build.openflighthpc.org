.. openFlightHPC-docs documentation master file, created by
   sphinx-quickstart on Thu Feb 14 19:45:18 2019.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

Welcome to the openFlightHPC Manage Knowledgebase!
==================================================

This site contains the documentation for the openFlightHPC project. It contains tips and tools for streamlining the building and management of HPC clusters and environments. While the documentation will mainly focus on the OpenFlightHPC cluster workflow there will be notes and tips to customising the process for varying workflows.

Documentation Goal
------------------

The purpose of this documentation is to provide understandable guidance to delivering the OpenFlightHPC Environment. This includes deploying resources on a given platform and installing the relevant software.

*Environment Delivery* is the installation of software for the user experience on the cluster. This usually involves some sort of resource management/queuing system and application installation.

.. note:: It is recommended to read through all of the documentation before starting to design the HPC platform to understand the scope and considerations.

Acknowledgements
----------------

We recognise the respect the trademarks of all third-party providers referenced in this documentation. Please see the respective EULAs for software packages used in configuring your own environment based on this knowledgebase.

License
^^^^^^^

This documentation is released under the `Creative-Commons: Attribution-ShareAlike 4.0 International <http://creativecommons.org/licenses/by-sa/4.0/>`_ license.

Table of Contents
=================

.. Navigation/TOC

.. toctree::
   :maxdepth: 1
   :caption: Cloud
   :name: cloud

   cloud/workflow-aws
   cloud/workflow-azure

.. toctree::
   :maxdepth: 1
   :caption: Cloud
   :name: cloud

   metal/workflow-manual

.. toctree::
   :maxdepth: 1
   :caption: Environment
   :name: environment

   environment/workflow-ansible
   environment/workflow-manual

.. toctree::
   :maxdepth: 1
   :caption: Power
   :name: power
   
   power/flight-power
   power/workflow-aws

