library(qvalue)

check_trait<-function(trait_id){

    d= read.table(paste0("comparison/",trait_id,".PTWAS_vs_enloc.cmp.rst"),head=T)

    twas_pval = d$TWAS_pval
    twas_pval[twas_pval==0] = 1e-300
    nlog10p = -log10(twas_pval)
    lcp = d$LCP
    tissue = d$tissue

    cor_test<-function(tissue_id){

        rst = cor.test(nlog10p[tissue==tissue_id], lcp[tissue==tissue_id],method="spearman")

        pval = twas_pval[tissue==tissue_id]

        qrst = qvalue(pval, fdr.level=0.05)
        
        sig_twas = which(qrst$sig)
        sig_coloc=which(lcp[tissue==tissue_id]>=0.50)

        sig_both = intersect(sig_twas,sig_coloc)


        pdf(file=paste0("comparison/figures_TWAS_vs_lcp/",trait_id,".",tissue_id,"TWAS_vs_lcp.pdf"), width= 6, height=6,bg="white")
        plot(nlog10p[tissue==tissue_id] ~ lcp[tissue==tissue_id], xlab = "LCP", ylab = "-log10 TWAS p-value", main = paste(trait_id, " ", tissue_id))
        dev.off()
        return(c(tissue_id, rst$est, rst$p.value, length(sig_twas), length(sig_coloc), length(sig_both)))
    }

    all_tissues = unique(tissue)


    return(t(sapply(all_tissues, function(x) cor_test(x))))
}


HDL_rst = check_trait("HDL")
LDL_rst = check_trait("LDL")
Height_rst = check_trait("Heights")
CAD_rst = check_trait("CAD")

HDL_rst = cbind(rep("HDL",dim(HDL_rst)[1]),HDL_rst)
LDL_rst = cbind(rep("LDL",dim(LDL_rst)[1]),LDL_rst)
Height_rst = cbind(rep("Height",dim(Height_rst)[1]),Height_rst)
CAD_rst = cbind(rep("CAD",dim(CAD_rst)[1]),CAD_rst)


out = rbind(CAD_rst, HDL_rst, LDL_rst, Height_rst)

write(file="comparison/TWAS_vs_LCP.summary", t(out), ncol=7)



