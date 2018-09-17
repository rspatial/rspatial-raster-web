
x <- tail(readLines('run.Rout'), 2)
x <- paste0(paste0(x, collapse='\n'),'\n')

f <- file('tail.txt', "w") 
cat(x, file=f)
close(f)


