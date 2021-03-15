#!/bin/sh
#
#$ -N repsnv_fetch
#$ -S /bin/bash
#$ -cwd
#$ -j y
#$ -pe hostcore 1 
#$ -R y
#$ -o /dev/ngs005/scratch/hhong/rep_repro_analysis/CQ/17_snvGT-CS_1119/vcf_Fetch1.replab.log

## set path
export JAVA_HOME=/storage2/bgong/tools/jdk1.8.0_91 # JAVA version (build 1.8.0_91-b14)
export ztools=/storage2/zliu/bin
export bedtools=/dev/ngs002/hhong/bin/bedtools

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
export mybin=$bedtools:$JAVA_HOME/bin:$ztools/bowtie2-2.2.9:$ztools/GATK3.7:$ztools/bcftools-1.3.1:$ztools/samtools-1.3.1:$ztools/SNVer-0.5.3:$ztools/isaac_variant_caller-1.0.7/etc:$ztools/isaac_variant_caller-1.0.7/bin:$ztools/gvcftools-0.14/bin
export PATH=$mybin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:$PATH



beddir=/dev/ngs002/hhong/SEQC2/high_reproBed/CQ/5_FinalreproBed
sourcedir2=/dev/ngs003/bpan/snvNum_stat/CQ/9_2median_RGFfilter_0502
sdfdir=/dev/ngs004/hhong/CQ/hg38
sourcedir=/dev/ngs004/hhong/CQ/ChineseQuartet_to_hg38/8_BEDfilt_CQ/2_bedtoolsMrg
outdir=/dev/ngs005/scratch/hhong/rep_repro_analysis/CQ/17_snvGT-CS_1119/3_bedtools_repOut
labMrgOut=/dev/ngs005/scratch/hhong/rep_repro_analysis/CQ/17_snvGT-CS_1119/4_bedtools_labMrg
labMrgFetch=/dev/ngs005/scratch/hhong/rep_repro_analysis/CQ/17_snvGT-CS_1119/5_bedtools_labOut
##Command Example: qsub rtg_vcffilter.sh Bowtie2 HC ARD LCL5 
##Four input: aligner caller Lab sample
#for aligner in Bowtie2 BWA ISAAC stampy;do
#for caller in HC ISAAC FreeBayes Samtools Varscan SNVer;do
#for caller in FreeBayes; do
#mkdir $outdir/$1'_'$2
#for name in ARD_LCL5_1 ARD_LCL5_2 ARD_LCL5_3 ARD_LCL6_1 ARD_LCL6_2 ARD_LCL6_3 ARD_LCL7_1 ARD_LCL7_2 ARD_LCL7_3 ARD_LCL8_1 ARD_LCL8_2 ARD_LCL8_3 ARD_NIST8398_1 ARD_NIST8398_2 ARD_NIST8398_3 NVG_LCL5_1 NVG_LCL5_2 NVG_LCL5_3 NVG_LCL6_1 NVG_LCL6_2 NVG_LCL6_3 NVG_LCL7_1 NVG_LCL7_2 NVG_LCL7_3 NVG_LCL8_1 NVG_LCL8_2 NVG_LCL8_3 WUX_LCL5_1 WUX_LCL5_2 WUX_LCL5_3 WUX_LCL6_1 WUX_LCL6_2 WUX_LCL6_3 WUX_LCL7_1 WUX_LCL7_2 WUX_LCL7_3 WUX_LCL8_1 WUX_LCL8_2 WUX_LCL8_3;do
#for name in ARD_LCL5 ARD_LCL6 ARD_LCL7 ARD_LCL8 ARD_NIST8398 NVG_LCL5 NVG_LCL6 NVG_LCL7 NVG_LCL8 WUX_LCL5 WUX_LCL6 WUX_LCL7 WUX_LCL8; do
#Bowtie2 GATK    FreeBayes       ARD     LCL7    Q1      T2
#Bowtie2 GATK    HC      ARD     LCL5    Q1      T2
#mkdir $outdir/"$1"_"$2"/temp
tempdir=$outdir/"$1"_"$2"/temp

ref=/dev/ngs004/hhong/CQ/hg38/hg38.fa

perl $outdir/replicateVcfFetch_vcfV.noGATK.update1120.pl $sourcedir/"$1"_"$2"/ARD_"$3"_repMrg.txt $3 ARD $1 $2 

perl /dev/ngs001/bpan/bin/GIAB_bin/vcfsorter.pl /dev/ngs004/hhong/CQ/hg38/hg38.dict $outdir/"$1"_"$2"/ARD_"$3"_3repCS.vcf >$outdir/"$1"_"$2"/ARD_"$3"_3repCS.sort.vcf
#done
#done
#done
