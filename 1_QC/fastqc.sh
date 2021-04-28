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
sourcedir1=dev/ngs004/hhong/CQ/data/Quartet/DNA

fastqc -q  $sourcedir1/Quartet_DNA_ILM_"$1"_20170403_R1.fastq.gz -o $outdir
fastqc -q  $sourcedir1/Quartet_DNA_ILM_"$1"_20170403_R2.fastq.gz -o $outdir

fastqc -q  $sourcedir2/Quartet_DNA_ILM_"$1"_20170329_R1.fastq.gz -o $outdir
fastqc -q  $sourcedir2/Quartet_DNA_ILM_"$1"_20170329_R2.fastq.gz -o $outdir

fastqc -q  $sourcedir3/Quartet_DNA_ILM_"$1"_20170216_R1.fastq.gz -o $outdir
fastqc -q  $sourcedir3/Quartet_DNA_ILM_"$1"_20170216_R2.fastq.gz -o $outdir
