
#! /usr/bin/perl

$model_id = 1;

for $i  (0..$#ARGV){
    if ($ARGV[$i] eq "-d"){
        $data_file = $ARGV[++$i];
        next;
    }
    if($ARGV[$i] eq "-f"){
        $fm_file = $ARGV[++$i];
        next;
    }

    if($ARGV[$i] eq "-m"){
        $model_id = $ARGV[++$i];
        next;
    }
}


if(!defined($data_file) || !defined($fm_file)){
    print STDERR "Usage: perl check_model.pl -d sbams_file -f dapg_output [-m model_id]\n";
    exit;
}

open FILE, "$fm_file";
while(<FILE>){
    next if $_ !~ /\[/;
    /^\s*(\d+)\s+/;
    next if $1 != $model_id;
    chomp;
    print "Model: $_\n";
    @list = /\[(\S+?)\]/g;
    @rcd{@list} = @list;
    last;
}


open FILE, "$data_file";
while(<FILE>){

    next if $_ !~/\d/;
    my @data = split /\s+/, $_;
    shift @data until $data[0]=~/^\S/;
    my @v;
    if(/^\s*pheno/){
        @v = ("expression", @data[3..$#data]);
        push @out, \@v;
        next;
    }
    if(/^\s*controlled/){
        next if defined($hash{$data[1]});

        @v = ($data[1], @data[3..$#data]);
        push @out, \@v;
        $hash{$data[1]} = 1;
        next;
    } 
    if(/^\s*geno/ && defined($rcd{$data[1]})){
        @v = ($data[1], @data[3..$#data]);
        push @out, \@v;
        next;
    }	      


}

$ncol = scalar(@out);
$nrow = scalar(@{$out[0]});

open OUT, ">reg.dat";

foreach $j (0..$nrow-1){	
    foreach $i (0..$ncol-1){
        print OUT "$out[$i][$j]  ";
    } 
    print OUT "\n";
}    

$size = scalar(@list);
$out = `Rscript regression.R $size`;
print "$out\n\n";

#unlink "reg.dat"

