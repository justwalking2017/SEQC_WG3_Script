#!/bin/sh
#
#$ -N snv_cnt
#$ -S /bin/bash
#$ -cwd
#$ -j y
#$ -pe multicore 1
#$ -R y
#$ -o /dev/ngs002/hhong/SEQC2/high_reproBed/CQ/rp_merge_run.RTG.log

export mybin=/dev/ngs001/bpan/bin/bedtools2/bin
export PATH=$mybin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:$PATH
sourcedir=/dev/ngs002/hhong/SEQC2/high_reproBed/CQ/2_callableBed
outdir=/dev/ngs002/hhong/SEQC2/high_reproBed/CQ/3_replicatesMrg
#for aligner in Bowtie2 BWA ISAAC stampy;do
#for caller in HC ISAAC FreeBayes Samtools Varscan SNVer;do
#for caller in FreeBayes; do
#mkdir $outdir/$aligner'_'$caller
#mkdir $outdir/$aligner'_GATK_'$caller
#for name in ARD_LCL5_1 ARD_LCL5_2 ARD_LCL5_3 ARD_LCL6_1 ARD_LCL6_2 ARD_LCL6_3 ARD_LCL7_1 ARD_LCL7_2 ARD_LCL7_3 ARD_LCL8_1 ARD_LCL8_2 ARD_LCL8_3 ARD_NIST8398_1 ARD_NIST8398_2 ARD_NIST8398_3 NVG_LCL5_1 NVG_LCL5_2 NVG_LCL5_3 NVG_LCL6_1 NVG_LCL6_2 NVG_LCL6_3 NVG_LCL7_1 NVG_LCL7_2 NVG_LCL7_3 NVG_LCL8_1 NVG_LCL8_2 NVG_LCL8_3 WUX_LCL5_1 WUX_LCL5_2 WUX_LCL5_3 WUX_LCL6_1 WUX_LCL6_2 WUX_LCL6_3 WUX_LCL7_1 WUX_LCL7_2 WUX_LCL7_3 WUX_LCL8_1 WUX_LCL8_2 WUX_LCL8_3;do
#for name in ARD_LCL5 ARD_LCL6 ARD_LCL7 ARD_LCL8 ARD_NIST8398 NVG_LCL5 NVG_LCL6 NVG_LCL7 NVG_LCL8 WUX_LCL5 WUX_LCL6 WUX_LCL7 WUX_LCL8; do
bedtools multiinter -i $sourcedir/"$1"_"$2"_1.noGATK.callable_status.bed $sourcedir/"$1"_"$2"_2.noGATK.callable_status.bed $sourcedir/"$1"_"$2"_3.noGATK.callable_status.bed >$outdir/repMrg_"$1"_"$2".noGATK.txt

#done
#done
#done

