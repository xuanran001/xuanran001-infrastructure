#!/usr/bin/perl
use strict;

my $flag_file = '/var/log/nhandler_reboot.log';

my @zombie_blender = `ps axo pid=,stat=,args | grep blender | awk '\$2~/^Z/ { print }'`;
if( scalar(@zombie_blender) > 0)
{
  if (-e $flag_file) {
   print('CRITICAL - Nvidia Driver failed,but flag file exists!');
   `echo $(date): - Nvidia Driver failed,but flag file exists! >> /var/log/gpu_fail.log`;
   exit(2); #cirtical
  }else{
   print('CRITICAL - Nvidia Driver failed,system will reboot.');
   `echo $(date): - Nvidia Driver failed,system will reboot.! >> /var/log/gpu_fail.log`;
   `/bin/touch $flag_file;/usr/bin/reboot now`;
   exit(2); #cirtical
  }
}else{

  if (-e $flag_file) {
    `/bin/rm $flag_file`;
  }
  my @nvidia_temperature = `/usr/bin/nvidia-smi -q -d TEMPERATURE`;


  my $count = 0;
  my $max=0;
  my $min=10000;
  my $avg=0;

  foreach my $line (@nvidia_temperature) {
#    if( $line =~ /^\s+Gpu\s+:\s*(\d+)\s*C$/ )    ##旧版驱动检测命令
	 if( $line =~ /^\s+GPU\ Current\ Temp\s+:\s*(\d+)\s*C$/ )
    {
  #    print $line;
      if( $max < $1){
         $max = 0 + $1;}

      if( $min > $1){
         $min = 0 + $1;}

      if($avg == 0){
        $avg = $1;
      }else{
        $avg = ($avg + $1) / 2;
      }
      $count = $count + 1;
  #    print $1;
    }
    #TODO: check the situation of GPU failed. use -r to switch it.
  }

  if($count == 0) {
     print('CRITICAL - Nvidia Driver failed');
     exit(2); #cirtical
  } elsif ($max > 100) {
     print("CRITICAL - Max temperature is over 100C!,please checking... MAX=$max,MIN=$min,AVG=$avg,Count=$count.");
     exit(2); #critical
  } elsif ($max > 95) {
     print("WARNING - Max temperature is over 95C!,please noticing...MAX=$max,MIN=$min,AVG=$avg,Count=$count.");
     exit(1);
  } elsif($avg > 90) {
     print("CRITICAL - Average temperature is over 90C!,please noticing...MAX=$max,MIN=$min,AVG=$avg,Count=$count.");
     exit(2);
  }

  print("OK - MAX=$max,MIN=$min,AVG=$avg,Count=$count.");
  exit(0);
}
