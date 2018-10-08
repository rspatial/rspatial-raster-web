
fun <- function(x) {
	d <- readLines(x)
	i = grep('^library\\(', d)
	d[i]
}
f = list.files("source", patt='\\.rmd$', recursive=T, full=T)
libs <- unique(unlist(sapply(f, fun)))
libs <- libs[nchar(libs) < 100]
libs <- gsub("library\\(", "", libs)
libs <- trimws(gsub(")", "", libs))
libs <- sort(unique(c(libs, c("animation", "deldir","dismo","fields","formatR","geosphere","gstat","jsonlite","kernlab","knitr","kmncluster", "latticeExtra","maptools","RandomFields","randomForest", "rasterVis","rgdal","rgeos","rgl", "rJava", "rpart","spatstat","spdep","spgwr", "XML", "sf"))))

paste0("install.packages(c('", paste(libs, collapse = "', '"), "'))")


install.packages(c('animation', 'deldir', 'dismo', 'fields', 'formatR', 'geosphere', 'gstat', 'jsonlite', 'kernlab', 'kmncluster', 'knitr', 'latticeExtra', 'magrittr', 'maptools', 'RandomFields', 'randomForest', 'raster', 'rasterVis', 'rgdal', 'rgeos', 'rgl', 'rJava', 'rpart', 'sf', 'sp', 'spatstat', 'spdep', 'spgwr', 'XML'))

