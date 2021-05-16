@ECHO OFF

rem example usage:
rem knit 
rem knit rs
rem knit rs clean
rem knit all clean 

Rscript.exe --vanilla _script\knit_site.R %1 %2

:end

