@files = <PTWAS_est/input_baseline/*.in>;
foreach $f (@files){

    $f =~/baseline\/(\S+)\_(ENSG\d+)\_(\S+)\.PTWAS/;
    $trait = $1;
    $gene = $2;
    $tissue = $3;
    $out = `~/bin/PTWAS_est -d $f`;
    $out =~ /\s+(\S+)\s*$/;
    printf "%10s %15s %25s  %7.3f\n", $trait, $gene, $tissue, $1;
}
