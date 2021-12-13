open FILE, "../data/strong_coloc_weak_twas.list";
while(<FILE>){
    next if $_!~ /\d/;
    my @data = split /\s+/, $_;
    shift @data until $data[0]=~/^\S/;

    if ($data[0] eq "Heights"){
        $data[0] = "height";
    }

    $f = $data[0]."_".$data[2]."_".$data[1].".PTWAS.in";
    if (-e "input/$f"){
        `mv input/$f input/keep/`;
    }
}
