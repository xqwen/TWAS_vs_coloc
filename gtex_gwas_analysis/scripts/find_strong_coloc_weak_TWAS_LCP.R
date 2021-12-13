library(qvalue)

check_trait<-function(trait_id){

    d= read.table(paste0("comparison/",trait_id,".PTWAS_vs_enloc.cmp.rst"), head=T)

    twas_pval = d$TWAS_pval
    twas_pval[twas_pval==0] = 1e-300
    colocp = d$LCP
    tissue = d$tissue

    cor_test<-function(tissue_id){


        pval = twas_pval[tissue==tissue_id]
        gid = d$gene[tissue==tissue_id]

        qrst = qvalue(pval, fdr.level=0.05)
        
        sig_twas = which(qrst$sig)
        sig_coloc=which(colocp[tissue==tissue_id]>=0.50)

        sig_coloc_only = gid[setdiff(sig_coloc, sig_twas)]

        if(length(sig_coloc_only)>0){
            for(i in 1:length(sig_coloc_only)){
                cat(trait_id,"\t",tissue_id,"\t", sig_coloc_only[i], d$TWAS_pval[d$tissue==tissue_id&d$gene==sig_coloc_only[i]], "\t",d$RCP[d$tissue==tissue_id&d$gene==sig_coloc_only[i]],"\n")
            }
        }

    }

    all_tissues = unique(tissue)

    return(t(sapply(all_tissues, function(x) cor_test(x))))
}


HDL_rst = check_trait("HDL")
LDL_rst = check_trait("LDL")
Height_rst = check_trait("Heights")
CAD_rst = check_trait("CAD")

