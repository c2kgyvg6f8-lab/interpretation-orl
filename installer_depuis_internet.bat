@echo off
rem Installe Interpretation ORL directement depuis GitHub (ce fichier seul suffit).
set D=%TEMP%\InterpretationORL_install
if not exist "%D%" mkdir "%D%"
powershell -NoProfile -ExecutionPolicy Bypass -Command "[Net.ServicePointManager]::SecurityProtocol='Tls12'; $b='https://raw.githubusercontent.com/c2kgyvg6f8-lab/interpretation-orl/main'; foreach($f in 'Interpretation_ORL.html','interpretation_orl.ico','lancer.ps1','version.txt','install.ps1'){ Invoke-WebRequest \"$b/$f\" -UseBasicParsing -OutFile \"%D%\$f\" }; & \"%D%\install.ps1\""
pause
