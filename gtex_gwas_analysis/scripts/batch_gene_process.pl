@files = <fastENLOC_output/*.sig.out>;
foreach $f (@files){

    $f =~/\/(\S+)\.enloc/;
    print "perl scripts/process_enloc_gene.pl $f > fastENLOC_output/gene_level/$1.enloc.gene.out\n";
}
