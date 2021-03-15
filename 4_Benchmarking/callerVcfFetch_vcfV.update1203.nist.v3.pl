#! /usr/bin/perl

use strict;
use warnings;

die "perl $0 <pos_file> <sample> " if(@ARGV!=2);

my($posFile, $sample)=@ARGV;

##12/03/2018
#"remove Indel discordant with >6 concordant SNV" to 
#"remove Indel discordant with  SNV"
#
my %varCnt=(); my %csH=();
my %freqH11=(); my %freqH10=(); my %freqH21=();my %freqH20=(); my %freqH30=();
my %freqH40=(); my %freqH50=(); my %freqH60=();my %freqH70=(); my %freqH80=();
open(FQFILE,$posFile) || die"$!";
while(<FQFILE>){
        chomp;
        my(@arry)=split/\t/,$_;
	for my $i(($arry[1]+1)..$arry[2]){
#		print $i."\n";exit;
 		if(($arry[4]=~/1/) and (length($arry[4])>12)){
#			print $i."\n";exit;
	       		$freqH11{$arry[0]}{$i}=();
			$csH{$arry[0]}{$i}=();
		}elsif(($arry[4]!~/1/) and (length($arry[4])>12)){
			$freqH21{$arry[0]}{$i}=();
			$csH{$arry[0]}{$i}=();
		}elsif($arry[4]=~/1/){
			$freqH10{$arry[0]}{$i}=();
		}elsif($arry[4]=~/2/){
			$freqH20{$arry[0]}{$i}=();
		}elsif($arry[4]=~/3/){
			$freqH30{$arry[0]}{$i}=();
		}elsif($arry[4]=~/4/){
			$freqH40{$arry[0]}{$i}=();
		}elsif($arry[4]=~/5/){
                        $freqH50{$arry[0]}{$i}=();
                }elsif($arry[4]=~/6/){
                        $freqH60{$arry[0]}{$i}=();
                }elsif($arry[4]=~/7/){
                        $freqH70{$arry[0]}{$i}=();
                }elsif($arry[4]=~/8/){
                        $freqH80{$arry[0]}{$i}=();
		}
	}
}
close FQFILE;

#print scalar(keys %{$freqH10{'chr1'}})."\n";exit;

#foreach my $k (sort {$a<=>$b} keys %{$freqH10{'chr1'}}){
#	print $k ."\n";
#}
#exit;
my $sourdir='/dev/ngs005/scratch/hhong/rep_repro_analysis/CQ/17_snvGT-CS_1119/7_bedtools_alignOut';
#LCL5_Bowtie2_FreeBayes_3repCS.sort.vcf

my $varFile1=$sourdir.'/'.$sample.'_HC_8alignCS_3repCS.sort.vcf';
my $varFile2=$sourdir.'/'.$sample.'_sentieon_3repCS.sort.vcf';
my $varFile3=$sourdir.'/'.$sample.'_FreeBayes_8alignCS_3repCS.sort.vcf';
my $varFile4=$sourdir.'/'.$sample.'_Samtools_8alignCS_3repCS.sort.vcf';
my $varFile5=$sourdir.'/'.$sample.'_SNVer_8alignCS_3repCS.sort.vcf';
my $varFile6=$sourdir.'/'.$sample.'_Varscan_8alignCS_3repCS.sort.vcf';
my $varFile7=$sourdir.'/'.$sample.'_RTG_3repCS.sort.vcf';
my $varFile8=$sourdir.'/'.$sample.'_ISAAC_8alignCS_3repCS.sort.vcf';

my $outdir='/dev/ngs005/scratch/hhong/rep_repro_analysis/CQ/17_snvGT-CS_1119/8_bedtools_allInOneMrg';
my $export1=$outdir.'/'.$sample.'_8callerCS_8alignCS_3repCS.vcf';
my $export2=$outdir.'/'.$sample.'_8callerCS.noCS.vcf';
my $export3=$outdir.'/'.$sample.'_8callerCS.stat.txt';

#my %H1=(); my %H2=(); my %H3=(); my %H4=();
#my %H5=(); my %H6=(); my %H7=(); my %H8=();

