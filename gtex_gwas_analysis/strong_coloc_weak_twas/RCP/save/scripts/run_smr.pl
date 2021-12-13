open FILE, "zcat $ARGV[0] |";
$trait = $ARGV[1];
while(<FILE>){

    next if $_ !~/\d/;
    my @data = split /\s+/, $_;
    shift @data until $data[0]=~/^\S/;
    $rcd{$data[1]} = $data[-5];
}


@files = <data/top_eqtl/*.rst>;
foreach $f (@files){

    $f =~/eqtl\/(\S+)\.top/;
    $tissue = $1;
    open OUT, ">SMR/$trait\_$tissue.smr.rst";
    open FILE, "$f";
    while(<FILE>){
        next if $_ !~/\d/;
        my @data = split /\s+/, $_;
        shift @data until $data[0]=~/^\S/;
        $data[0]=~/(ENSG\d+)/;
        $gene = $1;
        if(!defined($rcd{$data[1]})){
            $pval = -1;
        }else{
            $pval = $rcd{$data[1]};
        }

        printf OUT "%15s %35s  %9.3e\n", $data[0], $data[1], $pval;
    }
    close OUT;
}
