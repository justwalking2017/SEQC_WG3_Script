#!/bin/sh
#
#$ -N fastqc_CQ
#$ -S /bin/bash
#$ -cwd
#$ -j y
#$ -pe multicore 1
#$ -R y
#$ -o /dev/ngs001/bpan/seqc_QC/CQ_QC/run.log

export mybin=/dev/ngs001/tchen/bin/FastQC/
export PATH=$mybin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:$PATH
outdir=/dev/ngs001/bpan/seqc_QC/CQ_QC
sourcedir1=/dev/ngs004/hhong/CQ/data/Quartet/DNA/20170403_DNA_ILM_ARD
sourcedir2=/dev/ngs004/hhong/CQ/data/Quartet/DNA/20170329_DNA_ILM_NVG
sourcedir3=/dev/ngs004/hhong/CQ/data/Quartet/DNA/20170216_DNA_ILM_WUX
#for aligner in Bowtie2 BWA ISAAC mosaik stampy;do
#for caller in HC ISAAC FreeBayes Samtools Varscan;do
#mkdir $outdir/$aligner'_'$caller
#mkdir $outdir/$aligner'_GATK_'$caller
#for name in ARD_LCL5_1 ARD_LCL5_2 ARD_LCL5_3 ARD_LCL6_1 ARD_LCL6_2 ARD_LCL6_3 ARD_LCL7_1 ARD_LCL7_2 ARD_LCL7_3 ARD_LCL8_1 ARD_LCL8_2 ARD_LCL8_3 ARD_NIST8398_1 ARD_NIST8398_2 ARD_NIST8398_3 NVG_LCL5_1 NVG_LCL5_2 NVG_LCL5_3 NVG_LCL6_1 NVG_LCL6_2 NVG_LCL6_3 NVG_LCL7_1 NVG_LCL7_2 NVG_LCL7_3 NVG_LCL8_1 NVG_LCL8_2 NVG_LCL8_3 WUX_LCL5_1 WUX_LCL5_2 WUX_LCL5_3 WUX_LCL6_1 WUX_LCL6_2 WUX_LCL6_3 WUX_LCL7_1 WUX_LCL7_2 WUX_LCL7_3 WUX_LCL8_1 WUX_LCL8_2 WUX_LCL8_3;do
#bcftools query -f '%CHROM %POS %ALT %QUAL [ %DP] [ %GT]\n' $sourcedir/$aligner'_'$caller/$1.snv.recode.vcf >$outdir/$aligner'_'$caller/$1.snv.recode.txt
#bcftools query -f '%CHROM %POS %ALT %QUAL [ %DP] [ %GT]\n' $sourcedir/$aligner'_GATK_'$caller/$1.snv.recode.vcf >$outdir/$aligner'_GATK_'$caller/$1.snv.recode.txt
#grep -E '0/1|1/1|1/2' $outdir/$aligner'_'$caller/$1.snv.recode.txt | sed 's/chr//g;s/X/23/g;s/Y/24/g;s/A/1/g;s/T/2/g;s/C/3/g;s/G/4/g;s/0\/1/10/g;s/1\/1/12/g;s/1\/2/13/g' | awk '{print $1"\t"$2"\t"$3"\t"$5}' >$outdir/$aligner'_'$caller/simply_$1.snv.recode.txt
#grep -E '0/1|1/1|1/2' $outdir/$aligner'_GATK_'$caller/$1.snv.recode.txt | sed 's/chr//g;s/X/23/g;s/Y/24/g;s/A/1/g;s/T/2/g;s/C/3/g;s/G/4/g;s/0\/1/10/g;s/1\/1/12/g;s/1\/2/13/g'| awk '{print $1"\t"$2"\t"$3"\t"$5}'  >$outdir/$aligner'_GATK_'$caller/simply_$1.snv.recode.txt
#grep -E '0/1|1/1|1/2' $outdir/$aligner'_'$caller/$1.snv.recode.txt | awk '{print $1"\t"$2"\t"$3"\t"$5}'  | sed 's/chr//g;s/X/23/g;s/Y/24/g;s/A/1/g;s/T/2/g;s/C/3/g;s/G/4/g;s/0\/1/10/g;s/1\/1/12/g;s/1\/2/13/g;s/,//g' | grep -v "\." >$outdir/$aligner'_'$caller/simply_$1.snv.recode.txt
#grep -E '0/1|1/1|1/2' $outdir/$aligner'_GATK_'$caller/$1.snv.recode.txt | awk '{print $1"\t"$2"\t"$3"\t"$5}'  | sed 's/chr//g;s/X/23/g;s/Y/24/g;s/A/1/g;s/T/2/g;s/C/3/g;s/G/4/g;s/0\/1/10/g;s/1\/1/12/g;s/1\/2/13/g;s/,//g' | grep -v "\." >$outdir/$aligner'_GATK_'$caller/simply_$1.snv.recode.txt

fastqc -q  $sourcedir1/Quartet_DNA_ILM_"$1"_20170403_R1.fastq.gz -o $outdir
fastqc -q  $sourcedir1/Quartet_DNA_ILM_"$1"_20170403_R2.fastq.gz -o $outdir

fastqc -q  $sourcedir2/Quartet_DNA_ILM_"$1"_20170329_R1.fastq.gz -o $outdir
fastqc -q  $sourcedir2/Quartet_DNA_ILM_"$1"_20170329_R2.fastq.gz -o $outdir

fastqc -q  $sourcedir3/Quartet_DNA_ILM_"$1"_20170216_R1.fastq.gz -o $outdir
fastqc -q  $sourcedir3/Quartet_DNA_ILM_"$1"_20170216_R2.fastq.gz -o $outdir

#done
#done
#done
