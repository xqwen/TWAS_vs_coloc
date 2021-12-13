@files = <fastENLOC_output/*.enrich.out>;
foreach $f (@files){
    $f =~/\/([a-zA-Z]+)\_(\S+)\.enloc/;
    $trait = $1;
    $tissue = $2;
    open FILE, "$f";
    while(<FILE>){
        if(/Intercept\s+(\S+)/){
            $a0 = $1;
        }

        if(/w\/\s+\S+\s+(\S+)/){
            $a1 = $1;
        }
    }

    print "fastenloc -e gtex_annotation/gtex_v8.eqtl_annot_coord.vcf.gz -t $tissue -g gwas_data/gwas/torus/$trait.torus.pip.gz -a0 $a0 -a1 $a1 -prefix fastENLOC_output/$trait\_$tissue\n";
   

}
