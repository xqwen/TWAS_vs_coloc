args = commandArgs(trailingOnly=T)
gene = args[1]


wts_file = paste0("PTWAS_scan/twb_files/",gene, ".twb")
data_file = paste0("sim_data/",gene,".gwas.dat")

d = read.table(data_file)
G = t(as.matrix((d[d$V1=="geno",4:dim(d)[2]])))
y = as.numeric(d[d$V1=="pheno",4:dim(d)[2]])

d2 = read.table(wts_file)
w = as.matrix(d2$V4,ncol=1)

yhat = as.numeric(G%*%w)

rst = cor.test(yhat, y)
cat(gene,"  ", rst$est," ",rst$p.value,"\n")


