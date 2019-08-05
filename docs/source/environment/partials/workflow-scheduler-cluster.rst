Run First Stage Scripts
-----------------------

Run first stage scripts with::

    [root@myhost ~]# bin/manage script run -s first
    nfs executed with exit code 0


Run Second Stage Scripts
-------------------------

Run second stage scripts with::

    [root@myhost ~]# bin/manage script run -s second
    flightdirect executed with exit code 0


Run Third Stage Scripts
-----------------------

Run third stage scripts with::

    [root@myhost ~]# bin/manage script run -s third
    slurm executed with exit code 0

