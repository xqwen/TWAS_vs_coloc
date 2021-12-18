# TWAS vs. RCP comparison

1. GWAS data are prepared (harmonized and imputed) by the GTEx consortium. For the traits of interest (HDL, LDL, CAD, and Hieght), they are processed to generate required TORUS PIP files (for colocalization) and GAMBIT files (for TWAS analysis). All data in ```gwas_data```.

2. Colocalization by fastENLOC (TORUS PIP files + gtex eQTL annotations)

3. PTWAS scan by GAMBIT (GAMBIT input + gtex PTWAS weights)

4. Output files are organized in ```fastENLOC_output``` and ```PTWAS_scan_output```

5. Tally comparison for each trait by

```
perl scripts/batch_cmp.pl
```

output files are saved in ```comparison``` directory


6. Produce summary information

```
Rscript scripts/compare_trait_tissue_RCP_TWAS.R
Rscript scripts/compare_trait_tissue_LCP_TWAS.R
```
summary files (```TWAS_vs_RCP.summary``` and ```TWAS_vs_LCP.summary```) and figures are generated in ```comparison``` directory.

7. Find strong colocalization but weak TWAS signals

```
Rscript scripts/find_strong_coloc_weak_TWAS_RCP.R >  strong_coloc_weak_twas/RCP/data/strong_coloc_weak_twas.list
Rscript scripts/find_strong_coloc_weak_TWAS_RCP.R >  strong_coloc_strong_twas/RCP/data/strong_coloc_strong_twas.list
```

## Strong RCP and weak TWAS analysis

The main goal of this analysis is to tally the heterogeneity test statistics for strong colocalization and weak TWAS signals

working directory ```strong_coloc_weak_twas/```.

1. get tissue gene pair to extract eqtl info from wsu cluster
```
perl scripts/get_gene_tissue.pl > results/gene_tissue.list
```

2. transfer gene_tissue.list to wsu cluster ```gtex_v8/TWAS_vs_coloc_analysis/```


3. transfer back ```data/eqtl_info```

4. assemble PTWAS_est input

```
perl scripts/assemble_PTWAS.pl Heights
perl scripts/assemble_PTWAS.pl HDL
perl scripts/assemble_PTWAS.pl LDL
perl scripts/assemble_PTWAS.pl CAD
```

5. compute I^2 and combine results
```
perl scripts/batch_PTWAS_est.pl > results/summary.I2.rst
perl scripts/combine_summary.pl > results/strong_coloc_weak_twas.summary
```
