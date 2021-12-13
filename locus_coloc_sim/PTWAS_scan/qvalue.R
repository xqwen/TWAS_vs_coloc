d = read.table("PTWAS_scan/PTWAS_scan.rst", head=T)
library(qvalue)
rst = qvalue(d$pvalue, fdr.level=0.05)

rej = d$gene[which(rst$sig)]
index = as.numeric(sapply(rej, function(x) substr(x,2,nchar(x))))

thresh = max(d$pvalue[index])

fdr = (length(which(index<=2500))+ length(which(index>5000)))/length(index)
fp_index = index[which(index<=2500 | index>5000)]
tp = length(which(index>2500&index<=5000))
fp = length(fp_index)
fp_name = paste0("g",fp_index)
outd = cbind(d$pvalue[fp_index], fp_name, rst$qvalue[fp_index])
cat("Total rejection: ",length(index), " FDR: ", fdr,"  ",fp, "  Power: ", tp,"/2500 (",tp/2500,") ","thresh = ", thresh,"\n",sep="")
write(file="PTWAS_FP/twas_fp.list", t(outd), ncol=3)

