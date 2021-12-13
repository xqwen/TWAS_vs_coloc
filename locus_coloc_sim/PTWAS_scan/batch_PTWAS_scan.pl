for (1..7500){

    $g = "g$_";
    print "Gene\tfcor_cof\tpval\n";
    print `Rscript PTWAS_scan/PTWAS_scan.R $g`;
}
