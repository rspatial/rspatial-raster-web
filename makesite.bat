@ECHO OFF

Rscript.exe --vanilla _script\requirements.R
Rscript.exe --vanilla _script\knit_site.R all clean
Rscript.exe --vanilla _script\build_site.R clean

