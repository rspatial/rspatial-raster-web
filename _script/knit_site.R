#!/usr/bin/Rscript

do_knit <- function(option, quiet=TRUE) {

	ff <- list.files("_R", pattern='.Rmd$', ignore.case=TRUE, full.names=TRUE, recursive=TRUE)
	kf <- list.files(".", pattern='\\.rst$', recursive=TRUE)
	kf <- kf[-grep("index.rst", kf, ignore.case=TRUE)]


	dir.create('figures/', showWarnings=FALSE)
	dir.create('txt/', showWarnings=FALSE)
	u <- unique(gsub("_R", "", dirname(ff)))
	u <- u[u!=""]
	u <- gsub("^/", "", u)
	for (d in u) {
		dir.create(d, showWarnings=FALSE, TRUE)
		dir.create(file.path(d, 'figures'), showWarnings=FALSE)
		dir.create(file.path(d, 'txt'), showWarnings=FALSE)
	}
	
	if (option=="clean"){
		file.remove(kf)
		file.remove(list.files("txt", full=TRUE))
		file.remove(list.files("figures", full=TRUE))
	} else { 
		if (length(kf) > 0 ) {
			stime <- file.info(ff)
			fn <- gsub("_R/", "./", raster::extension((rownames(stime)), ""))
			stime <- data.frame(f=fn, stime = stime$mtime, stringsAsFactors=FALSE)

			btime <- file.info(kf)
			fn <- paste0("./", raster::extension((rownames(btime)), ""))
			btime <- data.frame(f=fn, btime = btime$mtime, stringsAsFactors=FALSE)

			m <- merge(stime, btime, by=1, all.x=TRUE)
			m[is.na(m$btime), 'btime'] <- as.POSIXct(as.Date('2000-01-01'))

			i <- which ( m$btime < m$stime ) 
			ff <- ff[i]
		}
	}
	if (length(ff) > 0) {
		##library(knitr)
		loadNamespace("knitr")

		outf <- gsub("_R/", "", ff)
		md <-  gsub(".rmd$", '.md', outf)
		rst <-  gsub(".rmd$", ".rst", outf)
		txtp <- file.path(dirname(outf), "txt", basename(outf))
		rcd <- gsub(".rmd$", ".txt", txtp)
		
		knitr::opts_chunk$set(
			dev        = 'png',
			fig.width  = 6,	fig.height = 6,
			fig.path = 'figures/',
			fig.cap="",
			collapse   = TRUE
		)
		#opts_chunk$set(tidy.opts=list(width.cutoff=60))

		
		for (i in 1:length(ff)) {
		
			dn <- dirname(rst[i])
			if (dn != ".") {
				knitr::opts_chunk$set(
					fig.path = paste0(dn, '/figures/')
				)
				fdirclean <- TRUE
			} else {
				fdirclean <- FALSE
			}
			cat(paste("   ", tools::file_path_sans_ext(outf[i]), "\n"))
			knitr::knit(ff[i], md[i], envir = new.env(), encoding='UTF-8', quiet=quiet)
			knitr::purl(ff[i], rcd[i], quiet=TRUE)
			if (fdirclean) {
				x <- readLines(md[i])
				j <- grep("png", x)
				x[j] = gsub(paste0(dn, "/"), "", x[j])
				writeLines(x, md[i])
			}
			pc <- paste('pandoc',  md[i], '-f markdown -t rst -o', rst[i])
			sysfun(pc)
			file.remove(md[i])
		}
	} 
}


if (tolower(Sys.info()["sysname"])=="windows"){
	sysfun <- shell
} else {
	sysfun <- system		  
}
options("rgdal_show_exportToProj4_warnings"="none")

args <- commandArgs(TRUE)
ch <- grep("_R$", list.dirs(recursive=TRUE), value=TRUE)
chapters <- grep("/source/", ch, value=TRUE)
chapters <- gsub("\\./source/", "", gsub("/_R", "", ch))

if (length(args) < 1) {
	chapter = chapters
} else {
	chapter <- tolower(args[1])
	if (chapter == "all") {
		chapter <- chapters
	} else {
		stopifnot(chapter %in% chapters)
	}
}
print(chapter)

option <- ifelse(length(args) > 1, args[2], "")
oldpath <- getwd()

for (ch in chapter) {
	path <- file.path(oldpath, 'source', ch)
	setwd(path)
	cat(paste0("\n- ", basename(path), "\n"))
	do_knit(option, quiet=TRUE)
}
setwd(oldpath)
warnings()

