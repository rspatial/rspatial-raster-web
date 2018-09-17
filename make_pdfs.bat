@ECHO ON

md _build\html\data\

cd source\rosu
call makepdf.bat

cd ..\intr
call makepdf.bat

cd ..\spatial
call makepdf.bat

cd ..\analysis
call makepdf.bat

cd ..\cases
call makepdf.bat

cd ..\sdm
call makepdf.bat

cd ..\sphere
call makepdf.bat

cd ..\rs
call makepdf.bat

cd ..\manual
call makepdf.bat

cd ..\..
