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

* Develop working instructions and/or code for running script as a service:
