open FILE, "data/strong_coloc_weak_twas.list";
while(<FILE>){

    next if $_ !~ /\d/;
    my @data = split /\s+/, $_;
    shift @data until $data[0]=~/^\S/;
    $trait = $data[0];
    $tissue = $data[1];
    $gene = $data[2];
    if($trait eq "Heights"){
        $trait = "height";
    }
    $snp = find_top_eqtl();
    $f = (<data/gwas_zscore/*$trait*>)[0];
    open DATA2, "zcat $f | grep $snp |";
    while($l = <DATA2>){
        chomp $l;
        my @out = split /\s+/, $l;
        shift @out until $out[0]=~/^\S/;
        $smr_p = $out[-5];
        last;
    }
    print "$trait\t$tissue\t$gene\t$snp\t\t$smr_p\t$data[3]\t\t$data[4]\n";

}



sub find_top_eqtl {
    $snp = "";
    $min_p = 1;
    $f = (<data/top_eqtl/$tissue*>)[0];
    open DATA, "grep $gene $f | ";
    while($d = <DATA>){
        chomp $d;
        my @dd = split /\s+/, $d;
        shift @dd until $dd[0]=~/^\S/;
        $snp = $dd[1];
        last;
    }

    return $snp

}


