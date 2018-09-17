
f <- list.files("source", patt='\\.R$', recursive=T, full=T)
f <- grep("/rst/rcode/", f, value=T)
g <- gsub("rcode/", "", f)
g <- gsub("source/", "", g)
g <- gsub(".R$", ".rst.txt", g)
h <- file.path("_build/html/_sources", g)
file.remove(h)
file.copy(f, h)