my %recH=();
my %cpH1=();
my $cnt1=0;
open(VARFIL, $varFile1) || die "$!";
while(<VARFIL>){
        chomp;
        next if $_=~/^#/;
        my(@arry)=split/\t/,$_;
        my ($ref,$alt,$gt)=Fetch_Trio($_);
	if(exists $csH{$arry[0]}{$arry[1]}){
        	$recH{$arry[0]}{$arry[1]}="$ref"."_"."$alt"."_"."$gt";
		$cpH1{$arry[0]}{$arry[1]}=();
		$cnt1++;
	}
}
close VARFIL;
foreach my $c1(keys %csH){
	foreach my $p1(keys %{$csH{$c1}}){
		next if (exists $cpH1{$c1}{$p1});
		$recH{$c1}{$p1}="0";
	}
}

my %cpH2=();
my $cnt2=0;
open(VARFIL, $varFile2) || die "$!";
while(<VARFIL>){
        chomp;
        next if $_=~/^#/;
        my(@arry)=split/\t/,$_;
        my ($ref,$alt,$gt)=Fetch_Trio($_);
        if(exists $csH{$arry[0]}{$arry[1]}){
                $recH{$arry[0]}{$arry[1]}=$recH{$arry[0]}{$arry[1]}."\t"."$ref"."_"."$alt"."_"."$gt";
                $cpH2{$arry[0]}{$arry[1]}=();
		$cnt2++;
        }
}
close VARFIL;
foreach my $c2(keys %csH){
        foreach my $p2(keys %{$csH{$c2}}){
		next if (exists $cpH2{$c2}{$p2});
                $recH{$c2}{$p2}=$recH{$c2}{$p2}."\t0";
        }
}

my $cnt3=0;
my %cpH3=();
open(VARFIL, $varFile3) || die "$!";
while(<VARFIL>){
        chomp;
        next if $_=~/^#/;
        my(@arry)=split/\t/,$_;
        my ($ref,$alt,$gt)=Fetch_Trio($_);
        if(exists $csH{$arry[0]}{$arry[1]}){
                $recH{$arry[0]}{$arry[1]}=$recH{$arry[0]}{$arry[1]}."\t"."$ref"."_"."$alt"."_"."$gt";
                $cpH3{$arry[0]}{$arry[1]}=();
		$cnt3++;
        }
}
close VARFIL;
foreach my $c3(keys %csH){
        foreach my $p3(keys %{$csH{$c3}}){
		next if (exists $cpH3{$c3}{$p3});
                $recH{$c3}{$p3}=$recH{$c3}{$p3}."\t0";
        }
}

my $cnt4=0;
my %cpH4=();
open(VARFIL, $varFile4) || die "$!";
while(<VARFIL>){
        chomp;
        next if $_=~/^#/;
        my(@arry)=split/\t/,$_;
        my ($ref,$alt,$gt)=Fetch_Trio($_);
        if(exists $csH{$arry[0]}{$arry[1]}){
                $recH{$arry[0]}{$arry[1]}=$recH{$arry[0]}{$arry[1]}."\t"."$ref"."_"."$alt"."_"."$gt";
                $cpH4{$arry[0]}{$arry[1]}=();
		$cnt4++;
        }
}
close VARFIL;
foreach my $c4(keys %csH){
        foreach my $p4(keys %{$csH{$c4}}){
		next if (exists $cpH4{$c4}{$p4}); 
               $recH{$c4}{$p4}=$recH{$c4}{$p4}."\t0";
        }
}

my %cpH5=();
my $cnt5=0;
open(VARFIL, $varFile5) || die "$!";
while(<VARFIL>){
        chomp;
        next if $_=~/^#/;
        my(@arry)=split/\t/,$_;
        my ($ref,$alt,$gt)=Fetch_Trio($_);
        if(exists $csH{$arry[0]}{$arry[1]}){
                $recH{$arry[0]}{$arry[1]}=$recH{$arry[0]}{$arry[1]}."\t"."$ref"."_"."$alt"."_"."$gt";
                $cpH5{$arry[0]}{$arry[1]}=();
		$cnt5++;
        }
}
close VARFIL;
foreach my $c5(keys %csH){
        foreach my $p5(keys %{$csH{$c5}}){
		next if (exists $cpH5{$c5}{$p5});
                $recH{$c5}{$p5}=$recH{$c5}{$p5}."\t0";
        }
}

