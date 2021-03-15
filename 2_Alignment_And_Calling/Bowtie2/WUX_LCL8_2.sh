#!/bin/sh
#
#$ -N WUX_LCL8_2_bowtie2_aligner
#$ -S /bin/bash
#$ -cwd
#$ -j y
#$ -pe multicore 8
#$ -R y
#$ -o /dev/ngs004/hhong/CQ/wf/Bowtie2/WUX_LCL8_2.log

# datasets
sample=WUX_LCL8_2
F01=/dev/ngs004/hhong/CQ/data/Quartet/DNA/20170216_DNA_ILM_WUX/Quartet_DNA_ILM_WUX_LCL8_2_20170216_R1.fastq.gz
F02=/dev/ngs004/hhong/CQ/data/Quartet/DNA/20170216_DNA_ILM_WUX/Quartet_DNA_ILM_WUX_LCL8_2_20170216_R2.fastq.gz
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

# references genome and index
bowtieindex=/dev/ngs004/hhong/CQ/hg38/Bowtie2/hg38.fasta

# create tempdir for middle results
outdir=/dev/ngs004/hhong/CQ/wf/Bowtie2/WUX_LCL8_2
tempdir=/dev/ngs004/hhong/CQ/wf/Bowtie2/WUX_LCL8_2/tempdir

# ref information
ref=/dev/ngs004/hhong/CQ/hg38/hg38.fa
id_mills=/dev/ngs004/hhong/CQ/hg38/Mills_and_1000G_gold_standard.indels.b38.primary_assembly.vcf
id_1000g=/dev/ngs004/hhong/CQ/hg38/ALL.wgs.1000G_phase3.GRCh38.ncbi_remapper.20150424.shapeit2_indels.vcf
dbsnp=/dev/ngs004/hhong/CQ/hg38/dbsnp_146.hg38.vcf
## SNV calling
# FreeBayes
echo FreeBayes caller start at time && echo "`date`"
$FreeBayes -f $ref -X -u -v $outdir/WUX_LCL8_2.FreeBayes.raw.vcf $outdir/WUX_LCL8_2.aln.sorted.dup.RG.bam
echo FreeBayes caller finish at time && echo "`date`"
#########################
echo FreeBayes caller start at time && echo "`date`"
$FreeBayes -f $ref -X -u -v $outdir/WUX_LCL8_2.FreeBayes.GATK.raw.vcf $outdir/WUX_LCL8_2.aln.sorted.dedup.realigned.recal.bam
