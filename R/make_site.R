
unlink("build")
shell("make html")

f <- list.files("source", patt='\\.md\\.txt$', recursive=TRUE, full=TRUE)
f <- grep("/txt/", f, value=TRUE)
g <- gsub("txt/", "", f)
g <- gsub("source/", "", g)
h <- file.path("build/html/_sources", g)
x <- file.remove(h)
y <- file.copy(f, h, overwrite=TRUE)


