#!/bin/bash
# Build a single chapter
echo "Kniting ${i}"
back=`pwd`
cd source/${1}/_R
#echo `pwd`
Rscript --vanilla run.R
# No Rout is made with this method right now
#tail run.Rout
cd ${back}
#echo `pwd`
echo "Done knitting ${i}"
