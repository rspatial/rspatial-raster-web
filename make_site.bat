
call make html

del _build\html\_sources\rosu\rst\*.txt
xcopy source\rosu\rst\Rcode\*.R       _build\html\_sources\rosu\rst\*.txt /Y /Q
xcopy source\rosu\_build\latex\*.pdf  _build\html\_sources\rosu\rst\*.pdf /Y /Q
rem xcopy source\rosu\rst\data\*.*  _build\html\rosu\data\*.* /Y /Q

del _build\html\_sources\intr\rst\*.txt
xcopy source\intr\rst\Rcode\*.R       _build\html\_sources\intr\rst\*.txt /Y /Q
xcopy source\intr\_build\latex\*.pdf  _build\html\_sources\intr\rst\*.pdf /Y /Q
rem xcopy source\intr\rst\data\*.*  _build\html\intr\data\*.* /Y /Q

del _build\html\_sources\spatial\rst\*.txt
xcopy source\spatial\rst\Rcode\*.R  _build\html\_sources\spatial\rst\*.txt /Y /Q
xcopy source\spatial\_build\latex\*.pdf  _build\html\_sources\spatial\rst\*.pdf /Y /Q
rem xcopy source\spatial\rst\data\*.*  _build\html\spatial\data\*.* /Y /Q

del _build\html\_sources\analysis\rst\*.txt
xcopy source\analysis\rst\Rcode\*.R  _build\html\_sources\analysis\rst\*.txt /Y /Q
xcopy source\analysis\_build\latex\*.pdf  _build\html\_sources\analysis\rst\*.pdf /Y /Q
rem  xcopy source\analysis\rst\data\*.*  _build\html\analysis\data\*.* /Y /Q

del _build\html\_sources\cases\rst\*.txt
xcopy source\cases\rst\Rcode\*.R  _build\html\_sources\cases\rst\*.txt /Y /Q
xcopy source\cases\_build\latex\*.pdf  _build\html\_sources\cases\rst\*.pdf /Y /Q
rem xcopy source\cases\rst\data\*.*  _build\html\cases\data\*.* /Y /Q

del _build\html\_sources\sdm\rst\*.txt
xcopy source\sdm\rst\Rcode\*.R  _build\html\_sources\sdm\rst\*.txt /Y /Q
xcopy source\sdm\_build\latex\*.pdf  _build\html\_sources\sdm\rst\*.pdf /Y /Q
rem xcopy source\sdm\rst\data\*.*  _build\html\sdm\data\*.* /Y /Q

del _build\html\_sources\sphere\rst\*.txt
xcopy source\sphere\rst\Rcode\*.R  _build\html\_sources\sphere\rst\*.txt /Y /Q
xcopy source\sphere\_build\latex\*.pdf  _build\html\_sources\sphere\rst\*.pdf /Y /Q
rem xcopy source\sphere\rst\data\*.*  _build\html\sphere\data\*.* /Y /Q

del _build\html\_sources\rs\rst\*.txt
xcopy source\rs\rst\Rcode\*.R  _build\html\_sources\rs\rst\*.txt /Y /Q
xcopy source\rs\_build\latex\*.pdf  _build\html\_sources\rs\rst\*.pdf /Y /Q
rem xcopy source\rs\rst\data\*.*  _build\html\rs\data\*.* /Y /Q

del _build\html\_sources\manual\rst\*.txt
xcopy source\manual\rst\Rcode\*.R  _build\html\_sources\manual\rst\*.txt /Y /Q
xcopy source\manual\_build\latex\*.pdf  _build\html\_sources\manual\rst\*.pdf /Y /Q
rem xcopy source\manual\rst\data\*.*  _build\html\manual\data\*.* /Y /Q

R CMD BATCH --no-save --no-restore cropRcode.R
