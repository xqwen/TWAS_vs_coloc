##  ENSG00000182134 in CAD

```
Trait	Gene	Tissue	TWAS_pval	coloc_sig	enloc_SPIP
CAD ENSG00000182134 Artery_Tibial 0.99377 ENSG00000182134:2(@)Loc75 0.9203
```

PTWAS p-value: 0.9938
RCP: 0.9203

## Diagnosis

1. re-run eQTL fine-mapping

```
dap-g -d ENSG00000182134.sbams.dat -t 4 -ld_control 0.5 -o ENSG00000182134.fm.rst 
```

The fine-mapping results show 2 independent eQTL clusters, with SPIPs > 0.90 and low LD between clusters.

Examine the top model by regression analysis

```
perl check_model.pl  -d ENSG00000182134.sbams.dat -f ENSG00000182134.fm.rst 
```

Output:

```
Model:     1   4.5105e-02    2     17.547   [chr1_151769933_A_G_b38] [chr1_151791573_A_G_b38]


Model fit:
                         Estimate Std. Error   t value     Pr(>|t|)
chr1_151769933_A_G_b38  0.3531445 0.03156559 11.187642 3.776504e-26
chr1_151791573_A_G_b38 -0.1800057 0.03835235 -4.693471 3.451028e-06


Allele frerquencies:
chr1_151769933_A_G_b38 chr1_151791573_A_G_b38 
             0.3458904              0.7945205 


LD between SNPs (R^2)
                       chr1_151769933_A_G_b38 chr1_151791573_A_G_b38
chr1_151769933_A_G_b38              1.0000000              0.1185486
chr1_151791573_A_G_b38              0.1185486              1.0000000
```

G allele (allel 1) in chr1_151769933_A_G_b38 increases gene expression level, whereas G allele (allele 1) in chr1_151791573_A_G_b38 decreases gene expression level.


2. Examine GWAS information

CAD single-SNP testing:

```
chr1_151769933_A_G_b38  Loc75  3.067303
chr1_151791573_A_G_b38  Loc75  4.833727
```

Both G alleles in both SNPs increases CAD risks. This is an evidence against direct causal effects from ENSG00000182134 to CAD risk. 


3. Formal IV analysis by different instruments


Input file MR.in:

```
SNP b_g2x   se_g2x  b_g2y   se_g2y
chr1_151769933_A_G_b38  0.3531445 0.03156559 0.030244	0.009860128888474332
chr1_151791573_A_G_b38 -0.1800057 0.03835235 0.055975	0.011580090442387593
```

Run MR estimates (2SLS):

```
perl MR_est.pl MR.in
```

Output of estimated gene-to-trait effects by the two SNPs/instruments

```
    Instrument  gene-to-trait_effect    se
   chr1_151769933_A_G_b38       0.086      0.029
   chr1_151791573_A_G_b38      -0.311      0.092
```

This explains the observed weak TWAS signal.


## Colcoalization info

RCPs for the two signal clusters 

```
ENSG00000182134:1(@)Loc75      7  9.966e-01 9.126e-04    2.257e-02      2.216e-02
ENSG00000182134:2(@)Loc75     10  9.958e-01 4.201e-01    9.404e-01      9.203e-01
```

SCP for relevant SNPs

```
ENSG00000182134:1(@)Loc75   chr1_151768977_G_A_b38   2.098e-01 1.200e-04    4.412e-03      4.364e-03
ENSG00000182134:1(@)Loc75   chr1_151769933_A_G_b38   2.525e-01 1.249e-04    5.510e-03      5.462e-03
ENSG00000182134:1(@)Loc75   chr1_151769943_GC_G_b38   2.098e-01 1.200e-04    4.412e-03      4.364e-03
ENSG00000182134:1(@)Loc75   chr1_151770322_T_C_b38   6.296e-02 1.328e-04    1.510e-03      1.446e-03
ENSG00000182134:1(@)Loc75   chr1_151777957_T_C_b38   6.296e-02 1.662e-04    1.879e-03      1.798e-03
ENSG00000182134:1(@)Loc75   chr1_151780842_T_G_b38   1.958e-01 1.384e-04    4.736e-03      4.678e-03
ENSG00000182134:2(@)Loc75   chr1_151786747_T_A_b38   2.639e-03 7.605e-03    2.064e-03      1.657e-03
ENSG00000182134:2(@)Loc75   chr1_151787655_T_C_b38   2.290e-03 7.096e-03    1.781e-03      1.400e-03
ENSG00000182134:2(@)Loc75   chr1_151790770_G_A_b38   2.524e-01 6.277e-02    2.388e-01      2.361e-01
ENSG00000182134:2(@)Loc75   chr1_151791573_A_G_b38   4.600e-01 6.651e-02    4.342e-01      4.319e-01
ENSG00000182134:2(@)Loc75   chr1_151793339_C_G_b38   9.935e-02 6.277e-02    9.605e-02      9.292e-02
ENSG00000182134:2(@)Loc75   chr1_151794014_C_T_b38   7.041e-02 1.690e-02    5.641e-02      5.566e-02
ENSG00000182134:2(@)Loc75   chr1_151794112_A_G_b38   2.298e-03 4.507e-03    1.389e-03      1.148e-03
ENSG00000182134:2(@)Loc75   chr1_151794375_T_A_b38   7.041e-02 6.438e-02    6.926e-02      6.597e-02
ENSG00000182134:2(@)Loc75   chr1_151795572_A_G_b38   5.394e-03 6.521e-02    8.577e-03      5.057e-03
ENSG00000182134:2(@)Loc75   chr1_151797662_T_C_b38   3.055e-02 6.238e-02    3.185e-02      2.856e-02
```



