#!/bin/bash
#TODO convert this to R or python so it's cross platform
sections=("intr" "cases" "sdm" "analysis" "spatial" "sphere" "rosu" "manual" "rs")

# For each sub chapter knit
for i in "${sections[@]}"
do
  echo "Kniting ${i}"
  back=`pwd`
  cd source/${i}/_R
  #echo `pwd`
  Rscript --vanilla run.R
  # No Rout is made with this method right now
  #tail run.Rout
  cd ${back}
  #echo `pwd`
  echo "Done knitting ${i}"
done
echo "knitting is done"
