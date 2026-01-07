args = commandArgs(trailingOnly=TRUE)
seed.arg = as.numeric(args[1])

# for dummy running
if(is.na(seed.arg)==TRUE){seed.arg=1}

seed.grid = expand.grid(cause=causes_included,exposure=exposures_included)

chosen.row = seed.grid[seed.arg,]
cause = as.character(chosen.row[1,1])
exposure = as.character(chosen.row[1,2])
