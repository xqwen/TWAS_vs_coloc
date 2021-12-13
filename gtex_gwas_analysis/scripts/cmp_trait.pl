$trait = $ARGV[0];


$twas_file = "PTWAS_scan_output/$trait.ptwas.gambit.stratified_out.txt";

open FILE, "$twas_file";
while(<FILE>){

    next if $_ !~/\d/;
    my @data = split /\s+/, $_;
    shift @data until $data[0]=~/^\S/;
    next if $#data < 7;
    $data[2]=~/(ENSG\d+)/;
    my $g = $1;
    $ptwas{$g}->{$data[4]} = $data[7];
    $tissue{$data[4]}= 1;
}


@ts = sort {$a cmp $b} keys %tissue;
printf "gene\ttissue\tTWAS_pval\tRCP\tLCP\n";
foreach $t (@ts){

    $eqtl_file = "fastENLOC_output/gene_level/$trait\_$t.enloc.gene.out";
    open FILE, "$eqtl_file";
    my %coloc_rcp;
    my %coloc_lcp;
    while(<FILE>){
        next if $_ !~ /\d/;
        
        my @data = split /\s+/, $_;
        shift @data until $data[0]=~/^\S/;
        
        $data[0]=~/(ENSG\d+)/;
        $g = $1;
        $coloc_rcp{$g} = $data[1];
        $coloc_lcp{$g} = $data[2];

    }

    foreach $g (keys %ptwas){


        next if !defined($ptwas{$g}->{$t}) && !defined($coloc_rcp{$g});

        if(!defined($ptwas{$g}->{$t})){
            $ptwas{$g}->{$t} = "1.00";
        }

        if(!defined($coloc_rcp{$g})){
            $coloc_rcp{$g} = $coloc_lcp{$g} = "0.00";
        }


        printf "%15s\t%35s\t%7.3e\t\t%7.3e\t%7.3e\n",$g,$t,$ptwas{$g}->{$t},$coloc_rcp{$g}, $coloc_lcp{$g};
    }
}


