d = read.table("fastenloc/sim.enloc.gene.out", head=T)

attach(d)

run_fdr<-function(prob){

    lfdr = sort(1-prob)
    FDR = cumsum(lfdr)/1:length(lfdr)
    thresh = 1- lfdr[max(which(FDR<=0.05))]




    rej = gene[prob>=thresh]
    index = as.numeric(sapply(rej, function(x) substr(x,2,nchar(x))))


    fdr = (length(which(index<=2500))+ length(which(index>5000)))/length(index)
    fp = length(which(index<=2500))+ length(which(index>5000))
    tp = length(which(index>2500&index<=5000))

    cat("Total rejection: ",length(index), " FDR: ", fdr, "  ", fp, "  Power: ", tp,"/2500 (",tp/2500,") thresh = ", thresh,"\n",sep="")
    return(index)
}


cat("FDR control (5% level)\n")
cat("RCP:\n")
rcp_set = run_fdr(RCP)
cat("\nLCP:\n")
lcp_set = run_fdr(LCP)
cat("\nFindings in RCP but not in LCP:\n")
setdiff(rcp_set, lcp_set)


cat("\n\nThresholding at 0.50 probability\n")
cat("RCP:\n")
index = which(RCP>=0.50)
fdr = (length(which(index<=2500))+ length(which(index>5000)))/length(index)
tp = length(which(index>2500&index<=5000))
cat("Total rejection: ",length(index), " FDR: ", fdr, "  Power: ", tp,"/2500 (",tp/2500,") \n",sep="")

cat("\nLCP:\n")
index = which(LCP>=0.50)
fdr = (length(which(index<=2500))+ length(which(index>5000)))/length(index)
tp = length(which(index>2500&index<=5000))
cat("Total rejection: ",length(index), " FDR: ", fdr, "  Power: ", tp,"/2500 (",tp/2500,") \n",sep="")

