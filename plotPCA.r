#usage
#plotPCA.r TGP_panel.txt  eigenfile.eigenvec  eigenfile.eigenval

library(ggplot2)
library(ggExtra)
library(tidyverse)
library(ggrepel)
args = commandArgs(trailingOnly=TRUE)

Pop_Table = read.delim(file=args[1], header = TRUE, stringsAsFactors = F, sep = "\t")
eigenfile = read.delim(file=args[2], header = FALSE, stringsAsFactors = F, sep = " ")
eigVal = read.delim(file=args[3], header = FALSE, stringsAsFactors = F, sep = " ")

eigenfile_f = data.frame("Sample" = eigenfile$V1, "PC1" = eigenfile$V3, "PC2" = eigenfile$V4 )
eigen_merged = merge(Pop_Table, eigenfile_f, by = "Sample" , all = FALSE)
PC1= round(eigVal[1,1]/sum(eigVal$V1)*100) 
PC2=round(eigVal[2,1]/sum(eigVal$V1)*100)
x_axis = paste("PC1 ", "(%",PC1," explained variance)", sep="")
y_axis = paste("PC2 ","(%",PC2, " explained variance)", sep="")

g <- ggplot(data = eigen_merged) + 
    geom_point(aes(PC1,PC2,color= Region), alpha = 0.5) +
    labs(x=x_axis, y = y_axis, color="Populations") +
    theme(text = element_text(size=10), axis.text.x = element_text( size=7, angle=45)) 
g
png("~/Desktop/TGPpaperfiles/PCAplot.png", width = 12, height = 12, units = 'in', res = 300)
print(g)
dev.off()

