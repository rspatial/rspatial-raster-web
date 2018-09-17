#!/bin/bash
#TODO convert this to R or python so it's cross platform
sections=("intr" "cases" "sdm" "analysis" "spatial" "sphere", "rs")


datadir=build/html/${i}/data
mkdir $datadir
echo "cp source/data/* ${datadir}/"
cp source/data/* ${datadir}/

echo "Copying data is done"