my %cpH6=();
my $cnt6=0;
open(VARFIL, $varFile6) || die "$!";
while(<VARFIL>){
        chomp;
        next if $_=~/^#/;
        my(@arry)=split/\t/,$_;
        my ($ref,$alt,$gt)=Fetch_Trio($_);
        if(exists $csH{$arry[0]}{$arry[1]}){
                $recH{$arry[0]}{$arry[1]}=$recH{$arry[0]}{$arry[1]}."\t"."$ref"."_"."$alt"."_"."$gt";
                $cpH6{$arry[0]}{$arry[1]}=();
		$cnt6++;
        }
}
close VARFIL;
foreach my $c6(keys %csH){
        foreach my $p6(keys %{$csH{$c6}}){
		next if (exists $cpH6{$c6}{$p6});
                $recH{$c6}{$p6}=$recH{$c6}{$p6}."\t0";
        }
}

my %cpH7=();
my $cnt7=0;
open(VARFIL, $varFile7) || die "$!";
while(<VARFIL>){
        chomp;
        next if $_=~/^#/;
        my(@arry)=split/\t/,$_;
        my ($ref,$alt,$gt)=Fetch_Trio($_);
        if(exists $csH{$arry[0]}{$arry[1]}){
                $recH{$arry[0]}{$arry[1]}=$recH{$arry[0]}{$arry[1]}."\t"."$ref"."_"."$alt"."_"."$gt";
                $cpH7{$arry[0]}{$arry[1]}=();
		$cnt7++;
        }
}
close VARFIL;
foreach my $c7(keys %csH){
        foreach my $p7(keys %{$csH{$c7}}){
		next if (exists $cpH7{$c7}{$p7});
                $recH{$c7}{$p7}=$recH{$c7}{$p7}."\t0";
        }
}

my %cpH8=();
my $cnt8=0;
open(VARFIL, $varFile8) || die "$!";
while(<VARFIL>){
        chomp;
        next if $_=~/^#/;
        my(@arry)=split/\t/,$_;
        my ($ref,$alt,$gt)=Fetch_Trio($_);
        if(exists $csH{$arry[0]}{$arry[1]}){
                $recH{$arry[0]}{$arry[1]}=$recH{$arry[0]}{$arry[1]}."\t"."$ref"."_"."$alt"."_"."$gt";
                $cpH8{$arry[0]}{$arry[1]}=();
		$cnt8++;
        }
}
close VARFIL;
foreach my $c8(keys %csH){
        foreach my $p8(keys %{$csH{$c8}}){
		next if (exists $cpH8{$c8}{$p8});
                $recH{$c8}{$p8}=$recH{$c8}{$p8}."\t0";
        }
}

print $cnt1."\t".$cnt2."\t".$cnt3."\t".$cnt4."\t".$cnt5."\t".$cnt6."\t".$cnt7."\t".$cnt8."\n";

my %psH=();  my %snvH=(); my %indlH=();
foreach my $chr(sort keys %recH){
	foreach my $pos(sort {$a<=>$b} keys %{$recH{$chr}}){
		my %maxF=();
		my (@inf)=split/\t/,$recH{$chr}{$pos};
		for my $i(0..$#inf){
			$maxF{$inf[$i]}++;
		}
		my $max=0;my $maxC=();
		foreach my $t(keys %maxF){
			if($maxF{$t}>=$max){
				$max=$maxF{$t};
				$maxC=$t;
			}
		}
		if($maxC ne '0'){
			my(@tInf)=split/\_/,$maxC;
			if((length($tInf[0])==1) and (length($tInf[1])==1)){
				$snvH{$chr}{$pos}=();
			}elsif(length($tInf[0])<length($tInf[1])){
				$indlH{$chr}{$pos}=1;
			}else{
				$indlH{$chr}{$pos}=2;
			}
		}
		if(($max>6) and ($maxC ne '0') ){
			$psH{$chr}{$pos}=$maxC;
			my (@csInf)=split/\_/,$maxC;
#			if((length($csInf[0])==1) and (length($csInf[1])==1)){
#				$snvH{$chr}{$pos}=();
#			}
		}
	#	if(exists $snvH{'chr1'}{'5304019'}){
	#		print $chr."\t".$pos."\t".$max."\t".$maxC."\t".$recH{$chr}{$pos}."\n";
	#	}
	}
}



