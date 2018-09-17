# clean out the md and rst folders to force a clean build

dr <- list.dirs("source/",full.names = TRUE)
rmdr <- dr[grep("rst|md",dr)]
unlink(rmdr, recursive = TRUE)
