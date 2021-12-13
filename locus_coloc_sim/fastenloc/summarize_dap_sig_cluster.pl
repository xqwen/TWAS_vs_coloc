use Cwd 'abs_path';

$dir = './';
for($i=0;$i<= $#ARGV; $i++){
    if($ARGV[$i] eq "-d" || $ARGV[$i] eq "-dir"){
        $dir = $ARGV[++$i];
        next;
    }
}


$dir = abs_path($dir);;
@files = <$dir/*.rst>;
$count=0;
foreach $f (@files){
    process_fm($f);
}



sub process_fm{
    my ($f) = @_;
    $f =~/$dir\/(\S+?)\./;

    my $gene = $1;
    my %cluster;
    open FILE, "grep \\\{ $f | ";
    while(<FILE>){
        s/\{//;
        s/\}//;
        my @data = split /\s+/, $_;
        shift @data until $data[0]=~/^\S/;
        $cluster{$data[0]} = "$gene\:$data[0]";
    }

    open FILE, "grep \\\(\\\( $f | ";
    while(<FILE>){
        my @data = split /\s+/, $_;
        shift @data until $data[0]=~/^\S/;
        next if $data[4] == -1;
        next if $data[2] < 1e-4;
        print "$data[1]\t$cluster{$data[4]}\t$data[2]\n";


    }

}