my %csRec=();
my %csInd=();
open(VARFIL, $varFile1)|| die "$!";
open(EXPORT,">$export1") || die "$!";
open(EXPORN,">$export2") || die "$!";
while(<VARFIL>){
        chomp;
        if($_=~/^##/){
                print EXPORT $_."\n";next;
        }elsif($_=~/^#/){
                print EXPORT "#CHROM\tPOS\tID\tREF\tALT\tQUAL\tFILTER\tINFO\tFORMAT\t".'7alignUp_'."$sample\n";next;

        }
        my(@arry1)=split/\t/,$_;
       if((length($arry1[3])>1) or (length($arry1[4])>1)){
                my $flg=0; my $ocp=0;my $tF=0;
		if(length($arry1[3])>length($arry1[4])){
			$tF=2;			
		}elsif(length($arry1[3])<length($arry1[4])){
			$tF=1;
		}
		if($indlH{$arry1[0]}{$arry1[1]}==$tF ){		 
                   for my $tt($arry1[1]..($arry1[1]+length($arry1[3])-1)){
                        if(exists $freqH11{$arry1[0]}{$tt}){
                                $flg=1;
                        }
                        if(exists $snvH{$arry1[0]}{$tt}){
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
                if(exists $psH{$arry1[0]}{$arry1[1]}){
                        if($psH{$arry1[0]}{$arry1[1]} eq $info){
                                print EXPORT $_."\n";
				varJdg(1,$_);
				$csRec{$arry1[0]}{$arry1[1]}=();
			}else{
				$freqH21{$arry1[0]}{$arry1[1]}=();
			}
		}else{
			print EXPORN $arry1[0]."\t".$arry1[1]."\t$arry1[3]\t$arry1[4]\n";
			varJdg(0,$_);	
		}
	}else{
                print EXPORN $arry1[0]."\t".$arry1[1]."\t$arry1[3]\t$arry1[4]\n";
                varJdg(0,$_);
        }
}
close VARFIL;

open(VARFIL, $varFile2)|| die "$!";
while(<VARFIL>){
        chomp;
        next if ($_=~/^#/);
        my(@arry2)=split/\t/,$_;
        if((length($arry2[3])>1) or (length($arry2[4])>1)){
#	if(length($arry2[3])>1){	
                my $flg=0; my $ind=0; my $ocp=0;my $tF=0;
                if(length($arry2[3])>length($arry2[4])){
                        $tF=2;
                }elsif(length($arry2[3])<length($arry2[4])){
                        $tF=1;
                }
		if($indlH{$arry2[0]}{$arry2[1]}==$tF ){
                   for my $tt($arry2[1]..($arry2[1]+length($arry2[3])-1)){
                        if(exists $freqH11{$arry2[0]}{$tt}){
                                $ind=1;
                        }
                        if(exists $freqH21{$arry2[0]}{$tt}){
                                $flg=1;
                        }
                        if(exists $snvH{$arry2[0]}{$tt}){
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
		}else{
			print EXPORN $arry2[0]."\t".$arry2[1]."\t$arry2[3]\t$arry2[4]\n";
                        varJdg(0,$_);
		}
        }elsif(exists $freqH20{$arry2[0]}{$arry2[1]}){
                print EXPORN $arry2[0]."\t".$arry2[1]."\t$arry2[3]\t$arry2[4]\n";
                varJdg(0,$_);
        }elsif(exists $csRec{$arry2[0]}{$arry2[1]}){
                next;
        }elsif(exists $freqH21{$arry2[0]}{$arry2[1]}){
                my ($ref,$alt,$gt)=Fetch_Trio($_);
                my $info="$ref"."_"."$alt"."_"."$gt";
                if(exists $psH{$arry2[0]}{$arry2[1]}){
                        if($psH{$arry2[0]}{$arry2[1]} eq $info){
                                print EXPORT $_."\n";
				varJdg(1,$_);
                                $csRec{$arry2[0]}{$arry2[1]}=();
                        }else{
                                print "Warning: PASS cutoff Discordant in Two sample:\n$_\n";
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
close VARFIL;

open(VARFIL, $varFile3)|| die "$!";
while(<VARFIL>){
        chomp;
        next if ($_=~/^#/);
        my(@arry3)=split/\t/,$_;
        if((length($arry3[3])>1) or (length($arry3[4])>1)){
#	if(length($arry3[3])>length($arry3[4])){
                my $flg=0; my $ind=0; my $ocp=0;
                for my $tt($arry3[1]..($arry3[1]+length($arry3[3])-1)){
                        if(exists $freqH11{$arry3[0]}{$tt}){
                                $ind=1;
                        }
                        if(exists $freqH21{$arry3[0]}{$tt}){
                                $flg=1;
                        }
                        if(exists $snvH{$arry3[0]}{$tt}){
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
}
close VARFIL;

open(VARFIL, $varFile4)|| die "$!";
while(<VARFIL>){
        chomp;
        next if ($_=~/^#/);
        my(@arry4)=split/\t/,$_;
        if((length($arry4[3])>1) or (length($arry4[4])>1)){
#	if(length($arry4[3])>length($arry4[4])){
                my $flg=0; my $ind=0; my $ocp=0;
                for my $tt($arry4[1]..($arry4[1]+length($arry4[3])-1)){
                        if(exists $freqH11{$arry4[0]}{$tt}){
                                $ind=1;
                        }
                        if(exists $freqH21{$arry4[0]}{$tt}){
                                $flg=1;
                        }
                        if(exists $snvH{$arry4[0]}{$tt}){
                                $ocp=1;
                        }
                }
                if ($ind==0 and $flg==0){
                        print EXPORN $arry4[0]."\t".$arry4[1]."\t$arry4[3]\t$arry4[4]\n";
                        varJdg(0,$_);
                }
        }elsif(exists $freqH30{$arry4[0]}{$arry4[1]}){
                print EXPORN $arry4[0]."\t".$arry4[1]."\t$arry4[3]\t$arry4[4]\n";
                varJdg(0,$_);
        }elsif(exists $csRec{$arry4[0]}{$arry4[1]}){
                next;
        }else{
                print EXPORN $arry4[0]."\t".$arry4[1]."\t$arry4[3]\t$arry4[4]\n";
                varJdg(0,$_);
        }
}
close VARFIL;

open(VARFIL, $varFile5)|| die "$!";
while(<VARFIL>){
        chomp;
        next if ($_=~/^#/);
        my(@arry5)=split/\t/,$_;
        if((length($arry5[3])>1) or (length($arry5[4])>1)){
#	if(length($arry5[3])>1){
                my $flg=0; my $ind=0; my $ocp=0;
                for my $tt($arry5[1]..($arry5[1]+length($arry5[3])-1)){
                        if(exists $freqH11{$arry5[0]}{$tt}){
                                $ind=1;
                        }
                        if(exists $freqH21{$arry5[0]}{$tt}){
                                $flg=1;
                        }
                        if(exists $snvH{$arry5[0]}{$tt}){
                                $ocp=1;
                        }
                }
                if ($ind==0 and $flg==0){
                        print EXPORN $arry5[0]."\t".$arry5[1]."\t$arry5[3]\t$arry5[4]\n";
                        varJdg(0,$_);
                }
        }elsif(exists $freqH30{$arry5[0]}{$arry5[1]}){
                print EXPORN $arry5[0]."\t".$arry5[1]."\t$arry5[3]\t$arry5[4]\n";
                varJdg(0,$_);
        }elsif(exists $csRec{$arry5[0]}{$arry5[1]}){
                next;
        }else{
                print EXPORN $arry5[0]."\t".$arry5[1]."\t$arry5[3]\t$arry5[4]\n";
                varJdg(0,$_);
        }
}
close VARFIL;

open(VARFIL, $varFile6)|| die "$!";
while(<VARFIL>){
        chomp;
        next if ($_=~/^#/);
        my(@arry6)=split/\t/,$_;
        if((length($arry6[3])>1) or (length($arry6[4])>1)){
#	if(length($arry6[3])>1){
                my $flg=0; my $ind=0; my $ocp=0;
                for my $tt($arry6[1]..($arry6[1]+length($arry6[3])-1)){
                        if(exists $freqH11{$arry6[0]}{$tt}){
                                $ind=1;
                        }
                        if(exists $freqH21{$arry6[0]}{$tt}){
                                $flg=1;
                        }
                        if(exists $snvH{$arry6[0]}{$tt}){
                                $ocp=1;
                        }
                }
                if ($ind==0 and $flg==0){
                        print EXPORN $arry6[0]."\t".$arry6[1]."\t$arry6[3]\t$arry6[4]\n";
                        varJdg(0,$_);
                }
        }elsif(exists $freqH30{$arry6[0]}{$arry6[1]}){
                print EXPORN $arry6[0]."\t".$arry6[1]."\t$arry6[3]\t$arry6[4]\n";
                varJdg(0,$_);
        }elsif(exists $csRec{$arry6[0]}{$arry6[1]}){
                next;
        }else{
                print EXPORN $arry6[0]."\t".$arry6[1]."\t$arry6[3]\t$arry6[4]\n";
                varJdg(0,$_);
        }
}
close VARFIL;

open(VARFIL, $varFile7)|| die "$!";
while(<VARFIL>){
        chomp;
        next if ($_=~/^#/);
        my(@arry7)=split/\t/,$_;
        if((length($arry7[3])>1) or (length($arry7[4])>1)){
#	if(length($arry7[3])>1){
                my $flg=0; my $ind=0; my $ocp=0;
                for my $tt($arry7[1]..($arry7[1]+length($arry7[3])-1)){
                        if(exists $freqH11{$arry7[0]}{$tt}){
                                $ind=1;
                        }
                        if(exists $freqH21{$arry7[0]}{$tt}){
                                $flg=1;
                        }
                        if(exists $snvH{$arry7[0]}{$tt}){
                                $ocp=1;
                        }
                }
                if ($ind==0 and $flg==0){
                        print EXPORN $arry7[0]."\t".$arry7[1]."\t$arry7[3]\t$arry7[4]\n";
                        varJdg(0,$_);
                }
        }elsif(exists $freqH30{$arry7[0]}{$arry7[1]}){
                print EXPORN $arry7[0]."\t".$arry7[1]."\t$arry7[3]\t$arry7[4]\n";
                varJdg(0,$_);
        }elsif(exists $csRec{$arry7[0]}{$arry7[1]}){
                next;
        }else{
                print EXPORN $arry7[0]."\t".$arry7[1]."\t$arry7[3]\t$arry7[4]\n";
                varJdg(0,$_);
        }
}
close VARFIL;

open(VARFIL, $varFile8)|| die "$!";
while(<VARFIL>){
        chomp;
        next if ($_=~/^#/);
        my(@arry8)=split/\t/,$_;
        if((length($arry8[3])>1) or (length($arry8[4])>1)){
#	if(length($arry8[3])>1){
                my $flg=0; my $ind=0; my $ocp=0;
                for my $tt($arry8[1]..($arry8[1]+length($arry8[3])-1)){
                        if(exists $freqH11{$arry8[0]}{$tt}){
                                $ind=1;
                        }
                        if(exists $freqH21{$arry8[0]}{$tt}){
                                $flg=1;
                        }
                        if(exists $snvH{$arry8[0]}{$tt}){
                                $ocp=1;
                        }
                }
                if ($ind==0 and $flg==0){
                        print EXPORN $arry8[0]."\t".$arry8[1]."\t$arry8[3]\t$arry8[4]\n";
                        varJdg(0,$_);
                }
        }elsif(exists $freqH30{$arry8[0]}{$arry8[1]}){
                print EXPORN $arry8[0]."\t".$arry8[1]."\t$arry8[3]\t$arry8[4]\n";
                varJdg(0,$_);
        }elsif(exists $csRec{$arry8[0]}{$arry8[1]}){
                next;
        }else{
                print EXPORN $arry8[0]."\t".$arry8[1]."\t$arry8[3]\t$arry8[4]\n";
                varJdg(0,$_);
        }
}
close VARFIL;
close EXPORT;
close EXPORN;

open(EXPORS,">$export3") || die "$!";
foreach my $k(sort {$a<=>$b} keys %varCnt){
        foreach my $j(1..5){
		if(exists $varCnt{$k}{$j}){
                	print EXPORS $k."\t".$j."\t".$varCnt{$k}{$j}."\n";
		}else{
			print EXPORS $k."\t".$j."\t"."0"."\n";
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
        for my $i (0..$#label){
                if($label[$i] eq "GT"){
                        $gt=$value[$i];
                        $gt=~s/\|/\//g;
                        if($gt eq '1/0'){
                                $gt='0/1';
                        }
                }

        }
        return($ref,$alt,$gt);
}

exit;
