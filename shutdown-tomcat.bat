@ECHO OFF
REM Find the PID associated with port 8080
FOR /F "tokens=5" %%a IN ('netstat -aon ^| findstr ":8080"') DO SET killpid=%%a

REM Check if we found a PID
IF "%killpid%"=="" (
    ECHO No process found on port 8080. Bye bye!!
    GOTO End
)

REM Display the found PID and kill the process
ECHO Found PID: %killpid%
ECHO Killing the process with PID %killpid%...
taskkill /F /PID %killpid%

:End
pause