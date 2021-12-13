#open FILE, "data/strong_coloc_weak_twas.list";
while(<>){

    next if $_ !~ /\d/;
    my @data = split /\s+/, $_;
    shift @data until $data[0]=~/^\S/;
    $tissue = $data[1];
    $gene = $data[2];
    $rcd{"$gene:$tissue"}="$gene $tissue";

}

foreach (keys %rcd){
    print "$rcd{$_}\n";
}
