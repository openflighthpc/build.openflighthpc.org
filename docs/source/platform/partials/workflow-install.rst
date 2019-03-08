Install Cloudware
-----------------

Cloudware is a Ruby tool that requires Ruby 2.5+ to operate. 

In this guide, the installation will use Flight Core to provide both the Ruby environment and command line helpers.

Firstly, the Flight Core environment will need to be installed as root on a CentOS 7 system::

    [root@myhost ~]# yum install https://s3-eu-west-1.amazonaws.com/alces-flight/rpms/flight-core-0.1.0%2B20190121150201-1.el7.x86_64.rpm

Once installation has completed the Flight Core tool will needed to be added to the path, this can be done by logging out and back in or sourcing the profile script::

    [root@myhost ~]# source /etc/profile.d/alces-flight.sh
    [root@myhost ~]# flight
    Usage: flight COMMAND [[OPTION]... [ARGS]]
    Perform high performance computing management activities.

    Commands:
      flight help             Display help and usage information.
      flight shell            Enter a shell-like sandbox for a Flight command.

    For more help on a particular command run:
      flight COMMAND help

    Please report bugs to <flight@alces-flight.com>
    Alces Flight home page: <https://alces-flight.com/>

Now that Flight Core environment has been setup, the latest version of Cloudware can be installed automatically with the following command:: 

    [root@myhost ~]# curl https://raw.githubusercontent.com/openflighthpc/flight-cloud/develop/scripts/install |/bin/bash

Before Cloudware can be run it will need cloud provider credentials in order to access your account. Copy the example template into place::

    [root@myhost ~]# cp /opt/flight/tools/cloudware/etc/config.yaml.example /opt/flight/tools/cloudware/etc/config.yaml

Open ``/opt/flight/tools/cloudware/etc/config.yaml`` with your favourite text editor and populate it with access tokens and credentials.

Now Cloudware is installed and can be executed with Flight Core::

    [root@myhost ~]# flight cloud-aws
      NAME:

        cloud-aws

      DESCRIPTION:

        Cloud orchestration tool

      COMMANDS:

        cluster Manage the current cluster selection
        deploy  Deploy new resource(s) define by a template
        destroy Destroy a deployment and related resouces
    <snip>

    [root@myhost ~]# flight cloud-azure
      NAME:

        cloud-azure

      DESCRIPTION:

        Cloud orchestration tool

      COMMANDS:

        cluster Manage the current cluster selection
        deploy  Deploy new resource(s) define by a template
        destroy Destroy a deployment and related resouces
    <snip>

For more information regarding customisation of the installer see the `Cloudware installation guide <https://github.com/alces-software/cloudware/blob/master/INSTALL.md/>`_.

