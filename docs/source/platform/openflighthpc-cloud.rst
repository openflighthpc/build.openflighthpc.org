.. _openflighthpc-cloud:

openFlightHPC Cloud
===================

openFlightHPC Cloud is a platform-agnostic orchestration tool for cloud service providers. It provides a simplified command line interface for deploying, managing and destroying cloud instances in a consistent manner. Unlike other cloud-agnostic tools, openFlightHPC Cloud doesn't abstract deployment templates from native service provider formats which means that existing deployment templates can be added to the tool with ease. 

Providers
---------

Currently, openFlightHPC Cloud supports AWS and Azure using the native CloudFormation and ARM templates (respectively). 

Parameter Substitution
----------------------

As cloud resources are closely interconnected there are 2 options to deploying complex network structures with many resources, namely:

- **All-in-one Template:** With this solution, all resources are within a single template file. This allows for resources to reference each other easily but can lead to large, difficult to navigate template files.
- **Multiple Templates:** Utilising separate templates allows for clearer template separation but requires the passing of resource identifiers between templates (usually via question/answer parameters defined in the templates themselves). 

openFlightHPC Architect renders both all-in-one and separate templates for a configured cluster architecture. openFlightHPC Cloud adds helpers to ease the deployment of separate templates that have dependencies on resources outside of the template itself through parameter passing.






Resource Types
--------------

Domain
^^^^^^


Node
^^^^



Special Tags
------------

MENTION SOMETHING REGARDING GROUPS


Compatibility with openFlightHPC Architect
------------------------------------------

When a cluster architecture has been configured with :ref:`openFlightHPC Architect it can be exported <architect-export>` for usage with openFlightHPC Cloud. 

The openFlightHPC Cloud tool knows which template files it needs to import for deploying resources to the cloud. These imported templates can then be fired at the chosen provider to deploy the resources.  
