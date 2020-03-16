#plot f3 results
install.packages("Hmisc")
library(Hmisc)

f3dat = read.table("~/all.qp3Pop.txt", sep="", col.names=c("PopA", "PopB", "PopC", "F3", "StdErr", "Z", "SNPs"))

sOrdered = f3dat[order(-f3dat$F3),]

errbar(1:40, sOrdered$F3[1:40],
       (sOrdered$F3+sOrdered$StdErr)[1:40],
       (sOrdered$F3-sOrdered$StdErr)[1:40], pch=20, las=2, cex.axis=0.4, xaxt='n',
       xlab="population", ylab="F3")
axis(1, at=1:40, labels=sOrdered$PopB[1:40], las=2, cex.axis=0.6)
