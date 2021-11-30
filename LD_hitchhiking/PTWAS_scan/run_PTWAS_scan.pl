open OUT1, ">before";
open OUT2, ">after";


while(<>){

    next if $_ !~/\d/;
    my @data = split /\s+/, $_;
    shift @data until $data[0]=~/^\S/;
    $data[0]=~/(chr\d+)\_(\d+)\_(\S+)\_(\S+)\_b38/;
    printf OUT1 "$1\t$2\t$3\t$4\t$1\:$2\t80000\t%f\tIntergenic\n", $data[3];
    printf OUT2 "$1\t$2\t$3\t$4\t$1\:$2\t80000\t%f\tIntergenic\n", $data[6];
}


close OUT1;
close OUT2;

unlink "sim.before.vcf.gz";
unlink "sim.after.vcf.gz"; 

`sort -nk2 before > sim.before.vcf`;
`sort -nk2 after > sim.after.vcf`;

`bgzip sim.before.vcf; tabix -p vcf sim.before.vcf.gz`;
`bgzip sim.after.vcf; tabix -p vcf sim.after.vcf.gz`;

unlink "before";
unlink "after";




`GAMBIT --gwas sim.before.vcf.gz --betas eQTL_data/PTWAS_DB.extracted.gz --prefix PTWAS_scan/PTWAS_before --ldref PTWAS_scan/gtex_LD_ref/chr*.gz --ldref-only`;
`GAMBIT --gwas sim.after.vcf.gz --betas  eQTL_data/PTWAS_DB.extracted.gz --prefix PTWAS_scan/PTWAS_after  --ldref PTWAS_scan/gtex_LD_ref/chr*.gz --ldref-only`;

unlink <sim.*.vcf.*>;
unlink "gmon.out";


