# README #

## What is this repository for? ##

* The is a the master repository for http://rspatial.org and it's sub-chapters.
* Chapters are each their own sub folders.

### Contributing ###

We are still working on the exact contributor agreement and final license.
It will be an open and free license and we'll accept large contributions via Copyright Assignment for larger contributions.

### How do I get set up? ###

#### Dependencies ####

* R
* Various R packages (see [requirements.R](requirements.R))
* Python
* The python package "sphinx"
* pandoc

#### Building ####

1. Knit all the submodules with R - This runs all the Rmd files and creates rst files.

```
knitall.sh
```

1. Build the static site with Sphinx

```
make html
```

### Who do I talk to? ###

* Robert Hijmans or Alex Mandel [biogeo@ucdavis.edu](mailto:biogeo.ucdavis.edu)
