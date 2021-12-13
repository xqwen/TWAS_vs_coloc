while(<>){

    next if $_ !~ /\d/;
    my @data = split /\s+/, $_;
    shift @data until $data[0]=~/^\S/;
    my ($snp, $b_gx, $se_gx, $b_gy, $se_gy) = @data;
    my $beta_xy = $b_gy/$b_gx;
    $se_xy = sqrt($se_gy**2/$b_gx**2 + $b_gy**2*$se_gx**2/$b_gx**4);
    printf "%25s   %9.3f  %9.3f\n", $snp, $beta_xy, $se_xy;
}
