@files = <gtex_v8_fastqtl/*.gz>;
foreach $f (@files){
    $f=~/qtl\/(\S+)\.allpairs/;
    $tissue=$1;
    print "$tissue\n";
    next if -e "$tissue.top_eqtl.allgenes.rst";
    open OUT, ">$tissue.top_eqtl.allgenes.rst";
    open FILE, "zcat $f |";
    $curr = "";
    while(<FILE>){
        next if $_ !~ /\d/;
        my @data = split /\s+/, $_;
        shift @data until $data[0]=~/^\S/;

        if($data[0] ne $curr){
            if($curr ne ""){
                print OUT "$curr\t$snp\t$min_pval\t$beta\t$se\n";
            }
            $curr = $data[0];
            $min_pval = $data[6];
            $beta = $data[7];
            $se = $data[8];
            $snp = $data[1];
            next;
        }else{
            if($data[6]<$min_pval){
                $min_pval = $data[6];
                $beta = $data[7];
                $se = $data[8];
                $snp = $data[1];
            }
        }
    }
    print OUT "$curr\t$snp\t$min_pval\t$beta\t$se\n";
    close OUT;
}


