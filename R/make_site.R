
args <- commandArgs(TRUE)
if (length(args) > 0) {
	cmd <- args[1]
	if (cmd == "remove") {
		unlink("build", recursive=TRUE)
	}
}

shell("make html")

fff <- list.files("build/html", patt='\\.html$', recursive=TRUE, full=TRUE)
for (f in fff) {
	d <- readLines(f, warn=FALSE)
	dd <- trimws(d)
	d <- d[dd != ""]
	if (basename(f) != "index.html") {
		d <- gsub("\\.rst\\.txt", ".R.txt", d)
	}
	writeLines(d, f)	
}



replaceTxt <- function(ff, txt, addtxt=FALSE) {
	for (f in ff) {
		d <- readLines(f, warn=FALSE)
		i <- grep(txt, d) 
		if (length(i) == 0) next
		#d <- d[-(i:(i+3))]
		d[i] <- '<script async src="//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>'
		d[i+1] <- '<!-- Leaderboard --><ins class="adsbygoogle" style="display:inline-block;width:728px;height:90px" data-ad-client="ca-pub-8587731620693273" data-ad-slot="8302978504"></ins>'
		d[i+2] <- '<script>(adsbygoogle = window.adsbygoogle || []).push({});'
		d[i+3] <- '</script>'	
		
		if (addtxt) {
			i <- grep("<head>",d) 	
			txtadd <- '<script async src="//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script><script>(adsbygoogle = window.adsbygoogle || []).push({google_ad_client: "ca-pub-8587731620693273", enable_page_level_ads: true});</script>'
			d <- c(d[1:i], txtadd, d[(i+1):length(d)])
			writeLines(d, f)
		}
		
		writeLines(d, f)	
	}
}



txt1 <- '<a href="http://www.feedthefuture.gov/"><img class="logos" alt="Feed the Future" src="../_static/img/t-feed-the-future.png" /></a>'

ff <- grep("/rosu/", fff, value=TRUE)
replaceTxt(ff, txt1)

ff <- grep("/raster/", fff, value=TRUE)
replaceTxt(ff, txt1)

ff <- grep("/sdm/", fff, value=TRUE)
replaceTxt(ff, txt1, TRUE)

ff <- grep("/sphere/", fff, value=TRUE)
replaceTxt(ff, txt1)


#f <- "index.html"
#d <- readLines(f, warn=FALSE)
#i <- grep(txt, d) 
#if (length(i) > 0) {
#	d[i] <- ""
#	writeLines(d, f)	
#}


cat("copying source and pdf\n\n")
f <- list.files("source", patt='\\.md\\.txt$', recursive=TRUE, full=TRUE)
f <- grep("/txt/", f, value=TRUE)
g <- gsub("txt/", "", f)
g <- gsub("source/", "", g)
h <- file.path("build/html/_sources", g)
h <- gsub("\\.md\\.txt", ".R.txt", h)
#x <- file.remove(h)
y <- file.copy(f, h, overwrite=TRUE)
stopifnot(all(y))

# copy pdf manuals
f <- list.files("source", patt='.pdf$', recursive=TRUE, full=TRUE)
if(length(f) < 8) {warning("pdf files missing")}
g <- gsub("/_build/latex", "", f)
g <- gsub("source/", "", g)
h <- file.path("build/html", g)
y <- file.copy(f, h, overwrite=TRUE)
stopifnot(all(y))


