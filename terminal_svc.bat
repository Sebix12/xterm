::@echo off
set terminp=%1
set defloc=%2
cd %defloc%
cd lib
::detection code below for MAIN software
if "%terminp%"=="help" set selectedcommand=help
if "t65%terminp%"=="config-create" set selectedcommand=createconfig
if "%terminp%"=="config-load" set selectedcommand=loadconfig
if "%terminp%"=="config-delete" set selectedcommand=deleteconfig

::try plugin code
if exist "plugincommands.db" (
    if "%terminp%"=="config-delete" set selectedcommand=plugincommands
)
::runconfig
exit
:runcommandgggg
type %defloc%%selectedcommand%.db > temp.bat
timeout /t 3 /nobreak > NUL
call temp.bat
cd %defloc%lib
del temp.bat
cd ..