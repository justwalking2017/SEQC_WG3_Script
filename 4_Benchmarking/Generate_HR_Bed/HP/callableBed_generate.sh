#!/bin/sh
#
#$ -N pro_hpbed 
#$ -S /bin/bash
#$ -cwd
#$ -j y
#$ -pe hostcore 4
#$ -R y
#$ -o /dev/ngs002/hhong/SEQC2/high_reproBed/HP/callableBed_generate.log

# datasets
sample=A01
#sourcedir=/dev/ngs004/hhong/GIAB/3_calling

## set path
export JAVA_HOME=/storage2/bgong/tools/jdk1.8.0_91 # JAVA version (build 1.8.0_91-b14)
#export ztools=/storage2/hye/bin
export ztools=/storage2/zliu/bin
# export tools
GATK=$ztools/GATK3.7/GenomeAnalysisTK.jar
bedtools=$ztools/bedtools2/bin
export mybin=$bedtools:$JAVA_HOME/bin:$ztools/bamtools/bin/bamtools
export PATH=$mybin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:$PATH
# create tempdir for middle results
# bam stat
#for name in Bowtie2 Bowtie2_hg37 BWA BWA_hg37;do
#for caller in HC ISAAC FreeBayes Samtools Varscan;do
#mkdir $outdir/$aligner'_'$caller
#mkdir $outdir/$aligner'_GATK_'$caller
#for name in A01 A02 B01 C01 D01 E01 F01 G01 H01;do
#for chrName in chr1 chr2 chr3 chr4 chr5 chr6 chr7 chr8 chr9 chr10 chr11 chr12 chr13 chr14 chr15 chr16 chr17 chr18 chr19 chr20 chr21 chr22 chrX; do
##A01.ISAAC.GATK.raw.vcf
#mkdir /dev/ngs004/hhong/GIAB/3_calling/bedtoolsCovOut/"$1"
sourcedir=/dev/ngs002/hhong/SEQC2/HapMap_to_hg38/3_Alignment_bamFile
#mkdir /dev/ngs004/hhong/GIAB/3_calling/bedtoolsCovOut/"$1"/"$2"/GATK
#outdir1=/dev/ngs004/hhong/GIAB/3_calling/bedtoolsCovOut/"$1"/"$2"/GATK
outdir=/dev/ngs002/hhong/SEQC2/high_reproBed/HP/1_originalBed
cd $outdir
# bam stat
ref=/dev/ngs004/hhong/CQ/hg38/hg38.fa
echo callableLoci start at time && echo "`date`"
java -jar $GATK \
     -T CallableLoci \
     -R $ref \
     -I $sourcedir/$1/$2.aln.sorted.dedup.realigned.recal.bam \
     -summary $outdir/"$1"_"$2".GATK.table.txt \
     -mmq 20 \
     -minDepth 8 \
     -maxDepth 360 \
     -o $outdir/"$1"_"$2".GATK.callable_status.bed
echo callableLoci stop at time && echo "`date`"

echo callableLoci2 start at time && echo "`date`"
java -jar $GATK \
     -T CallableLoci \
     -R $ref \
     -I $sourcedir/$1/$2.aln.sorted.dup.RG.bam \
     -summary $outdir/"$1"_"$2".noGATK.table.txt \
     -mmq 20 \
     -minDepth 8 \
     -maxDepth 360 \
     -o $outdir/"$1"_"$2".noGATK.callable_status.bed
echo callableLoci2 stop at time && echo "`date`"


