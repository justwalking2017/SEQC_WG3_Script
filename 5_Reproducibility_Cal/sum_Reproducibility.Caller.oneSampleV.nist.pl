#! /usr/bin/perl

use strict;
use warnings;

die "perl $0 <sample_name> " if(@ARGV!=1);

my($smpNm)=@ARGV;

my $surdir='/dev/ngs007/hhong/BedFilt_CQHP/CQ_comp2_caller';
my %recH=();
my %idRec=();
my @Platform=("X_Ten");
#my @Labs=("ARD","NVG","WUX");
my @Labs=("ARD");
my @Replicates=("1","2","3");
my @Aligners=("Bowtie2","BWA","ISAAC","stampy");
#my @GATK=();
my @CallerPatn=("FreeBayes_HC","FreeBayes_ISAAC","FreeBayes_Samtools","FreeBayes_SNVer","FreeBayes_Varscan","HC_ISAAC","HC_Samtools","HC_SNVer","HC_Varscan","ISAAC_Samtools","ISAAC_SNVer","ISAAC_Varscan","Samtools_SNVer","Samtools_Varscan","SNVer_Varscan");
my @Callers=("FreeBayes","HC","ISAAC","Samtools","SNVer","Varscan");
my @sumF=("AB","BA","A","B");
my $cntLB=0; my $cntAL=0; my $cntCL=0;
for my $lb(@Labs){
    for my $al (@Aligners){
	for my $repC(@Replicates){
	    for my $cps(@CallerPatn){
		foreach my $sumTgt(@sumF){
#			print $surdir.'/'."$lb".'_'."$smpNm".'_'."$repC"."_GATK".'/'."$al".'/'."$cps".'/'.$sumTgt.'.stat.txt'."\n";
#			print $surdir.'/'."$lb".'_'."$smpNm".'_'."$repC".'/'."$al".'/'."$cps".'/'.$sumTgt.'.stat.txt'."\n";
			if((open TGTFIL, $surdir.'/'."$lb".'_'."$smpNm".'_'."$repC"."_GATK".'/'."$al".'/'."$cps".'/'.$sumTgt.'.stat.txt' )){	
			    while(<TGTFIL>){			
				chomp;
                                my $idx=$cps;
				my(@arry)=split/\:/,$_;
				$arry[0]=~ s/\s+$//;
				#print $arry[1]."b\n";
				my $info=$arry[0].'_'."$lb".'_'.$smpNm.'_'.$repC.'_'.$al.'_'."Y";
				if(!defined $recH{$info}{$idx}){
					$recH{$info}{$idx}=$arry[1];
				}else{
					$recH{$info}{$idx}=$recH{$info}{$idx}."\t".$arry[1];
				}
			    }
			}else{
				print "open failed!\n";
			}
			if((open TGTFIL, $surdir.'/'."$lb".'_'."$smpNm".'_'."$repC".'/'."$al".'/'."$cps".'/'.$sumTgt.'.stat.txt')){
			    while(<TGTFIL>){
				chomp;
				my $idx=$cps;
				my(@arry)=split/\:/,$_;
				$arry[0]=~ s/\s+$//;
				my $info=$arry[0].'_'."$lb".'_'.$smpNm.'_'.$repC.'_'.$al.'_'."N";
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
my $outdir='/dev/ngs007/hhong/BedFilt_CQHP/CQ_comp2_caller/z_stat';
foreach my $patn(@tgtID){
	my $export=$outdir.'/'.$smpNm.'_'."$patn".'.txt';
	open(EXPORT, ">$export") || die "$!";
	print EXPORT "Lab\tSample\tReplicates\tAligner\tGATK\tA_caller\tB_caller\tAB\tBA\tA\tB\n";
	for my $lb(@Labs){
	  for my $al(@Aligners){
	    for my $repC(@Replicates){
		my $info=();
		for my $idx(@CallerPatn){
			my $ptn=$idx;
			$ptn=~ s/\_/\t/g;
		#	print $ptn."\n";print $idx."\n";exit;
			$info=$patn.'_'.$lb.'_'.$smpNm.'_'.$repC.'_'.$al.'_'."Y";
			print EXPORT $lb."\t".$smpNm."\t".$repC."\t".$al."\tY\t".$ptn."\t".$recH{$info}{$idx}."\n";
		}
		for my $idx(@CallerPatn){
			my $ptn=$idx;
			$ptn=~ s/\_/\t/g;
			$info=$patn.'_'.$lb.'_'.$smpNm.'_'.$repC.'_'.$al.'_'."N";
			print EXPORT $lb."\t".$smpNm."\t".$repC."\t".$al."\tN\t".$ptn."\t".$recH{$info}{$idx}."\n";
		}
	    }
	  }
	}
	close EXPORT;
}


exit;
