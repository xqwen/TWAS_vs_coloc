# Analyzing and Reconciling Colocalization and Transcriptome-wide Association Studies from the Perspective of Inferential Reproducibility


This repo documents the data analysis and simulation studies performed in the manuscript "Analyzing and Reconciling Colocalization and Transcriptome-wide Association Studies from the Perspective of Inferential Reproducibility". The manuscript is available [here](https://www.biorxiv.org/content/10.1101/2021.10.29.466468v1.full)



## Software Implementation

The locus-level colocalization method described in the manuscript is implemented in the software package [fastENLOC](https://github.com/xqwen/fastenloc), version 2. The code depository is currently located in the [this repo directory](https://github.com/xqwen/fastenloc/tree/master/dev).

## Simulation Studies

We describe two different simulation studies:

  1. Illustrating the LD hitchhiking effect in TWAS scan analysis. The code and main results are included in the directory [```LD_hitchhiking```](https://github.com/xqwen/TWAS_vs_coloc/tree/main/LD_hitchhiking)
  2. Assessing the empirical power of the proposed locus-level colocalization analysis. The corresponding code, results, and descriptions can be found in the directory [```locus_coloc_sim```](https://github.com/xqwen/TWAS_vs_coloc/tree/main/locus_coloc_sim/)

## GWAS and GTEx Data Analysis  

The relevant data, analysis code, and descriptions are included in the directory [```gtex_gwas_analysis```](https://github.com/xqwen/TWAS_vs_coloc/tree/main/gtex_gwas_analysis).


## References

* Hukku, A., Sampson, M.G., Luca, F., Pique-Regi, R. and Wen, X., 2021. Analyzing and Reconciling Colocalization and Transcriptome-wide Association Studies from the Perspective of Inferential Reproducibility. *BioRxiv* doi:[10.1101/2021.10.29.466468](https://doi.org/10.1101/2021.10.29.466468).
