@echo off
setlocal enableextensions enabledelayedexpansion

::  notes:
::
::  * The challenge of getting the current (local) time in a string of text,
::    in a consistent format:
::
::    Observations:
::
::      - On Windows 11, one locale setting [cmd.exe shell session]:
::
::            $ echo %TIME%
::            14:25:26.08
::
::      - On Windows 11, another locale setting [cmd.exe shell session]:
::
::            $ echo %TIME%
::            14.24.46,88
::
::    The workaround I chose is to extract each hh mm ss components (and
::    assume that in the %TIME% value, the order is always the same, and
::    delimiters are always 1 character, regardless of localization):
::    here's an example [cmd.exe shell session]:
::
::        $ set time_str=%TIME%
::
::        $ echo %TIME:~0,8% & echo %time_str:~0,2%:%time_str:~3,2%:%time_str:~6,2%
::        16:07:45
::        16:07:45
::
::        $


::  define constants
set loop1_until_minutesecond=58:58
set loop2_until_minutesecond=59:53
set loop3_until_minutesecond=00:00
set loop1_sleep_seconds=60
set loop2_sleep_seconds=5
set loop3_sleep_seconds=1

if defined __debug echo [%TIME:~0,8%] DEBUG: %%0:         "%0"
if defined __debug echo [%TIME:~0,8%] DEBUG: %%~dp0:      "%~dp0"
if defined __debug echo [%TIME:~0,8%] DEBUG: %%~dp0:      "%~dp0..\etc\account-maintenance.conf"
set __conffile=%~dp0..\etc\account-maintenance.conf
if defined __debug echo [%TIME:~0,8%] DEBUG: __conffile: "!__conffile!"


::  check that configuration file exist and contains the required options
if not exist "!__conffile!" ( call :__error_before_exit1 "configuration file does not exist: !__conffile!" & exit /b 1 )
findstr.exe /R /C:"^username_to_maintain="      "%__conffile%" >nul || ( call :__error_before_exit1 "username_to_maintain= not found in configuration file" & exit /b 1 )
findstr.exe /R /C:"^cleartext_password_to_set=" "%__conffile%" >nul || ( call :__error_before_exit1 "cleartext_password_to_set= not found in configuration file" & exit /b 1 )

::  load options from configuration file into environment variables
for /f "usebackq delims== tokens=1,2" %%i in (`findstr.exe /R /C:"^username_to_maintain="      "%__conffile%"`) do set __%%i=%%j
for /f "usebackq delims== tokens=1,2" %%i in (`findstr.exe /R /C:"^cleartext_password_to_set=" "%__conffile%"`) do set __%%i=%%j
if defined __debug echo [%TIME:~0,8%] DEBUG: __username_to_maintain:      "%__username_to_maintain%"
if defined __debug echo [%TIME:~0,8%] DEBUG: __cleartext_password_to_set: "%__cleartext_password_to_set%"


call :verbose__net_exe_user !__username_to_maintain!

:_state_reset
set current_hour=%TIME:~0,2%
set /a target_hour=%current_hour%+1
if defined __debug echo [%TIME:~0,8%] DEBUG: variable current_hour: "%current_hour%"
if defined __debug echo [%TIME:~0,8%] DEBUG: variable target_hour: "%target_hour%"


:_state_loop1
set time_str=%TIME%
IF %time_str:~0,2%:%time_str:~3,2%:%time_str:~6,2% LSS %current_hour%:!loop1_until_minutesecond! (
    if defined __debug echo [%TIME:~0,8%] DEBUG: current time is before %current_hour%:!loop1_until_minutesecond!, sleeping for !loop1_sleep_seconds! second^(s^).
    timeout.exe /t !loop1_sleep_seconds! 1>NUL
    goto _state_loop1
) else (
    rem  here: current time must be xx:58:58 or later.
    rem  increase speed of "polling" to every 5 seconds.
:_state_loop2
    set time_str=%TIME%
    IF %time_str:~0,2%:%time_str:~3,2%:%time_str:~6,2% LSS %current_hour%:!loop2_until_minutesecond! (
        if defined __debug echo [%TIME:~0,8%] DEBUG: current time is before %current_hour%:!loop2_until_minutesecond!, sleeping for !loop2_sleep_seconds! second^(s^).
        timeout.exe /t !loop2_sleep_seconds! 1>NUL
        goto _state_loop2
    ) else (
        rem  here: current time must be xx:59:53 or later.
        rem  increase speed of "polling" to every 1 seconds.
:_state_loop3
        set time_str=%TIME%
        echo %time_str:~0,2%:%time_str:~3,2%:%time_str:~6,2% | findstr.exe /r "^%target_hour%:!loop3_until_minutesecond!" 1>NUL && (
            call :verbose__net_exe_user !__username_to_maintain!
            if defined __verbose echo [%TIME:~0,8%] Attempting to set password for user account...
            rem  if defined __debug echo [%TIME:~0,8%] DEBUG: doing nothing for now.
            net.exe user !__username_to_maintain! "!__cleartext_password_to_set!"
            if defined __verbose echo [%TIME:~0,8%] done.
            call :verbose__net_exe_user !__username_to_maintain!
        ) || (
            if defined __debug echo [%TIME:~0,8%] DEBUG: current time is not %target_hour%:!loop3_until_minutesecond!, sleeping for !loop3_sleep_seconds! second^(s^).
            timeout.exe /t !loop3_sleep_seconds! 1>NUL
            goto _state_loop3
        )
    )
)
goto _state_reset

goto :eof



::  subroutines

:verbose__net_exe_user
if defined __verbose (
    echo [%TIME:~0,8%] excerpt of "net.exe user %1":
    for /f "usebackq delims=" %%l in (`net.exe user %1 ^| findstr.exe /c:"User name" /c:"Password last set" /c:"Last logon" /c:"Local Group Memberships"`) do echo [%TIME:~0,8%]    %%l
)
goto :eof


:__error_before_exit1
echo [%TIME:~0,8%] error: %~1.  exiting. 1>&2
goto :eof
