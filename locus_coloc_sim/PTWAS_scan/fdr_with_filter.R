d = read.table("PTWAS_scan/PTWAS_scan_LCP.rst", head=T)
library(qvalue)
rst = qvalue(d$TWAS_pval, fdr.level=0.05)

rej = d$gene[which(rst$sig)]

lc_set = d$gene[d$LCP>=0.5]

rej = intersect(rej, lc_set)


index = as.numeric(sapply(rej, function(x) substr(x,2,nchar(x))))

fdr = (length(which(index<=2500))+ length(which(index>5000)))/length(index)

tp = length(which(index>2500&index<=5000))

cat("Total rejection: ",length(index), " FDR: ", fdr, "  Power: ", tp,"/2500 (",tp/2500,") \n",sep="")


