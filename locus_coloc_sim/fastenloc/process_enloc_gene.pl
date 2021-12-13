open FILE, "fastenloc/sim.enloc.sig.out";
while(<FILE>){

    next if $_ !~ /\d/;
    my @data = split /\s+/, $_;
    shift @data until $data[0]=~/^\S/;

    $data[0]=~/(g\d+)/;
    $g = $1;
    $rcd1{$g} = 1 if !defined $rcd1{$g};
    $rcd1{$g} *= (1-$data[-2]);
      
    $rcd2{$g} = 1 if !defined $rcd2{$g};
    $rcd2{$g} *= (1-$data[-1]);
}

printf("gene\tRCP\tLCP\n");

for (1..7500){
    $g = "g$_";
    if(!defined($rcd1{$g})){
        printf "$g\t%7.3f\t%7.3f\n", 0,0;
    }else{
        printf "$g\t%7.3f\t%7.3f\n", 1-$rcd1{$g}, 1-$rcd2{$g};
    }
}


