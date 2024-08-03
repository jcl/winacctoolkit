=============================
 ``account-maintenance.cmd``
=============================


Recommended commands for manual invocation of this tool
-------------------------------------------------------

Execute in cmd.exe shell::

    ::  execute in cmd.exe shell, running under user account that has
    ::  'Administrators' security group membership (or similar), and is
    ::  running with "elevated" privileges


    ::  optional: check what user account we are running under:
    whoami.exe

    ::  optional: check if we have needed privileges:
    ::
    ::            if we do, this command will print:
    ::                There are no entries in the list.
    ::
    ::            if we do not, this command will print:
    ::                System error 5 has occurred.
    ::
    ::                Access is denied.
    ::
    ::  note: according to a superuser.com comment, this command requires the
    ::        'Server' service to be running.
    net.exe session


    ::  find full path to account-maintenance.cmd below %USERPROFILE%\..
    ::  (usually: c:\Users ):
    ::
    ::  I recommend cloning the 'winacctoolkit' git repository into a
    ::  directory somewhere in a user's %USERPROFILE% .  Since we likely will
    ::  be executing under another user account, search the file system for
    ::  'account-maintenance.cmd' recursively one level above the current
    ::  %USERPROFILE% directory:
    ::
    ::  NOTE: if more than 1 account-maintenance.cmd is found, the last is
    ::        used.
    ::
    ::  (I added this to have a universal and somewhat robust set of commands
    ::  that can just be copy/pasted, and will work in most scenarios.  It can
    ::  of course be replaced with just specifying the full path to
    ::  account-maintenance.cmd manually.)
    ::
    ::  See note(s): [0]
    set __ac_cmd=
    for /f "delims= usebackq" %p in (`where.exe /R %USERPROFILE%\.. account-maintenance.cmd`) do @set __ac_cmd=%p


    ::  execute account-maintenance.cmd :
    set __debug=true & set __verbose=true & %__ac_cmd%


Notes
-----

.. [0] The ``where.exe /R %USERPROFILE%\.. account-maintenance.cmd`` command
       could also be replaced with cmd.exe shell command::

           dir /B /S "%USERPROFILE%\..\*account-maintenance.cmd"

       The downside to this ``dir`` command is that it will find any file with
       a filename that ends in ``account-maintenance.cmd`` .

       I am not aware of in which version of Windows the ``where.exe`` command
       was introduced.  Using the ``dir`` command might be more backwards
       compatible.
