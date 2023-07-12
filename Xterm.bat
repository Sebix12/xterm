::@echo off
::prepare
set defloc=%~dp0
if exist "config.bat" (
   call config.bat
   echo loaded config!
)
if not exist "server" (
   mkdir server
   echo server.F Created!
)
if not exist "lib" (
   mkdir lib
   echo lib.F Created!
)
if not exist "svcbin" (
   mkdir svcbin
   echo svcbin.F Created!
)
if exist "plugins" (
   if exist "svcbin" goto :cpluginfile
) else (
   mkdir plugins
   goto :installlibraries
)
:contcodemainterm
goto :skplug
exit

:cpluginfile
cd %defloc%
cd 
echo cd %defloc%> %defloc%svcbin\plgload.bat
echo cd plugins>> %defloc%svcbin\plgload.bat
dir /b /l  *.bat>> %defloc%svcbin\plgload.bat
echo cd "%defloc%">> %defloc%svcbin\plgload.bat 

:skplug
goto :terminal

:terminal
set /p terminp=">"
goto :cmdcheck

:cmdcheck
cd %defloc%
call terminal_svc.bat %terminp% "%defloc%"
echo.
goto :terminal

:installlibraries
cd lib
start /wait powershell -Command "(New-Object Net.WebClient).DownloadFile('https://github.com/Sebix12/MCTerm-V2/raw/main/lib.zip', 'lib.zip')"
tar -xf lib.zip
timeout /t 5 /nobreak > NUL
del lib.zip
cd ..
goto :contcodemainterm
