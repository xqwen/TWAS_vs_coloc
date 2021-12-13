1. Get SNP list
```
grep geno sim_data/g*.eqtl.dat | awk '{print $2}' > fastenloc/snp.list
```

2. sort and make (pseudo)-vcf 
```
 sed s/g//g fastenloc/snp.list | sort -t_ -nk1 | awk '{print "1\t",NR,"\tg"$1,"\tA\tG"}' | gzip - > fastenloc/snp.list.vcf.gz
``` 


3. fastENLOC analysis


```
  perl fastenloc/summarize_dap2enloc.pl -d dap_out/dap_eqtl/ -v fastenloc/snp.list.vcf.gz | gzip - > fastenloc/eqtl.vcf.gz 
  perl fastenloc/summarize_dap_sig_cluster.pl -d dap_out/dap_gwas/ -v fastenloc/snp.list.vcf.gz | gzip - > fastenloc/gwas.pip.gz 

  fastenloc -g fastenloc/gwas.pip.gz -e fastenloc/eqtl.vcf.gz  -tv 8250000 --all -prefix fastenloc/sim
  perl fastenloc/process_enloc_gene.pl > fastenloc/sim.enloc.gene.out
```

4. FDR control and report

```
Rscript fastenloc/fdr.R
```



True enrichment info:

Total variants: 1100x7500 = 8250000
Colocalized variants: 2500
Non-overlap eQTL: 2500 + 5000x2 = 12500
Non-overlap GWAS hits: 2500 + 5000x2

True a0 = log(12500/8222500) = -6.49
True a1 = log(2500x8222500/12500^2) = 4.88


