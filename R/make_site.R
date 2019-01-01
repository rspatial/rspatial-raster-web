
unlink("build")
shell("make html")

f <- list.files("source", patt='\\.md\\.txt$', recursive=TRUE, full=TRUE)
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
