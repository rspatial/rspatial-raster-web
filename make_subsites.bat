@ECHO ON

md _build\html\data\

ECHO rosu
cd source\rosu
call makesite.bat

ECHO intr
cd  ..\intr
call makesite.bat

ECHO spatial
cd ..\spatial
call makesite.bat

ECHO analysis
cd ..\analysis
call makesite.bat

ECHO cases
cd ..\cases
call makesite.bat

ECHO sdm
cd ..\sdm
call makesite.bat

ECHO sphere
cd ..\sphere
call makesite.bat

ECHO rs
cd ..\rs
call makesite.bat


ECHO manual
cd ..\manual
call makesite.bat

cd ..\..
