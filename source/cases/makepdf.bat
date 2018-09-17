@ECHO OFF

call make latex
cd _build/latex
pdflatex cases.tex
xcopy *.pdf  ..\html\_sources\rst\*.pdf /Y /Q
cd ../..


:end
