1. run TWAS builder

```
perl PTWAS_scan/batch_twb.pl
```

2. run PTWAS scam

```
perl PTWAS_scan/batch_PTWAS_scan.pl > PTWAS_scan/PTWAS_scan.rst
```

3. FDR control

```
Rscript PTWAS_scan/qvalue.R
```
