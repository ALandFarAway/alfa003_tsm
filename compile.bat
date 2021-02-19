set HOMEDIR="%userprofile%\Documents\Neverwinter Nights 2"
set NWN2DIR="C:\Program Files (x86)\GOG Galaxy\Games\NWN2 Complete"

call set PARENT_DIR=%CD%
set PARENT_DIR=%PARENT_DIR:\= %
set LAST_WORD=
for %%i in (%PARENT_DIR%) do set LAST_WORD=%%i
set MODULE=%LAST_WORD%

del .\*.ncs
del .\*.ndb

NWNScriptCompiler.exe -e -v1.70 -o -h %HOMEDIR% -m %MODULE% -n %NWN2DIR% .\*.nss -y
