#! /usr/bin/perl

use strict;
use warnings;

die "perl $0 <sample_name> <export>" if(@ARGV!=2);

my($smpNm, $export)=@ARGV;

my $surdir='/dev/ngs007/hhong/BedFilt_CQHP/CQ_comp1_rep';
my %recH=();
my %idRec=();
my @Platform=("X_Ten");
#my @Labs=("ARD","NVG","WUX");
my @Labs=("ARD");
my @Aligners=("Bowtie2","BWA","ISAAC","stampy");
#my @GATK=();
my @Callers=("FreeBayes","HC","ISAAC","Samtools","SNVer","Varscan");
my @sumF=("AB","BA","A","B");
my $cntLB=0; my $cntAL=0; my $cntCL=0;
for my $lb (@Labs){
#	$cntLB++;
	for my $al (@Aligners){
#		$cntAL++;
		for my $cl (@Callers){
			$cntCL++;
			my $idx=0;
			my $info=();
		    foreach my $sumTgt(@sumF){
			if((open TGTFIL, $surdir.'/'."$al"."_GATK_"."$cl".'/'."$lb".'_'."$smpNm".'_Q1_T2'.'/'.$sumTgt.'.stat.txt' )){
			    while(<TGTFIL>){
			#	print $_."\n";
				chomp;
				$idx="1".'vs'."2";
			#	print $idx."\n";
				my(@arry)=split/\:/,$_;
				$arry[0]=~ s/\s+$//;
			#	print $arry[1]."b\n";
				$info=$arry[0].'_'.$lb.'_'.$al.'_'.$cl.'_'."Y";
			#	print $info."\n";
				if(!defined $recH{$info}{$idx}){
					$recH{$info}{$idx}=$arry[1];
				}else{
					$recH{$info}{$idx}=$recH{$info}{$idx}."\t".$arry[1];
				}
			    }
#			    exit;
			}else{
				print "openFailed\n";
			}

			if((open TGTFIL, $surdir.'/'."$al"."_GATK_"."$cl".'/'."$lb".'_'."$smpNm".'_Q1_T3'.'/'.$sumTgt.'.stat.txt' )){
			    while(<TGTFIL>){
				chomp;
				$idx="1".'vs'."3";
				my(@arry)=split/\:/,$_;
				$arry[0]=~ s/\s+$//;
				$info=$arry[0].'_'.$lb.'_'.$al.'_'.$cl.'_'."Y";
				if(!defined $recH{$info}{$idx}){
					$recH{$info}{$idx}=$arry[1];
				}else{
					 $recH{$info}{$idx}=$recH{$info}{$idx}."\t".$arry[1];
				}
			    }
			}else{
				print "openFailed\n";
			}

			if((open TGTFIL, $surdir.'/'."$al"."_GATK_"."$cl".'/'."$lb".'_'."$smpNm".'_Q2_T3'.'/'.$sumTgt.'.stat.txt' )){
			    while(<TGTFIL>){
				chomp;
				$idx="2".'vs'."3";
				my(@arry)=split/\:/,$_;
				$arry[0]=~ s/\s+$//;
				$info=$arry[0].'_'.$lb.'_'.$al.'_'.$cl.'_'."Y";
				if(!defined $recH{$info}{$idx}){
					$recH{$info}{$idx}=$arry[1];
				}else{
					$recH{$info}{$idx}=$recH{$info}{$idx}."\t".$arry[1];
				}
			    }
			}else{
				print "openFailed\n";
			}

			if((open TGTFIL, $surdir.'/'."$al"."_"."$cl".'/'."$lb".'_'."$smpNm".'_Q1_T2'.'/'.$sumTgt.'.stat.txt' )){
                            while(<TGTFIL>){
				chomp;
				$idx="1".'vs'."2";
				my(@arry)=split/\:/,$_;
				$arry[0]=~ s/\s+$//;
				$info=$arry[0].'_'.$lb.'_'.$al.'_'.$cl.'_'."N";
				if(!defined $recH{$info}{$idx}){
					$recH{$info}{$idx}=$arry[1];
				}else{
					$recH{$info}{$idx}=$recH{$info}{$idx}."\t".$arry[1];
				}
			    }
			}else{
				print "openFailed\n";
			}

			if((open TGTFIL, $surdir.'/'."$al"."_"."$cl".'/'."$lb".'_'."$smpNm".'_Q1_T3'.'/'.$sumTgt.'.stat.txt' )){
			    while(<TGTFIL>){
				chomp;
				$idx="1".'vs'."3";
				my(@arry)=split/\:/,$_;
				$arry[0]=~ s/\s+$//;
				$info=$arry[0].'_'.$lb.'_'.$al.'_'.$cl.'_'."N";
				if(!defined $recH{$info}{$idx}){
					$recH{$info}{$idx}=$arry[1];
				}else{
					$recH{$info}{$idx}=$recH{$info}{$idx}."\t".$arry[1];
				}
			    }
			}else{
				print "openFailed\n";
			}

			if((open TGTFIL, $surdir.'/'."$al"."_"."$cl".'/'."$lb".'_'."$smpNm".'_Q2_T3'.'/'.$sumTgt.'.stat.txt' )){
			    while(<TGTFIL>){
				chomp;
				$idx="2".'vs'."3";
				my(@arry)=split/\:/,$_;
				$arry[0]=~ s/\s+$//;
				$info=$arry[0].'_'.$lb.'_'.$al.'_'.$cl.'_'."N";
				if(!defined $recH{$info}{$idx}){
					$recH{$info}{$idx}=$arry[1];
				}else{
					$recH{$info}{$idx}=$recH{$info}{$idx}."\t".$arry[1];
				}
			    }
			}else{
				print "openFailed\n";
			}
		    }	
		}
	} 
}

