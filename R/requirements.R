
libfun <- function(x) {
	d <- readLines(x)
	i <- grep('^library\\(', d)
	j <- grep('^require\\(', d)
	d[unique(c(i,j))]
}

f <- list.files("source", patt='\\.rmd$', recursive=TRUE, full=TRUE, ignore.case=TRUE)
pkgs <- unique(unlist(sapply(f, libfun)))
pkgs <- pkgs[nchar(pkgs) < 100]
pkgs <- gsub("library\\(", "", pkgs)
pkgs <- trimws(gsub(")", "", pkgs))
pkgs <- sort(unique(c(pkgs, c("devtools", "animation", "deldir","dismo","fields","formatR","geosphere","gstat","jsonlite","kernlab","knitr", "latticeExtra","maptools","randomForest", "rasterVis","rgdal","rgeos","rgl", "rJava", "rpart","spatstat","spdep","spgwr", "XML", "sf"))))
pkgs <- pkgs[!(pkgs=='rspatial')]

ipkgs <- rownames(installed.packages())
for (pk in pkgs) {
  if (!(pk %in% ipkgs)) {
	print(paste("installing", pk))
    install.packages(pkgs=pk, repos="https://cran.cnr.berkeley.edu/", quiet=TRUE)
    library(pk, character.only=TRUE)
  }
}

if (!("rspatial" %in% ipkgs)) {
	devtools::install_github('rspatial/rspatial')
}




