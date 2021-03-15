#!/bin/sh
#
#$ -N snv_cnt
#$ -S /bin/bash
#$ -cwd
#$ -j y
#$ -pe multicore 1
#$ -R y
#$ -o /dev/ngs004/hhong/CQ/ChineseQuartet_to_hg38/4_DPfiltered_Calling_vcfFile/cal_dpFilter_run.v3.log

export mybin=/dev/ngs001/bpan/bin/GIAB_bin
export PATH=$mybin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:$PATH
sourcedir=/dev/ngs004/hhong/CQ/ChineseQuartet_to_hg38/4_Calling_vcfFile
sourcedir1=/dev/ngs002/hhong/SEQC2/high_reproSNV/1_3replicatesMrg/2_mrgOut
sourcedir2=/dev/ngs003/bpan/snvNum_stat/CQ/9_2median_RGFfilter_0502
outdir=/dev/ngs004/hhong/CQ/ChineseQuartet_to_hg38/4_DPfiltered_Calling_vcfFile
#for aligner in Bowtie2 BWA ISAAC stampy;do
#for caller in HC ISAAC FreeBayes Samtools Varscan SNVer;do
#for caller in FreeBayes; do
mkdir $outdir/$1'_'$2
mkdir $outdir/$1'_GATK_'$2
#for name in ARD_LCL5_1 ARD_LCL5_2 ARD_LCL5_3 ARD_LCL6_1 ARD_LCL6_2 ARD_LCL6_3 ARD_LCL7_1 ARD_LCL7_2 ARD_LCL7_3 ARD_LCL8_1 ARD_LCL8_2 ARD_LCL8_3 ARD_NIST8398_1 ARD_NIST8398_2 ARD_NIST8398_3 NVG_LCL5_1 NVG_LCL5_2 NVG_LCL5_3 NVG_LCL6_1 NVG_LCL6_2 NVG_LCL6_3 NVG_LCL7_1 NVG_LCL7_2 NVG_LCL7_3 NVG_LCL8_1 NVG_LCL8_2 NVG_LCL8_3 WUX_LCL5_1 WUX_LCL5_2 WUX_LCL5_3 WUX_LCL6_1 WUX_LCL6_2 WUX_LCL6_3 WUX_LCL7_1 WUX_LCL7_2 WUX_LCL7_3 WUX_LCL8_1 WUX_LCL8_2 WUX_LCL8_3;do
#for name in ARD_LCL5 ARD_LCL6 ARD_LCL7 ARD_LCL8 ARD_NIST8398 NVG_LCL5 NVG_LCL6 NVG_LCL7 NVG_LCL8 WUX_LCL5 WUX_LCL6 WUX_LCL7 WUX_LCL8; do

perl $outdir/DP_filter.3.pl $sourcedir/"$1"_GATK_"$2"/"$3"."$2".GATK.raw.vcf 8 223 $outdir/$1'_GATK_'$2/"$3"."$2".GATK.dpFilt.vcf
perl $outdir/DP_filter.3.pl $sourcedir/"$1"_"$2"/"$3"."$2".raw.vcf 8 223 $outdir/$1'_'$2/"$3"."$2".dpFilt.vcf

#done
#done
#done

