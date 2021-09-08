@ECHO OFF
PowerShell -Command "Set-ExecutionPolicy Unrestricted" >> "%TEMP%\StartupLog.txt" 2>&1
PowerShell C:\temp\installmissive.ps1 >> "%TEMP%\StartupLog.txt" 2>&1
EXIT
