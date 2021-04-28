#! /usr/bin/perl

use strict;
use warnings;

#die "perl $0 <chr_range> <CS_VCF> <noCS_bed> <bench_bed> <export>" if($#ARGV!=4);
die "perl $0 <chr_range> <CS_VCF> <noCS_bed>  <export>" if($#ARGV!=3);

#my($chrRg, $CSFile, $noCSFile, $benbed, $export)=@ARGV;
my($chrRg, $CSFile, $noCSFile,$export)=@ARGV;


my %lenChr=();
open(CHRFIL, $chrRg) || die "$!";
while(<CHRFIL>){
	chomp;
	my(@ar)=split/\t/,$_;
	$lenChr{$ar[0]}=$ar[1];
}
close CHRFIL;

my %freqH=();
my $flg=0;
open(FQFILE,$CSFile) || die"$!";
while(<FQFILE>){
	chomp;
#chr1    66507   66508
#chr1    74681   74682
	next if ($_=~/^#/);
	$flg++;
	my(@arry)=split/\t/,$_;
#	for my $i($arry[1]..$arry[2]){
	for my $i(($arry[1]-1)..($arry[1]-1+length($arry[3]))){
		$freqH{$arry[0]}{$i}=$flg;
	}
#	$freqH{$arry[0]}{$arry[1]}=();
#	$freqH{$arry[0]}{$arry[2]}=();
}
close FQFILE;

my %DSbed=();
#my %cntF=();
open(VARFILE,$noCSFile) || die"$!";
open(EXPORT,">$export") || die "$!";
open(EXPORS,">$export".".LRcutL.txt") || die "$!";
print EXPORS "Chr\tL_Pos\tR_Pos\tLeft_cut\tRight_cut\tCSvar_num\n";
while(<VARFILE>){
	chomp;
	my $LP=0; my $RP=0; my %cntF=();
	my(@arry2)=split/\t/,$_;
	my $sk=0;
	for my $xx($arry2[1]..$arry2[2]){
		if(exists $freqH{$arry2[0]}{$xx}){
			$sk=1;
		}
	}
	next if ($sk==1);
	for my $lp(($arry2[1]-100)..$arry2[1]){
		if(exists $freqH{$arry2[0]}{$lp}){
			$LP=$lp;
			$cntF{$freqH{$arry2[0]}{$lp}}=();
		}
	}
	for (my $rp=($arry2[2]+100);$rp >= $arry2[2];$rp--){
		if(exists $freqH{$arry2[0]}{$rp}){
			$RP=$rp;
			$cntF{$freqH{$arry2[0]}{$rp}}=();
		}
	}
#	print EXPORT $LP."\t".$RP."\n";
	my $nLP=0; my $nRP=0;
	if($LP>0){
		$nLP=$arry2[1]-int(($arry2[1]-$LP)/2);
	}else{	
		if($arry2[1]>50){
			$nLP=$arry2[1]-50;
		}else{
			$nLP=0;
		}
	}
	if($RP>0){
		$nRP=$arry2[2]+int(($RP-$arry2[2])/2);
	}else{
		if($arry2[2]<($lenChr{$arry2[0]}-50)){
			$nRP=$arry2[2]+50;
		}else{
			$nRP=$lenChr{$arry2[0]};
		}
	}
#	print scalar (keys %cntF)."\n";
#	print scalar (%cntF)."\n";
#	exit;
#	next if($arry2[2]==$nRP);
	$DSbed{$arry2[0]}{$nLP}=$nRP;
	print EXPORT $arry2[0]."\t".$nLP."\t".$nRP."\n";
	print EXPORS $arry2[0]."\t".$arry2[1]."\t".$arry2[2]."\t".int($arry2[1]-$nLP)."\t".int($nRP-$arry2[2])."\t".scalar(keys %cntF)."\n";
}
close VARFILE;
close EXPORT;
close EXPORS;
#open(BENBED, $benbed) || die "$!";
#while(<BENBED>){
#	chomp;
#	my(@arry3)=split/\t/,$_;
#	for my $yy($arry3[1]..$arry3[2]){
#		if (exists $DSbed{$arry3[0]}{$yy}){
#			if(){

#			}	
#		}
#	}
#}
#close BENBED;
exit;
