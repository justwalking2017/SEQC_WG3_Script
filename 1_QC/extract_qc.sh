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
outdir=/dev/ngs001/bpan/seqc_QC/CQ_QC/FredScore_out
sourcedir=/dev/ngs001/bpan/seqc_QC/CQ_QC
sourcedir1=/dev/ngs004/hhong/CQ/data/Quartet/DNA/20170403_DNA_ILM_ARD
sourcedir2=/dev/ngs004/hhong/CQ/data/Quartet/DNA/20170329_DNA_ILM_NVG
sourcedir3=/dev/ngs004/hhong/CQ/data/Quartet/DNA/20170216_DNA_ILM_WUX

for name in ARD_LCL5_1 ARD_LCL5_2 ARD_LCL5_3 ARD_LCL6_1 ARD_LCL6_2 ARD_LCL6_3 ARD_LCL7_1 ARD_LCL7_2 ARD_LCL7_3 ARD_LCL8_1 ARD_LCL8_2 ARD_LCL8_3 ARD_NIST8398_1 ARD_NIST8398_2 ARD_NIST8398_3; do

head -n 51  $sourcedir/Quartet_DNA_ILM_"$name"_20170403_R1_fastqc/fastqc_data.txt | tail -n 39 >"$name"_R1_fredScore.txt
head -n 51  $sourcedir/Quartet_DNA_ILM_"$name"_20170403_R2_fastqc/fastqc_data.txt | tail -n 39 >"$name"_R2_fredScore.txt

done

for name2 in NVG_LCL5_1 NVG_LCL5_2 NVG_LCL5_3 NVG_LCL6_1 NVG_LCL6_2 NVG_LCL6_3 NVG_LCL7_1 NVG_LCL7_2 NVG_LCL7_3 NVG_LCL8_1 NVG_LCL8_2 NVG_LCL8_3; do

head -n 51  $sourcedir/Quartet_DNA_ILM_"$name2"_20170329_R1_fastqc/fastqc_data.txt | tail -n 39 >"$name2"_R1_fredScore.txt
head -n 51  $sourcedir/Quartet_DNA_ILM_"$name2"_20170329_R2_fastqc/fastqc_data.txt | tail -n 39 >"$name2"_R2_fredScore.txt

done

for name3 in WUX_LCL5_1 WUX_LCL5_2 WUX_LCL5_3 WUX_LCL6_1 WUX_LCL6_2 WUX_LCL6_3 WUX_LCL7_1 WUX_LCL7_2 WUX_LCL7_3 WUX_LCL8_1 WUX_LCL8_2 WUX_LCL8_3;do

head -n 51  $sourcedir/Quartet_DNA_ILM_"$name3"_20170216_R1_fastqc/fastqc_data.txt | tail -n 39 >"$name3"_R1_fredScore.txt
head -n 51  $sourcedir/Quartet_DNA_ILM_"$name3"_20170216_R2_fastqc/fastqc_data.txt | tail -n 39 >"$name3"_R2_fredScore.txt
done
#done
#done
