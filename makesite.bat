@ECHO OFF

rem Rscript.exe --vanilla R\requirements.R
rem Rscript.exe --vanilla R\run.R knit all clean
rem Rscript.exe --vanilla R\run.R build all clean
rem Rscript.exe --vanilla R\run.R build all pdf
Rscript.exe --vanilla R\make_site.R 
Rscript.exe --vanilla R\check_errors.R 

