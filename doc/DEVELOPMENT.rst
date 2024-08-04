=======================
 DEVELOPMENT workspace
=======================


``bin/account-maintenance.cmd``
===============================

Development TO-DO
-----------------

* [_] Fix this bug::

    [23:57:43] DEBUG: current time is before 23:58:58, sleeping for 60 second(s).
    [23:58:43] DEBUG: current time is before 23:58:58, sleeping for 60 second(s).
    [23:59:43] DEBUG: current time is before 23:59:53, sleeping for 5 second(s).
    [23:59:48] DEBUG: current time is before 23:59:53, sleeping for 5 second(s).
    [23:59:53] DEBUG: current time is not 24:00:00, sleeping for 1 second(s).
    [23:59:54] DEBUG: current time is not 24:00:00, sleeping for 1 second(s).
    [23:59:55] DEBUG: current time is not 24:00:00, sleeping for 1 second(s).
    [23:59:56] DEBUG: current time is not 24:00:00, sleeping for 1 second(s).
    [23:59:57] DEBUG: current time is not 24:00:00, sleeping for 1 second(s).
    [23:59:58] DEBUG: current time is not 24:00:00, sleeping for 1 second(s).
    [23:59:59] DEBUG: current time is not 24:00:00, sleeping for 1 second(s).
    [ 0:00:00] DEBUG: current time is not 24:00:00, sleeping for 1 second(s).
    [ 0:00:01] DEBUG: current time is not 24:00:00, sleeping for 1 second(s).
    [ 0:00:02] DEBUG: current time is not 24:00:00, sleeping for 1 second(s).
    [ 0:00:03] DEBUG: current time is not 24:00:00, sleeping for 1 second(s).
    [ 0:00:04] DEBUG: current time is not 24:00:00, sleeping for 1 second(s).
    [ 0:00:05] DEBUG: current time is not 24:00:00, sleeping for 1 second(s).
    [ 0:00:06] DEBUG: current time is not 24:00:00, sleeping for 1 second(s).
    [ 0:00:07] DEBUG: current time is not 24:00:00, sleeping for 1 second(s).
    [ 0:00:08] DEBUG: current time is not 24:00:00, sleeping for 1 second(s).
    [ 0:00:09] DEBUG: current time is not 24:00:00, sleeping for 1 second(s).

* [_] Add feature: set password immediately when script starts.

* [_] Add feature: at script startup, check if we have privileges:

      Check group membership and ``net.exe session`` .
      Log to verbose output.

IDEAS
-----

* Develop working instructions and/or code for running
  ``account-maintenance.cmd`` as a service:

  Notes from initial naive attempt on Windows 10:

      Excerpt from cmd.exe shell session::

          C:\WINDOWS\system32>sc.exe create account-maintenance start= auto DisplayName= "account-maintenance" binPath= "%SystemRoot%\system32\cmd.exe /C set __verbose=true & set __debug=true & c:\Users\jcl\proj\winacctoolkit\bin\account-maintenance.cmd >> c:\Users\jcl\proj\winacctoolkit\account-maintenance.log 2>&1"
          [SC] CreateService SUCCESS

          C:\WINDOWS\system32>sc.exe start account-maintenance
          [SC] StartService FAILED 1053:

          The service did not respond to the start or control request in a timely fashion.


          C:\WINDOWS\system32>

      Observed above, when starting service:
      cmd.exe script is started, log file is created and written to, but for
      some reason Windows doesn't consider the service started.

  Ideas for next step:

  - try using https://github.com/mturk/svcbatch :

        SvcBatch is a program that allows users to run script files as
        Windows service.

    My initial security evaluation:

        The author seems to have a long history of contributions to free
        software: Apache projects, Apache Tomcat etc.

        Related links:

        | https://www.mail-archive.com/dev@tomcat.apache.org/msg149344.html
