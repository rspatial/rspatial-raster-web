
ff <- list.files("build/html", patt='\\.html$', recursive=TRUE, full=TRUE)
for (f in ff) {
	x <- readLines(f, warn=FALSE)
	i <- grep("## Error", x)
	if (length(i) > 0) {
		print(f)
		print(head(x[i]))
		cat("----\n\n")
	}
}
