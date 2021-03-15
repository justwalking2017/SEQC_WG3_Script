#! /usr/bin/perl

use strict;
use warnings;

die "perl $0 <vcf_file> <minDP> <maxDP> <export>" if($#ARGV!=3);

my($vcfFile, $minDP, $maxDP, $export)=@ARGV;

my %freqH=();

if($vcfFile=~/FreeBayes/){
	open(VARFILE,$vcfFile) || die"$!";
	open(EXPORT,">$export") || die "$!";
	while(<VARFILE>){
		chomp;
		if($_=~/^#/){
			print EXPORT $_."\n";
			next;
		}
		my(@arry)=split/\t/,$_;
		my(@arry2)=split/\:/,$arry[9];
		next if($arry2[1]<8);
		next if($arry2[1]>223);
		print EXPORT $_."\n";	
	}
	close VARFILE;
	close EXPORT;
}elsif($vcfFile=~/Varscan/){
        open(VARFILE,$vcfFile) || die"$!";
        open(EXPORT,">$export") || die "$!";
        while(<VARFILE>){
                chomp;
                if($_=~/^#/){
                        print EXPORT $_."\n";
			next;
                }
                my(@arry)=split/\t/,$_;
#  		print $_."\n";exit;
	        my(@arry2)=split/\:/,$arry[9];
                next if($arry2[3]<8);
#		print $arry[9]."\n";exit;
                next if($arry2[3]>223);
                print EXPORT $_."\n";
        }
        close VARFILE;
        close EXPORT;	
}elsif($vcfFile=~/Samtools/){
        open(VARFILE,$vcfFile) || die"$!";
        open(EXPORT,">$export") || die "$!";
        while(<VARFILE>){
                chomp;
                if($_=~/^#/){
                        print EXPORT $_."\n";
			next;
                }
		my $dp=();
                my(@arry)=split/\t/,$_;
                my(@arry2)=split/\;/,$arry[7];
#		print $arry2[0]."\n";exit;	
		if($arry[7]=~/^DP/){
			($dp)=$arry2[0]=~/DP=(\d+)/;		
#			print $dp."\n";exit;
		}elsif($arry[7]=~/^INDEL/){
			($dp)=$arry2[3]=~/DP=(\d+)/;
		}

		if(!defined $dp){
			print "DP undefined at". $vcfFile. "\n";exit;
		}
                next if($dp<8);
                next if($dp>223);
                print EXPORT $_."\n";
        }
        close VARFILE;
        close EXPORT;
}elsif($vcfFile=~/HC/){
        open(VARFILE,$vcfFile) || die"$!";
        open(EXPORT,">$export") || die "$!";
        while(<VARFILE>){
                chomp;
                if($_=~/^#/){
                        print EXPORT $_."\n";
			next;
                }
		my $dp=();
                my(@arry)=split/\t/,$_;
		if($arry[8]=~/DP/){
			my(@arry2)=split/\:/,$arry[9];
			$dp=$arry2[2];
		}else{
			my(@arry3)=split/\;/,$arry[7];
			foreach my $k(0..$#arry3){
				if($arry3[$k]=~/^DP=/){
					($dp)=$arry3[$k]=~/DP=(\d+)/;
				}
			}
		}
		if(!defined $dp){
                        print "DP undefined at". $vcfFile. "\n";exit;
                }
                next if($dp<8);
                next if($dp>223);
                print EXPORT $_."\n";
        }
        close VARFILE;
        close EXPORT;
}elsif($vcfFile=~/SNVer/){
        open(VARFILE,$vcfFile) || die"$!";
        open(EXPORT,">$export") || die "$!";
        while(<VARFILE>){
                chomp;
                if($_=~/^#/){
                        print EXPORT $_."\n";
			next;
                }
                my $dp=();
                my(@arry)=split/\t/,$_;
                my(@arry2)=split/\;/,$arry[7];
                ($dp)=$arry2[0]=~/DP=(\d+)/;
                if(!defined $dp){
                        print "DP undefined at". $vcfFile. "\n";exit;
                }
                next if($dp<8);
                next if($dp>223);
                print EXPORT $_."\n";
        }
        close VARFILE;
        close EXPORT;
}elsif($vcfFile=~/ISAAC/){
        open(VARFILE,$vcfFile) || die"$!";
        open(EXPORT,">$export") || die "$!";
        while(<VARFILE>){
                chomp;
                if($_=~/^#/){
                        print EXPORT $_."\n";
                        next;
                }
                my $dp=();
                my(@arry)=split/\t/,$_;
                my(@arry2)=split/\:/,$arry[9];
                if($arry[8]=~/'GT:GQ:GQX:DP:DPF:AD'/){
                        $dp=$arry2[3];
                }elsif($arry[8]=~/'GT:GQX:DP:DPF:AD'/){
                        $dp=$arry2[2];
                }else{
                        $dp=$arry2[3];
                }
                if(!defined $dp){
                        print "DP undefined at". $vcfFile. "\n";exit;
                }
                next if($dp<8);
                next if($dp>223);
                print EXPORT $_."\n";
        }
        close VARFILE;
        close EXPORT;
}

exit;
