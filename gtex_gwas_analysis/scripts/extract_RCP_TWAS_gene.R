library(qvalue)

check_trait<-function(trait_id){

    d= read.table(paste0("comparison/",trait_id,".PTWAS_vs_enloc.cmp.rst"),head=T)

    twas_pval = d$TWAS_pval
    twas_pval[twas_pval==0] = 1e-300
    nlog10p = -log10(twas_pval)
    rcp = d$RCP
    tissue = d$tissue

    cor_test<-function(tissue_id){
        
        sub_d = d[tissue==tissue_id,]
        sub_pval = twas_pval[tissue==tissue_id]
        sub_rcp = rcp[tissue==tissue_id]
        qrst = qvalue(sub_pval, fdr.level=0.05)
        
        sig_twas = which(qrst$sig)
        sig_coloc=which(sub_rcp>=0.50)

        sig_both = intersect(sig_twas,sig_coloc)
        
        outd = cbind(rep(trait_id, length(sig_both)), sub_d[sig_both,])
        write(file="results/PTWAS_RCP_select_gene.dat", t(outd), ncol=6, append=T)

    }

    all_tissues = unique(tissue)


    return(t(sapply(all_tissues, function(x) cor_test(x))))
}


HDL_rst = check_trait("HDL")
LDL_rst = check_trait("LDL")
Height_rst = check_trait("Heights")
CAD_rst = check_trait("CAD")