for my $lb(@Labs){
	for my $tt("RTG","sentieon"){
		foreach my $sumTgt(@sumF){
	  		my $idx=(); my $info=();		
                        if((open TGTFIL, $surdir.'/'."$tt"."_"."$tt".'/'."$lb".'_'."$smpNm".'_Q1_T2'.'/'.$sumTgt.'.stat.txt' )){
                            while(<TGTFIL>){
                                chomp;
                                $idx="1".'vs'."2";
                                my(@arry)=split/\:/,$_;
                                $arry[0]=~ s/\s+$//;
                                $info=$arry[0].'_'.$lb.'_'.$tt.'_'.$tt.'_'."N";
                                if(!defined $recH{$info}{$idx}){
                                        $recH{$info}{$idx}=$arry[1];
                                }else{
                                        $recH{$info}{$idx}=$recH{$info}{$idx}."\t".$arry[1];
                                }
                            }
                        }else{
                                print "openFailed\n";
                        }

                        if((open TGTFIL, $surdir.'/'."$tt"."_"."$tt".'/'."$lb".'_'."$smpNm".'_Q1_T3'.'/'.$sumTgt.'.stat.txt' )){
                            while(<TGTFIL>){
                                chomp;
                                $idx="1".'vs'."3";
                                my(@arry)=split/\:/,$_;
                                $arry[0]=~ s/\s+$//;
                                $info=$arry[0].'_'.$lb.'_'.$tt.'_'.$tt.'_'."N";
                                if(!defined $recH{$info}{$idx}){
                                        $recH{$info}{$idx}=$arry[1];
                                }else{
                                        $recH{$info}{$idx}=$recH{$info}{$idx}."\t".$arry[1];
                                }
                            }
                        }else{
                                print "openFailed\n";
                        }

                        if((open TGTFIL, $surdir.'/'."$tt"."_"."$tt".'/'."$lb".'_'."$smpNm".'_Q2_T3'.'/'.$sumTgt.'.stat.txt' )){
                            while(<TGTFIL>){
                                chomp;
                                $idx="2".'vs'."3";
                                my(@arry)=split/\:/,$_;
                                $arry[0]=~ s/\s+$//;
                                $info=$arry[0].'_'.$lb.'_'.$tt.'_'.$tt.'_'."N";
                                if(!defined $recH{$info}{$idx}){
                                        $recH{$info}{$idx}=$arry[1];
                                }else{
                                        $recH{$info}{$idx}=$recH{$info}{$idx}."\t".$arry[1];
                                }
                            }
                        }else{
                                print "openFailed\n";
                        }
		}
	}
}


my (@tgtID)=("SNPs","MNPs","Insertions","Deletions","Indels","Passed Filters");
my $outdir='/dev/ngs007/hhong/BedFilt_CQHP/CQ_comp1_rep/z_stat';
foreach my $patn(@tgtID){
	my $outfile=$outdir.'/'."$export".'_'."$patn".'.txt';
	open(EXPORT, ">$outfile") || die "$!";
	print EXPORT "Lab\tAligner\tGATK\tCaller\tComparisonType\tAB\tBA\tA\tB\n";
	my $cntA=0;my $cntB=0;
	for my $lb(@Labs){
		for my $al(@Aligners){
			for my $cl(@Callers){
				$cntA++;
#					print EXPORT $lb."\t".$al."\t".$cl."\t";
				my $info=();
				for my $idx("1vs2","1vs3","2vs3"){
					$info=$patn.'_'.$lb.'_'.$al.'_'.$cl.'_'."Y";
					print EXPORT $lb."\t".$al."\tY\t".$cl."\t".$idx."\t".$recH{$info}{$idx}."\n";
				}
				for my $idx("1vs2","1vs3","2vs3"){
					$info=$patn.'_'.$lb.'_'.$al.'_'.$cl.'_'."N";
					print EXPORT $lb."\t".$al."\tN\t".$cl."\t".$idx."\t".$recH{$info}{$idx}."\n";
				}
			}
		}
		for my $tt("RTG","sentieon"){
			my $info=();
			for my $idx("1vs2","1vs3","2vs3"){
				$info=$patn.'_'.$lb.'_'.$tt.'_'.$tt.'_'."N";
				print EXPORT $lb."\t".$tt."\tN\t".$tt."\t".$idx."\t".$recH{$info}{$idx}."\n";
			}
		}
	}
	close EXPORT;
}


exit;
