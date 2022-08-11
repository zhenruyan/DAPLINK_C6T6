my $base='0000';
my $cksum;
my $num;
my $off;
my $s;

sub b($) {
  my $b=shift;
  $cksum+=hex($b);
  $num++;
  return uc($b);
}

while(<>) {
  next unless m/^\s*0x([0-9A-Fa-f]{4})([0-9A-Fa-f]{4})\s*:([ 0-9A-Fa-f]+)$/;
  if ($1 ne $base) {
  	  $base=$1;
  	  $cksum=0x02+0x04+hex(substr($base,0,2))+hex(substr($base,2,2));
  	  $cksum=(0x100-$cksum&0xFF)&0xFF;
  	  printf (":02000004${1}%02X\n", $cksum);
  }
  $off=$2;
  $s=$3;
  $cksum=hex(substr($off,0,2))+hex(substr($off,2,2));
  $num=0;
  $s=~s/\s*([0-9A-Fa-f]{2})\s*/b($1)/ge;
  $cksum+=$num;
  $cksum=(0x100-$cksum&0xFF)&0xFF;
  printf (":%02X${off}00${s}%02X\n", $num, $cksum);
}

print ":00000001FF\n";
