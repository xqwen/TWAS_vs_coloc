open FILE, "data/strong_coloc_strong_twas.list";
while(<FILE>){
    
    next if $_ !~ /\d/;
    
    my @data = split /\s+/, $_;
    shift @data until $data[0]=~/^\S/;
    next if $data[0] ne $ARGV[0];
    push @genes, $data[2];
    push @tissues, $data[1];
}


$trait = $ARGV[0];
if ($trait eq "Heights"){
    $trait = "height";
}
$gwas_file = (<data/gwas_zscore/*$trait*.gz>)[0];

open FILE, "zcat $gwas_file | ";
while(<FILE>){
	next if $_ !~ /\d/;
	my @data = split /\s+/, $_;
	shift @data until $data[0]=~/^\S/;
	$gwas{$data[1]} = "$data[-6]\t1.0";
}



for $i (0..$#genes){
    $g = $genes[$i];
    $t = $tissues[$i];
    my $f = "data/eqtl_info_baseline/$g\_$t.eqtl.dat";
    open FILE, "$f";
    open OUT, ">PTWAS_est/input_baseline/$trait\_$g\_$t.PTWAS.in";
    while(<FILE>){
        next if $_ !~ /\d/;
        chomp;
        my @data = split /\s+/, $_;
        shift @data until $data[0]=~/^\S/;
        next if $data[-1] <= 1e-6;
        my $snp = $data[0];
        my $zscore = "0.0\t1.0"; 
        if(defined($gwas{$snp})){
            $zscore = $gwas{$snp};
        }
        print OUT "$_ $zscore\n";
    } 
    close OUT;

}




