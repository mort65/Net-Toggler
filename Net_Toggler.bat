@ECHO OFF
REM BFCPEOPTIONSTART
REM Advanced BAT to EXE Converter www.BatToExeConverter.com
REM BFCPEEXE=Net_Toggler.exe
REM BFCPEICON=D:\Software\Programming\BAT\Net_Toggler.ico
REM BFCPEICONINDEX=-1
REM BFCPEEMBEDDISPLAY=0
REM BFCPEEMBEDDELETE=1
REM BFCPEADMINEXE=1
REM BFCPEINVISEXE=1
REM BFCPEVERINCLUDE=1
REM BFCPEVERVERSION=1.0.0.0
REM BFCPEVERPRODUCT=Net Toggler
REM BFCPEVERDESC=Net Toggler
REM BFCPEVERCOMPANY=
REM BFCPEVERCOPYRIGHT=https://github.com/mort65
REM BFCPEOPTIONEND
@ECHO ON
@echo off
rem This script toggle a network adaptor on specefied times

title "Net Toggler"


rem running the script as admin
rem >nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
rem IF '%errorlevel%' NEQ '0' (
rem goto UACPrompt
rem ) ELSE ( goto gotAdmin )
rem :UACPrompt
rem echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
rem echo UAC.ShellExecute "%~s0", "", "", "runas", 1 >> "%temp%\getadmin.vbs"
rem "%temp%\getadmin.vbs"
rem exit /B
rem :gotAdmin
rem IF exist "%temp%\getadmin.vbs" ( del "%temp%\getadmin.vbs" )

rem hiding program window
rem nircmd.exe win hide ititle "Net Toggler"


setlocal EnableExtensions EnableDelayedExpansion

rem variables:
rem net = Name of the network adaptor.
rem onTime = When network should be turned on.
rem offTime = When network should be turned off.
rem time should be in 24 hour format: "%H:%M:%S.%2N"

set net="Wi-Fi 2"
set "onTime=11:00:00.0"
set "offTime=01:00:00.0"

rem infinite loop
for /L %%n in (1,0,10) do (
	set "currentTime=!Time: =0!"
	rem echo !currentTime!
	IF not defined last_task (
		IF %offTime% lss %onTime% (
			IF !currentTime! geq %offTime% (
				IF !currentTime! lss %onTime% (
					netsh interface set interface %net% disable
					set "last_task=disable"
					echo !currentTime! %net% !last_task!d
				) ELSE (
					netsh interface set interface %net% enable
					set "last_task=enable"
					echo !currentTime! %net% !last_task!d
				)
			) ELSE (
				netsh interface set interface %net% enable
				set "last_task=enable"
				echo !currentTime! %net% !last_task!d
			)
		)
		IF %offTime% gtr %onTime% (
			IF !currentTime! geq %onTime% (
				IF !currentTime! lss %offTime% (
					netsh interface set interface %net% enable
					set "last_task=enable"
					echo !currentTime! %net% !last_task!d
				) ELSE (
					netsh interface set interface %net% disable
					set "last_task=disable"
					echo !currentTime! %net% !last_task!d
				)
			) ELSE (
				netsh interface set interface %net% disable
				set "last_task=disable"
				echo !currentTime! %net% !last_task!d
			)
		)
	)
	
	IF !last_task!==disable (
		IF %offTime% lss %onTime% (
			IF !currentTime! lss %offTime% (
				netsh interface set interface %net% enable
				set "last_task=enable"
				echo !currentTime! %net% !last_task!d
			)
			IF !currentTime! gtr %onTime% (
				netsh interface set interface %net% enable
				set "last_task=enable"
				echo !currentTime! %net% !last_task!d
			) 
		)
		IF %offTime% gtr %onTime% (
			IF !currentTime! gtr %onTime% (
				IF !currentTime! lss %offTime% (
					netsh interface set interface %net% enable
					set "last_task=enable"
					echo !currentTime! %net% !last_task!d
				)
			)
		)
	)
  
	IF !last_task!==enable (
		IF %offTime% lss %onTime% (
			IF !currentTime! geq %offTime% ( 
				IF !currentTime! lss %onTime% (
					netsh interface set interface %net% disable
					set "last_task=disable" 
					echo !currentTime! %net% !last_task!d
				)
			)
		)
		IF %offTime% gtr %onTime% (
			IF !currentTime! lss %onTime% (
				netsh interface set interface %net% disable
				set "last_task=disable"
				echo !currentTime! %net% !last_task!d
			)
			IF !currentTime! gtr %offTime% (
				netsh interface set interface %net% disable
				set "last_task=disable"
				echo !currentTime! %net% !last_task!d
			) 
		)
	)
	timeout /t 5 /nobreak > NUL
	rem call :stop
)

:stop
call :__stop 2>nul

:__stop
() creates a syntax error, quits the batch

pause