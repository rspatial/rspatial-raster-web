@ECHO OFF

cd _R
R CMD BATCH --no-save --no-restore run.R
R CMD BATCH --no-save --no-restore tail.R
type tail.txt
del tail.txt
del tail.Rout
cd ..

call make html
del _build\html\_sources\rst\*.txt
xcopy rst\Rcode\*.R  _build\html\_sources\rst\*.rst.txt /Y /Q

@ECHO ON
:end
