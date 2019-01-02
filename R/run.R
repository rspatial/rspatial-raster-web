#!/usr/bin/Rscript

if (tolower(Sys.info()["sysname"])=="windows"){
	sysfun <- shell
} else {
	sysfun <- system		  
}


args <- commandArgs(TRUE)

if (length(args) < 2) {
	print(args)
	stop("there must be at least two arguments")
}

cmd <- args[1]
stopifnot(cmd %in% c("knit", "build"))

chapters <- c("rosu", "intr", "spatial", "analysis", "cases", "sdm", "sphere", "rs")
chapter <- tolower(args[2])
if (chapter == "all") {
# this is problematic as there is a lot of function hiding 
	chapter <- chapters
} else {
	stopifnot(chapter %in% chapters)
}

option <- ifelse(length(args) > 2, args[3], "")

oldpath <- getwd()



do_build <- function(option) {
	if (option=="pdf"){
		x <- sysfun("make latexpdf", intern = TRUE)
		return()
	} else if (option=="clean"){
		unlink("_build", recursive=TRUE)
	} 
	sysfun("make html")
	ff1 <- list.files("txt", pattern="md\\.txt$", full=TRUE)
	ff2 <- paste0("_build/html/_sources/", basename(ff1))
	file.copy(ff1, ff2, overwrite=TRUE)
}

do_knit <- function(option) {

	ff <- list.files("_R", pattern='.Rmd$', ignore.case=TRUE, full.names=TRUE)
	rst <- list.files(".", pattern='\\.rst')
	rst <- rst[-grep("index.rst", rst)]
	if (option=="clean"){
		file.remove(rst)
		file.remove(list.files("txt", full=TRUE))
	} else { 
		if (length(rst) > 0 ) {
			stime <- file.info(ff)
			stime <- data.frame(f=raster::extension(basename(rownames(stime)), ""), stime = stime$mtime, stringsAsFactors=FALSE)

			btime <- file.info(rst)
			btime <- data.frame(f=raster::extension(basename(rownames(btime)), ""), btime = btime$mtime, stringsAsFactors=FALSE)

			m <- merge(stime, btime, by=1, all.x=TRUE)
			m[is.na(m$btime), 'btime'] <- as.POSIXct(as.Date('2000-01-01'))

			i <- which ( m$btime < m$stime ) 
			ff <- ff[i]
		}
	}
	if (length(ff) > 0) {
		library(knitr)
		dir.create('figures/', showWarnings=FALSE)
		dir.create('txt/', showWarnings=FALSE)
		md <-  raster::extension(basename(ff), '.md')
		rst <- raster::extension(basename(ff), '.rst')
		rcd <- file.path("txt", basename(gsub("md$", "md.txt", md)))
		
		opts_chunk$set(
			dev        = 'png',
			fig.path   = 'figures/',
			fig.width  = 6,	fig.height = 6,
			collapse   = TRUE
		)
		
		for (i in 1:length(ff)) {
			cat(paste("   ", raster::extension(basename(ff[i]), ""), "\n"))
			knit(ff[i], md[i], envir = new.env(), encoding='UTF-8', quiet=TRUE)
			purl(ff[i], rcd[i], quiet=TRUE)
			pc <- paste('pandoc',  md[i], '-f markdown -t rst -o', rst[i])
			sysfun(pc)
		}
	} 
	file.remove(md)
}



for (ch in chapter) {
	path <- file.path(oldpath, 'source', ch)
	setwd(path)
	cat(paste0("\n- ", basename(path), "\n"))
	if (cmd == "build") {
		do_build(option)
	} else {
		do_knit(option)
	}
}
setwd(oldpath)
warnings()

