Install Architect
-----------------

Architect is a Ruby tool that requires Ruby 2.5+ to operate. This can use an existing Ruby installation on the machine being used to generate templates (for more information see the Architect installation guide).
 
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
 
Now that Flight Core environment has been setup, the latest version of Architect can be installed automatically with the following command::

    [root@myhost ~]# curl https://raw.githubusercontent.com/alces-software/architect/master/scripts/install |/bin/bash
 
Now Architect is installed and can be executed with Flight Core::
 
    [root@myhost ~]# flight architect
      NAME:

        architect

      DESCRIPTION:

        Tool for managing standard config hierarchy and template rendering under-lying Alces clusters and other Alces tools

      COMMANDS:

        cluster      List, switch, and delete cluster configurations
        configure    Configure different aspects of this Architect installation
        each         Runs a command for a node(s)
    <snip>
     
For more information regarding customisation of the installer see the `Architect installation guide <https://github.com/alces-software/underware/blob/master/INSTALL.md/>`_.

