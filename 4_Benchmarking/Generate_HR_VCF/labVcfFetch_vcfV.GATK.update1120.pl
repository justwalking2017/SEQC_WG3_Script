#! /usr/bin/perl

use strict;
use warnings;

die "perl $0 <pos_file> <sample> <align> <caller> " if($#ARGV!=3);

my($posFile, $sample, $aligner, $caller)=@ARGV;

my %freqH11=(); my %freqH10=(); my %freqH21=();my %freqH20=(); my %freqH30=();
open(FQFILE,$posFile) || die"$!";
while(<FQFILE>){
        chomp;
        my(@arry)=split/\t/,$_;
	for my $i(($arry[1]+1)..$arry[2]){
#		print $i."\n";exit;
 		if(($arry[4]=~/^1,2$/) or ($arry[4]=~/^1,3$/) or ($arry[4]=~/^1,2,3$/)){
#			print $i."\n";exit;
	       		$freqH11{$arry[0]}{$i}=();
		}elsif($arry[4]=~/^1$/){
			$freqH10{$arry[0]}{$i}=();		
		}elsif(($arry[4]=~/^2,3$/) or ($arry[4]=~/^1,2,3$/)){
			$freqH21{$arry[0]}{$i}=();
		}elsif($arry[4]=~/^2$/){
			$freqH20{$arry[0]}{$i}=();
		}elsif($arry[4]=~/^3$/){
			$freqH30{$arry[0]}{$i}=();
		}
	}
}
close FQFILE;

my $sourdir='/dev/ngs005/scratch/hhong/rep_repro_analysis/CQ/17_snvGT-CS_1119/3_bedtools_repOut';
my $varFile1=$sourdir.'/'.$aligner.'_GATK_'.$caller.'/'.'ARD_'.$sample.'_3repCS.sort.vcf';
my $varFile2=$sourdir.'/'.$aligner.'_GATK_'.$caller.'/'.'NVG_'.$sample.'_3repCS.sort.vcf';
my $varFile3=$sourdir.'/'.$aligner.'_GATK_'.$caller.'/'.'WUX_'.$sample.'_3repCS.sort.vcf';
#my $outdir='/dev/ngs007/hhong/benchmarking/CQ/3_bedtools_repOut';
my $outdir='/dev/ngs005/scratch/hhong/rep_repro_analysis/CQ/17_snvGT-CS_1119/5_bedtools_labOut';
my $export1=$outdir.'/'.$sample.'_'.$aligner.'_GATK_'.$caller.'_3labCS_3repCS.vcf';
my $export2=$outdir.'/'.$sample.'_'.$aligner.'_GATK_'.$caller.'_3labCS_3rep.noCS.vcf';
my $export3=$outdir.'/'.$sample.'_'.$aligner.'_GATK_'.$caller.'_3labCS_3rep.stat.txt';


my %H1=(); my %H2=(); my %H3=();
##open File-2 and Fetch POS/Allele/GT information
open(VARFIL, $varFile1) || die "$!";
while(<VARFIL>){
        chomp;
        next if $_=~/^#/;
        my(@arry)=split/\t/,$_;
        if((length($arry[3])==1) and (length($arry[4])==1)){
                my ($ref,$alt,$gt)=Fetch_Trio($_);
                $H1{$arry[0]}{$arry[1]}="$ref"."_"."$alt"."_"."$gt";
        }
}
close VARFIL;

open(VARFIL, $varFile2) || die "$!";
while(<VARFIL>){
	chomp;
	next if $_=~/^#/;
	my(@arry)=split/\t/,$_;
	if((length($arry[3])==1) and (length($arry[4])==1)){
		my ($ref,$alt,$gt)=Fetch_Trio($_);
		$H2{$arry[0]}{$arry[1]}="$ref"."_"."$alt"."_"."$gt";
	}
}
close VARFIL;

open(VARFIL, $varFile3) || die "$!";
while(<VARFIL>){
        chomp;
        next if $_=~/^#/;
        my(@arry)=split/\t/,$_;
 	if((length($arry[3])==1) and (length($arry[4])==1)){
		my ($ref,$alt,$gt)=Fetch_Trio($_);
	        $H3{$arry[0]}{$arry[1]}="$ref"."_"."$alt"."_"."$gt";
	}
}
close VARFIL;

#my %rcDup1=();
my %varCnt=();
my %csRec=();
my %csInd=();
open(VARFIL, $varFile1)|| die "$!";
open(EXPORT,">$export1") || die "$!";
open(EXPORN,">$export2") || die "$!";
while(<VARFIL>){
	chomp;
	if($_=~/^##/){
		print EXPORT $_."\n";next;
#		print EXPORN $_."\n";next;
	}elsif($_=~/^#/){
		print EXPORT "#CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\t"."$aligner".'_GATK_'."$caller\n";next;
#		print EXPORN "#CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\t"."$aligner".'_'."$caller\n";next;
	}
	my(@arry1)=split/\t/,$_;
#	next if (defined $rcDup1{$arry1[0]}{$arry1[1]});
	if((length($arry1[3])>1) or (length($arry1[4])>1)){
		my $flg=0; my $ocp=0;
		for my $tt($arry1[1]..($arry1[1]+length($arry1[3])-1)){
			if(exists $freqH11{$arry1[0]}{$tt}){
				$flg=1;
			}
			if((exists $H2{$arry1[0]}{$tt}) or (exists $H3{$arry1[0]}{$tt})){
				$ocp=1;
			}
		}
		if($ocp==0){
		    if($flg==1){
			print EXPORT $_."\n";
			varJdg(1,$_);
			for my $ss($arry1[1]..($arry1[1]+length($arry1[3])-1)){
				 if(exists $freqH11{$arry1[0]}{$ss}){
					$csInd{$arry1[0]}{$ss}=();
				}
			}
		    }
		}else{
			print EXPORN $arry1[0]."\t".$arry1[1]."\t$arry1[3]\t$arry1[4]\n";
			varJdg(0,$_);
		}  						
	}elsif(exists $freqH10{$arry1[0]}{$arry1[1]}){
		print EXPORN $arry1[0]."\t".$arry1[1]."\t$arry1[3]\t$arry1[4]\n";
		varJdg(0,$_);		
	}elsif(exists $freqH11{$arry1[0]}{$arry1[1]}){
		my ($ref,$alt,$gt)=Fetch_Trio($_);
		my $info="$ref"."_"."$alt"."_"."$gt";
		if(exists $H2{$arry1[0]}{$arry1[1]}){
			if($H2{$arry1[0]}{$arry1[1]} eq $info){
				print EXPORT $_."\n";
	                        varJdg(1,$_);
        	                $csRec{$arry1[0]}{$arry1[1]}=();
			}elsif(exists $H3{$arry1[0]}{$arry1[1]}){
				if($H3{$arry1[0]}{$arry1[1]} eq $info){
					print EXPORT $_."\n";
	                                varJdg(1,$_);
        	                        $csRec{$arry1[0]}{$arry1[1]}=();	
				}else{
					print EXPORN $arry1[0]."\t".$arry1[1]."\t$arry1[3]\t$arry1[4]\n";
	                                varJdg(0,$_);
				}
			}else{
				print EXPORN $arry1[0]."\t".$arry1[1]."\t$arry1[3]\t$arry1[4]\n";
				varJdg(0,$_);
			}
		}elsif(exists $H3{$arry1[0]}{$arry1[1]}){
			if($H3{$arry1[0]}{$arry1[1]} eq $info){
                                print EXPORT $_."\n";
                                varJdg(1,$_);
                                $csRec{$arry1[0]}{$arry1[1]}=();
                        }else{
                                print EXPORN $arry1[0]."\t".$arry1[1]."\t$arry1[3]\t$arry1[4]\n";
                                varJdg(0,$_);
                        }		
		}else{
			print EXPORN $arry1[0]."\t".$arry1[1]."\t$arry1[3]\t$arry1[4]\n";
			varJdg(0,$_);
		}
	}
#	$rcDup1{$arry1[0]}{$arry1[1]}=1;
}
close VARFIL;

#my %rcDup2=();
open(VARFIL, $varFile2)|| die "$!";
while(<VARFIL>){
        chomp;
	next if ($_=~/^#/);
        my(@arry2)=split/\t/,$_;
#	next if (defined $rcDup2{$arry2[0]}{$arry2[1]});
	if((length($arry2[3])>1) or (length($arry2[4])>1)){
                my $flg=0; my $ind=0; my $ocp=0;
                for my $tt($arry2[1]..($arry2[1]+length($arry2[3])-1)){
                        if(exists $freqH11{$arry2[0]}{$tt}){
                                $ind=1;
                        }
			if(exists $freqH21{$arry2[0]}{$tt}){
				$flg=1;
			}
			if((exists $H1{$arry2[0]}{$tt}) or (exists $H3{$arry2[0]}{$tt})){
                                $ocp=1;
                        }
                }
		if ($ind==0){
			if($flg==1){
				if($ocp==0){
					print EXPORT $_."\n";
		                        varJdg(1,$_);
                		        for my $ss($arry2[1]..($arry2[1]+length($arry2[3])-1)){
                                		if(exists $freqH21{$arry2[0]}{$ss}){
		                                        $csInd{$arry2[0]}{$ss}=();
		                        	}
                		        }
				}else{
					print EXPORN $arry2[0]."\t".$arry2[1]."\t$arry2[3]\t$arry2[4]\n";
					varJdg(0,$_);
				}
			}else{
				print EXPORN $arry2[0]."\t".$arry2[1]."\t$arry2[3]\t$arry2[4]\n";
				varJdg(0,$_);
			}			
		}
	}elsif(exists $freqH20{$arry2[0]}{$arry2[1]}){
                print EXPORN $arry2[0]."\t".$arry2[1]."\t$arry2[3]\t$arry2[4]\n";
                varJdg(0,$_);
        }elsif(exists $csRec{$arry2[0]}{$arry2[1]}){
		next;
	}elsif(exists $freqH21{$arry2[0]}{$arry2[1]}){
		my ($ref,$alt,$gt)=Fetch_Trio($_);
		my $info="$ref"."_"."$alt"."_"."$gt";
		if(exists $H3{$arry2[0]}{$arry2[1]}){
			if($H3{$arry2[0]}{$arry2[1]} eq $info){
        	                print EXPORT $_."\n";
                	        varJdg(1,$_);
                        	$csRec{$arry2[0]}{$arry2[1]}=();
			}else{
                                print EXPORN $arry2[0]."\t".$arry2[1]."\t$arry2[3]\t$arry2[4]\n";
                                varJdg(0,$_);
			}
		}else{
			print EXPORN $arry2[0]."\t".$arry2[1]."\t$arry2[3]\t$arry2[4]\n";
                        varJdg(0,$_);
		}		
	}else{
		print EXPORN $arry2[0]."\t".$arry2[1]."\t$arry2[3]\t$arry2[4]\n";
		varJdg(0,$_);
	}
#	$rcDup2{$arry2[0]}{$arry2[1]}=1;
}
close VARFIL;

my %rcDup3=();
open(VARFIL, $varFile3)|| die "$!";
while(<VARFIL>){
        chomp;
        next if ($_=~/^#/);
        my(@arry3)=split/\t/,$_;
#	next if (defined $rcDup3{$arry3[0]}{$arry3[1]});
	if((length($arry3[3])>1) or (length($arry3[4])>1)){
                my $flg=0; my $ind=0; my $ocp=0;
                for my $tt($arry3[1]..($arry3[1]+length($arry3[3])-1)){
                        if(exists $freqH11{$arry3[0]}{$tt}){
                                $ind=1;
                        }
                        if(exists $freqH21{$arry3[0]}{$tt}){
                                $flg=1;
                        }
			if((exists $H1{$arry3[0]}{$tt}) or (exists $H3{$arry3[0]}{$tt})){
                                $ocp=1;
                        }
                }
                if ($ind==0 and $flg==0){
                	print EXPORN $arry3[0]."\t".$arry3[1]."\t$arry3[3]\t$arry3[4]\n";
                        varJdg(0,$_);
                }
        }elsif(exists $freqH30{$arry3[0]}{$arry3[1]}){
                print EXPORN $arry3[0]."\t".$arry3[1]."\t$arry3[3]\t$arry3[4]\n";
                varJdg(0,$_);
        }elsif(exists $csRec{$arry3[0]}{$arry3[1]}){
                next;
	}else{
		print EXPORN $arry3[0]."\t".$arry3[1]."\t$arry3[3]\t$arry3[4]\n";
		varJdg(0,$_);
        }
#	$rcDup3{$arry3[0]}{$arry3[1]}=1;
}
close VARFIL;
close EXPORT;
close EXPORN;

open(EXPORS,">$export3") || die "$!";
foreach my $k(sort {$a<=>$b} keys %varCnt){
	foreach my $j(1..5){
		if(defined $varCnt{$k}{$j}){
			print EXPORS $k."\t".$j."\t".$varCnt{$k}{$j}."\n";
		}else{
			print EXPORS $k."\t".$j."\t".'0'."\n";
		}
	}
}
close EXPORS;


sub varJdg{
	my ($tag,$var)=@_;
	my (@rows)=split/\t/,$var;	
        if ($rows[4]!~/,/){
                if(length($rows[4])==length($rows[3])){
                        if(length($rows[4])==1){
				$varCnt{$tag}{'1'}++;
                        }else{
                                $varCnt{$tag}{'5'}++;
                        }
                }elsif(length($rows[4])>length($rows[3])){
			$varCnt{$tag}{'2'}++;
                }else{
			$varCnt{$tag}{'3'}++;
                }
        }else{
                if(length($rows[4])==3){
			$varCnt{$tag}{'1'}++;
                }else{
                        my(@alts)=split/,/,$rows[4];
                        my $insf=0; my $delf=0; my $snvf=0;
                        for my $i(@alts){
                                if(length($rows[3])<length($i)){
                                        $insf++;
                                }elsif(length($rows[3])>length($i)){
                                        $delf++;
                                }else{
                                        $snvf++;
                                }
                        }
                        if($insf==($#alts+1)){
				$varCnt{$tag}{'2'}++;
                        }elsif($delf==($#alts+1)){
				$varCnt{$tag}{'3'}++;
                        }else{
				$varCnt{$tag}{'4'}++;
                        }
                }
        }	
}

sub Fetch_Trio{
        my($tmp)=$_;
        my (@arry)=split/\t/,$tmp;
        my (@label)=split/\:/,$arry[8];
        my (@value)=split/\:/,$arry[9];
	my $ref=$arry[3];
        my $alt=$arry[4];
        my $gt=-2;
#        my $gq=-2;
        for my $i (0..$#label){
                if($label[$i] eq "GT"){
                        $gt=$value[$i];
			$gt=~s/\|/\//g;
			if($gt eq '1/0'){
				$gt='0/1';
			}
                }
#		elsif($label[$i] eq "GQ"){
#                        $gq=$value[$i];
#                }
        }
	return($ref,$alt,$gt);
#        return ($alt,$gt,$gq);
}

exit;
