@ECHO OFF
cd _R
R CMD BATCH --no-save --no-restore run.R
R CMD BATCH --no-save --no-restore tail.R
type tail.txt
del tail.txt
del tail.Rout
cd ..
REM echo knitting is done

:end
