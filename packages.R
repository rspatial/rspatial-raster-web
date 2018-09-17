#### Original Version ####
# TODO: remove this section in favor of the functions below
zz <- c()
ff <- list.files("e:/bitbucket/rweb/", pattern="rmd$", full=T, rec=T)
for (f in ff) {
	x <- readLines(f)
	y <- grep('library\\(', x)
	z <- x[y]
	z <- gsub('library\\(', '', z)
	z <- gsub(')', '', z)
	z <- gsub('`', '', z)
	zz <- c(zz, z)
}

library(raster)
zz <- trim(unique(zz))
zz <- zz[nchar(zz) < 50]
for (z in zz) {
	if (!require(z, character.only=TRUE)) {
		install.packages(z)
	}
}

#### Package Scanner ####
pkgscan <-function(scanpath="source/"){
  
  # Find all the packages used in a project
  toscan <- list.files(path=scanpath,pattern="*.R$|*.rmd$", recursive = TRUE, full.names = TRUE)
  
  scan <- sapply(toscan, function(file) {grep('library\\(|require\\(', readLines(file), value=TRUE)} )
  
  # https://stackoverflow.com/a/8613332/237354
  cleanscan <- sapply(scan, function(j) {
    regmatches(j, gregexpr("(?<=\\().*?(?=\\))", j, perl=T))
  })
  libs <- unique(unlist(cleanscan))
  libs <- unique(gsub('"',"",gsub("'| ","", libs)))
  libs <- sort(libs)
  return(libs)
}

#### Installation ####
pkginstall <- function(libs){
  # Given a list of packages, install if not already installed
  cpu <- (parallel::detectCores(logical=TRUE)-1)
  for (lib in libs) {
    if (!require(lib, character.only=TRUE)) {
      install.packages(lib, Ncpus = cpu)
    }
  }
}

pkglist <- function(libs){
  # Print code that could be used to install
  code <- paste0('install.packages(c("'
                 ,paste(libs,collapse='","')
                 ,'"))')
  return(code)
}

#### Requirements file handling ####
writeReq <- function(libs){
  writeLines(c(pkglist(libs),"# List of packages for easier import",libs),"requirements.R")
  # TODO: add package versions as a 2nd column
  return("requirements.R written")
}

readReq <- function(){
  #readLines("requirements.R")
  pkgs <- read.table("requirements.R", skip=2, stringsAsFactors = FALSE)
  return(pkgs[,1])
}