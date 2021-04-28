#!/bin/sh
#
#$ -N snv_cnt
#$ -S /bin/bash
#$ -cwd
#$ -j y
#$ -pe hostcore 4
#$ -R y
#$ -o /dev/ngs002/hhong/SEQC2/high_reproBed/HP/all27merge_run.log

export mybin=/dev/ngs001/bpan/bin/bedtools2/bin
export PATH=$mybin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:$PATH
sourcedir=/dev/ngs002/hhong/SEQC2/high_reproBed/HP/2_callableBed
outdir=/dev/ngs002/hhong/SEQC2/high_reproBed/HP/4_mrgAllbedsOneTime
#for aligner in Bowtie2 BWA ISAAC stampy;do
#for caller in HC ISAAC FreeBayes Samtools Varscan SNVer;do
#for caller in FreeBayes; do
#mkdir $outdir/$aligner'_'$caller
#mkdir $outdir/$aligner'_GATK_'$caller
#for name in A ARD_LCL6 ARD_LCL7 ARD_LCL8 A NVG_NIST8398 NVG_LCL6 NVG_LCL7 NVG_LCL8 WUX_NIST8398 WUX_LCL6 WUX_LCL7 WUX_LCL8; do
bedtools multiinter -i $sourcedir/Bowtie2_C_1.GATK.callable_status.bed	\
$sourcedir/Bowtie2_C_1.noGATK.callable_status.bed	\
$sourcedir/Bowtie2_C_2.GATK.callable_status.bed	\
$sourcedir/Bowtie2_C_2.noGATK.callable_status.bed	\
$sourcedir/Bowtie2_C_3.GATK.callable_status.bed	\
$sourcedir/Bowtie2_C_3.noGATK.callable_status.bed	\
$sourcedir/BWA_C_1.GATK.callable_status.bed	\
$sourcedir/BWA_C_1.noGATK.callable_status.bed	\
$sourcedir/BWA_C_2.GATK.callable_status.bed	\
$sourcedir/BWA_C_2.noGATK.callable_status.bed	\
$sourcedir/BWA_C_3.GATK.callable_status.bed	\
$sourcedir/BWA_C_3.noGATK.callable_status.bed	\
$sourcedir/ISAAC_C_1.GATK.callable_status.bed	\
$sourcedir/ISAAC_C_1.noGATK.callable_status.bed	\
$sourcedir/ISAAC_C_2.GATK.callable_status.bed	\
$sourcedir/ISAAC_C_2.noGATK.callable_status.bed	\
$sourcedir/ISAAC_C_3.GATK.callable_status.bed	\
$sourcedir/ISAAC_C_3.noGATK.callable_status.bed	\
$sourcedir/RTG_C_1.noGATK.callable_status.bed	\
$sourcedir/RTG_C_2.noGATK.callable_status.bed	\
$sourcedir/RTG_C_3.noGATK.callable_status.bed	\
$sourcedir/stampy_C_1.GATK.callable_status.bed	\
$sourcedir/stampy_C_1.noGATK.callable_status.bed	\
$sourcedir/stampy_C_2.GATK.callable_status.bed	\
$sourcedir/stampy_C_2.noGATK.callable_status.bed	\
$sourcedir/stampy_C_3.GATK.callable_status.bed	\
$sourcedir/stampy_C_3.noGATK.callable_status.bed >$outdir/bedmulinter_C.all27tabl.txt 
	
