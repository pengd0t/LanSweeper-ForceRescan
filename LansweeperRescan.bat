@echo off
SETLOCAL
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:: This must be run as Administrator

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

:: Forces a LanSweeper update to make sure info is right
echo Forcing Lansweeper update...
net stop "Lansweeper Agent Service"
::Waiting between start and stop commands
ping -n 5 127.0.0.0 > nul
del "c:\program files (x86)\lansweeperagent\lsagent.ini"
net start "Lansweeper Agent Service"
ping -n 5 127.0.0.0 > nul

PAUSE