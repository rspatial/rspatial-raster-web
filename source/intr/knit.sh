#!/bin/bash
cd _R
Rscript --vanilla run.R ${1}
#tail _R/run.Rout
echo "knitting is done"
