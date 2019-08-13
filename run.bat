@ECHO OFF

rem example usage:
rem run knit intr 
rem run build intr 
rem run build intr pdf 
rem run knit all 
rem run build all 

set arg1=%1
set arg2=%2
set arg3=%3

if %arg2% == all (
	for %%i in (rosu intr spatial analysis cases sdm sphere rs, spatial-terra, rs-terra) do Rscript.exe --vanilla R\run.R %arg1% %%i %arg3%
) else (
	Rscript.exe --vanilla R\run.R %arg1% %arg2% %arg3%
)

:end
