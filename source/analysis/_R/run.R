#!/usr/bin/Rscript

ff <- list.files(pattern='.rmd$')
rs <- list.files('../rst/', pattern='.rst')

if (length(rs) > 0 ) {
	stime <- file.info(ff)
	stime <- data.frame(f=gsub('.rmd', '', ff), stime = stime$mtime)
	btime <- file.info(paste0('../rst/', rs))
	btime <- data.frame(f=gsub('.rst', '', rs), btime = btime$mtime)

	m <- merge(stime, btime, by=1, all.x=TRUE)
	m[is.na(m$btime), 'btime'] <- as.POSIXct(as.Date('2000-01-01'))

	i <- which ( m$btime < m$stime ) 
	ff <- ff[i]
}

if (length(ff) > 0) { 
	library(knitr)

	opts_chunk$set(
		dev        = 'png',
		fig.path   = "figures/",
		fig.width  = 6,
		fig.height = 6,
####		fig.align  = "center",
		collapse   = TRUE
		#strip.white = FALSE
	)

	dir.create('md', showWarnings=FALSE)
	dir.create('../rst/figures', recursive=TRUE, showWarnings=FALSE)
	dir.create('../rst/rcode', recursive=TRUE, showWarnings=FALSE)

	md <- paste0('./md/', gsub('.rmd', '.md', ff))
	rs <- paste0('../rst/', gsub('.rmd', '.rst', ff))
	for (i in 1:length(ff)) {
		purl(ff[i], paste0('../rst/rcode/', gsub('.rmd', '.R', ff[i])))
		knit(ff[i], md[i], envir = new.env())
		pc <- paste('pandoc',  md[i], '-f markdown -t rst -o', rs[i])
		if (tolower(Sys.info()["sysname"])=="windows"){
		  shell(pc)
		} else {
		  system(pc)		  
		}
	}
	figs <- list.files('figures')
	file.copy(paste0('figures/', figs), paste0(paste0('../rst/figures/', figs)), overwrite=TRUE)
} 


