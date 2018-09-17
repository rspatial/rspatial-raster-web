@ECHO OFF

call make latex
cd _build/latex
pdflatex spatialmanual.tex
xcopy *.pdf  ..\html\_sources\rst\*.pdf /Y /Q
cd ../..


:end
