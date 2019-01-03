

unlink("build")
shell("make html")

ff <- list.files("build/html", patt='\\.html$', recursive=TRUE, full=TRUE)
for (f in ff) {
	d <- readLines(f, warn=FALSE)
	d <- trimws(d)
	d <- d[d != ""]
	writeLines(d, f)	
}

ff <- grep("/sdm/", ff, value=TRUE)
for (f in ff) {
	d <- readLines(f, warn=FALSE)
	i <- grep("<head>",d) 	
	d <- c(d[1:i], 
	'<script async src="//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script><script>(adsbygoogle = window.adsbygoogle || []).push({google_ad_client: "ca-pub-8587731620693273", enable_page_level_ads: true});</script>',
	d[(i+1):length(d)])
	writeLines(d, f)
}

	

	cat("copying source and pdf\n\n")
	f <- list.files("source", patt='\\.rst\\.txt$', recursive=TRUE, full=TRUE)
	f <- grep("/txt/", f, value=TRUE)
	g <- gsub("txt/", "", f)
	g <- gsub("source/", "", g)
	h <- file.path("build/html/_sources", g)
	x <- file.remove(h)
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


