#!/bin/sh
#
#$ -N alignments_combination
#$ -S /bin/bash
#$ -cwd
#$ -j y
#$ -pe hostcore 4
#$ -R y
#$ -o /dev/ngs005/scratch/hhong/rep_repro_analysis/CQ/17_snvGT-CS_1119/7_bedtools_alignOut/align.combination.log

## set path
export JAVA_HOME=/storage2/bgong/tools/jdk1.8.0_91 # JAVA version (build 1.8.0_91-b14)
export ztools=/storage2/zliu/bin

# export tools
export bowtie=$ztools/bowtie2-2.2.9
export PICARD=$ztools/picard-2.7.1/picard.jar
export FreeBayes=$ztools/freebayes
config_file=$ztools/isaac_variant_caller-1.0.7/etc/ivc_config_default_wgs.ini
issac_caller=$ztools/isaac_variant_caller-1.0.7/bin/configureWorkflow.pl
GATK=$ztools/GATK3.7/GenomeAnalysisTK.jar
bcftools=$ztools/bcftools-1.3.1
samtools=$ztools/samtools-1.3.1
VarScan=$ztools/VarScan-2.3.9/VarScan.v2.3.9.jar
SNVer=$ztools/SNVer-0.5.3/SNVerIndividual.jar
export mybin=$JAVA_HOME/bin:$ztools/bowtie2-2.2.9:$ztools/GATK3.7:$ztools/bcftools-1.3.1:$ztools/samtools-1.3.1:$ztools/SNVer-0.5.3:$ztools/isaac_variant_caller-1.0.7/etc:$ztools/isaac_variant_caller-1.0.7/bin:$ztools/gvcftools-0.14/bin
export PATH=$mybin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:$PATH



beddir=/dev/ngs002/hhong/SEQC2/high_reproBed/CQ/5_FinalreproBed
sourcedir2=/dev/ngs003/bpan/snvNum_stat/CQ/9_2median_RGFfilter_0502
sdfdir=/dev/ngs004/hhong/CQ/hg38
sourcedir=/dev/ngs005/scratch/hhong/rep_repro_analysis/CQ/17_snvGT-CS_1119/6_bedtools_alignerMrg
outdir=/dev/ngs005/scratch/hhong/rep_repro_analysis/CQ/17_snvGT-CS_1119/7_bedtools_alignOut
##Command Example: qsub rtg_vcffilter.sh Bowtie2 HC ARD LCL5
##Four input: aligner caller Lab sample

#Bowtie2 GATK    FreeBayes       ARD     LCL7    Q1      T2
#Bowtie2 GATK    HC      ARD     LCL5    Q1      T2
#mkdir $outdir/"$1"_GATK_"$2"/temp
#tempdir=$outdir/"$1"_GATK_"$2"/temp

ref=/dev/ngs004/hhong/CQ/hg38/hg38.fa
#Bowtie2_GATK_FreeBayes_labMrg_repMrg.txt
#LCL6_ISAAC_alignerMrg_labMrg_repMrg.txt
#LCL7_ISAAC_8alignCS_3labCS_3repCS.vcf
#perl $outdir/alignVcfFetch_vcfV.update1129.pl $sourcedir/"$1"_"$2"_alignerMrg_labMrg_repMrg.txt $1 $2
perl $outdir/alignVcfFetch_vcfV.update1203.v3.pl $sourcedir/"$1"_"$2"_alignerMrg_labMrg_repMrg.txt $1 $2
perl /dev/ngs001/bpan/bin/GIAB_bin/vcfsorter.pl /dev/ngs004/hhong/CQ/hg38/hg38.dict $outdir/"$1"_"$2"_8alignCS_3labCS_3repCS.vcf >$outdir/"$1"_"$2"_8alignCS_3labCS_3repCS.sort.vcf

