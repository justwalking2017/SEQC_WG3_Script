#! /usr/bin/perl

use strict;
use warnings;

die "perl $0 <sample_name> " if(@ARGV!=1);

my($smpNm)=@ARGV;

my $surdir='/dev/ngs007/hhong/BedFilt_CQHP/CQ_comp5_Lab';
my %recH=();
my %idRec=();
my @Platform=("X_Ten");
my @Labs=("ARD","NVG","WUX");
my @Replicates=("1","2","3");
my @Aligners=("RTG","sentieon");
#my @GATK=();
my @LabPatn=("ARD_NVG","ARD_WUX","NVG_WUX");
my @Callers=("RTG","sentieon");
my @sumF=("AB","BA","A","B");
my $cntLB=0; my $cntAL=0; my $cntCL=0;
for my $al (@Aligners){
    for my $repC(@Replicates){
	for my $cl(@Callers){
	    for my $cps(@LabPatn){
		foreach my $sumTgt(@sumF){
			#print $surdir.'/'."$smpNm".'_'."$repC".'/'."$al".'_GATK_'.$cl.'/'."$cps".'/'.$sumTgt.'.stat.txt'."\n";exit;
#			print $surdir.'/'."$lb".'_'."$smpNm".'_'."$repC".'/'."$al".'/'."$cps".'/'.$sumTgt.'.stat.txt'."\n";
			if((open TGTFIL, $surdir.'/'."$smpNm".'_'."$repC".'/'."$al".'_GATK_'."$cl".'/'.$cps.'/'.$sumTgt.'.stat.txt' )){	
			    while(<TGTFIL>){			
				chomp;
                                my $idx=$cps;
				my(@arry)=split/\:/,$_;
				$arry[0]=~ s/\s+$//;
				#print $arry[0]."\n";exit;
				my $info=$arry[0].'_'.$smpNm.'_'.$repC.'_'.$al.'_'."Y".'_'.$cl;
				if(!defined $recH{$info}{$idx}){
					$recH{$info}{$idx}=$arry[1];
				}else{
					$recH{$info}{$idx}=$recH{$info}{$idx}."\t".$arry[1];
				}
			    }
			}else{
				print "open failed!\n";
			}
			if((open TGTFIL, $surdir.'/'."$smpNm".'_'."$repC".'/'."$al".'_'.$cl.'/'."$cps".'/'.$sumTgt.'.stat.txt')){
			    while(<TGTFIL>){
				chomp;
				my $idx=$cps;
				my(@arry)=split/\:/,$_;
				$arry[0]=~ s/\s+$//;
				my $info=$arry[0].'_'.$smpNm.'_'.$repC.'_'.$al.'_'."N".'_'.$cl;
				if(!defined $recH{$info}{$idx}){
					$recH{$info}{$idx}=$arry[1];
				}else{
					$recH{$info}{$idx}=$recH{$info}{$idx}."\t".$arry[1];
				}
			    }
			}else{
				print "open failed!\n";
			}
		}
	    }
	}
    }
}

my (@tgtID)=("SNPs","MNPs","Insertions","Deletions","Indels","Passed Filters");
my $outdir='/dev/ngs007/hhong/BedFilt_CQHP/CQ_comp5_Lab/z_stat2left';
foreach my $patn(@tgtID){
	my $export=$outdir.'/'.$smpNm.'_'."$patn".'.txt';
	open(EXPORT, ">$export") || die "$!";
	print EXPORT "Sample\tReplicates\tAligner\tGATK\tCaller\tA_Lab\tB_Lab\tAB\tBA\tA\tB\n";
	for my $al(@Aligners){
	  for my $cl(@Callers){
	    for my $repC(@Replicates){
		my $info=();
		for my $idx(@LabPatn){
			my $ptn=$idx;
			$ptn=~ s/\_/\t/g;
		#	print $ptn."\n";print $idx."\n";exit;
			$info=$patn.'_'.$smpNm.'_'.$repC.'_'.$al.'_'."Y".'_'."$cl";
			print EXPORT $smpNm."\t".$repC."\t".$al."\tY\t$cl\t".$ptn."\t".$recH{$info}{$idx}."\n";
		}
		for my $idx(@LabPatn){
			my $ptn=$idx;
			$ptn=~ s/\_/\t/g;
			$info=$patn.'_'.$smpNm.'_'.$repC.'_'.$al.'_'."N".'_'.$cl;
			print EXPORT $smpNm."\t".$repC."\t".$al."\tN\t$cl\t".$ptn."\t".$recH{$info}{$idx}."\n";
		}
	    }
	  }
	}
	close EXPORT;
}


exit;
