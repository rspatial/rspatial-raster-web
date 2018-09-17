# README #

## What is this repository for? ##

* The is a the master repository for http://rspatial.org and it's sub-chapters.
* Chapters are each their own sub folders.

### Contributing ###

We are still working on the exact contributor agreement and final license. See [ticket #6](https://bitbucket.org/hijmans-lab/rspatial-web/issues/6/create-contributor-agreement)
It will be an open and free license and we'll accept large contributions via Copyright Assignment for larger contributions.

### How do I get set up? ###

You only need to clone the code if you plan to modify it.

#### Clone everything ####

```
git clone https://bitbucket.org/hijmans-lab/rspatial-web.git
```

#### Dependencies ####

* R
* Various R packages (see [requirements.R](requirements.R))
* Sphinx
* Maxent (installed into dismo package java folder)
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
