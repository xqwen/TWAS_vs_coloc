@traits = ("Heights", "HDL", "LDL", "CAD");
foreach $t (@traits){
    
    `perl scripts/cmp_trait.pl $t > comparison/$t.PTWAS_vs_enloc.cmp.rst &`;
}


