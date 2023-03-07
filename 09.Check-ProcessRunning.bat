set WPROCESS=Notepad.exe

tasklist /fi "ImageName eq %WPROCESS%" /fo csv 2>NUL | findstr /I "%WPROCESS%">NUL

if "%ERRORLEVEL%"=="0" (
echo Process %WPROCESS% - Application is running
) else (
echo Process %WPROCESS% - Application is not running
)