open FILE, "data/strong_coloc_weak_twas.list";
while(<FILE>){

    next if $_ !~/\d/;
    chomp;
    my @data = split /\s+/, $_;
    shift @data until $data[0]=~/^\S/;
    if($data[0] eq "Heights"){
        $data[0] = "height";
    }
    $rcd{"$data[0]:$data[1]:$data[2]"} = sprintf "%10s %15s  %25s \t\t %7.3e  %7.3f", $data[0], $data[2], $data[1], $data[3], $data[4];
}



open FILE, "results/summary.I2.rst";
while(<FILE>){
    next if $_ !~/\d/;
    chomp;
    my @data = split /\s+/, $_;
    shift @data until $data[0]=~/^\S/;
    
    $id = "$data[0]:$data[2]:$data[1]";
    printf "$rcd{$id} \t %7.3f\n", $data[-1];
}
