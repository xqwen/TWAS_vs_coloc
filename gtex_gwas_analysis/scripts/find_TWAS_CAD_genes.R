library(qvalue)

check_trait<-function(trait_id){

    d= read.table(paste0("comparison/",trait_id,".PTWAS_vs_enloc.cmp.rst"), head=T)

    twas_pval = d$TWAS_pval
    twas_pval[twas_pval==0] = 1e-300
    colocp = d$RCP
    tissue = d$tissue

    cor_test<-function(tissue_id){


        pval = twas_pval[tissue==tissue_id]
        gid = d$gene[tissue==tissue_id]

        qrst = qvalue(pval, fdr.level=0.05)
        
        sig_twas = gid[which(qrst$sig)]


        if(length(sig_twas)>0){
            for(i in 1:length(sig_twas)){
                cat(trait_id,"\t",tissue_id,"\t", sig_twas[i], d$TWAS_pval[d$tissue==tissue_id&d$gene==sig_twas[i]],"\n")
            }
        }

    }

    all_tissues = unique(tissue)

    return(t(sapply(all_tissues, function(x) cor_test(x))))
}


CAD_rst = check_trait("CAD")

