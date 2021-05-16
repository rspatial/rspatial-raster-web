@ECHO OFF

Rscript.exe --vanilla _script\build_site.R %1

rem Rscript.exe --vanilla _script\check_errors.R 	

:end

