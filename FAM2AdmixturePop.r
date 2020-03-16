
#ind2popfile run this before pong analysis to generate population file
#panel.yxy file is a tab seperated file contains sample, super population and population
#FAM2AdmixturePop.r FAMfile.fam panel.txt output.txt
args = commandArgs(trailingOnly=TRUE)

indTable = read.table(args[1], header = FALSE, stringsAsFactors = F, sep = "")
all_pop <- read.delim(args[2], header = TRUE, stringsAsFactors = F, sep = "\t")
indviduals <- data.frame("Sample" = indTable$V1)
ind2pop =merge(indviduals, all_pop, by="Sample", all=FALSE, sort = F)

write.table(ind2pop$Population,file= args[3],quote = F, row.names = F, col.names = F )
