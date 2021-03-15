#!/bin/sh
#
#$ -N repsnv_cnt
#$ -S /bin/bash
#$ -cwd
#$ -j y
#$ -pe multicore 4 
#$ -R y
#$ -o /dev/ngs007/hhong/BedFilt_CQHP/CQ/cal_repeatability_run.log

export mybin=/dev/ngs002/hhong/bin/rtg-tools-3.9
#export JAVA=/storage2/bgong/tools/jdk/bin
export JAVA=/dev/ngs002/hhong/bin/rtg-tools-3.9/jre/bin
export PATH=$JAVA:$mybin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:$PATH
sourcedir=/dev/ngs007/hhong/BedFilt_CQHP/CQ
sdfdir=/dev/ngs004/hhong/CQ/hg38
outdir=/dev/ngs007/hhong/BedFilt_CQHP/CQ_comp1_rep
#for aligner in Bowtie2 BWA ISAAC stampy;do
#for caller in HC ISAAC FreeBayes Samtools Varscan SNVer;do
#for caller in FreeBayes; do
#mkdir $outdir/$1'_'$2
#mkdir $outdir/$1'_GATK_'$2
#for name in ARD_LCL5_1 ARD_LCL5_2 ARD_LCL5_3 ARD_LCL6_1 ARD_LCL6_2 ARD_LCL6_3 ARD_LCL7_1 ARD_LCL7_2 ARD_LCL7_3 ARD_LCL8_1 ARD_LCL8_2 ARD_LCL8_3 ARD_NIST8398_1 ARD_NIST8398_2 ARD_NIST8398_3 NVG_LCL5_1 NVG_LCL5_2 NVG_LCL5_3 NVG_LCL6_1 NVG_LCL6_2 NVG_LCL6_3 NVG_LCL7_1 NVG_LCL7_2 NVG_LCL7_3 NVG_LCL8_1 NVG_LCL8_2 NVG_LCL8_3 WUX_LCL5_1 WUX_LCL5_2 WUX_LCL5_3 WUX_LCL6_1 WUX_LCL6_2 WUX_LCL6_3 WUX_LCL7_1 WUX_LCL7_2 WUX_LCL7_3 WUX_LCL8_1 WUX_LCL8_2 WUX_LCL8_3;do
#for name in ARD_LCL5 ARD_LCL6 ARD_LCL7 ARD_LCL8 ARD_NIST8398 NVG_LCL5 NVG_LCL6 NVG_LCL7 NVG_LCL8 WUX_LCL5 WUX_LCL6 WUX_LCL7 WUX_LCL8; do
#Bowtie2 GATK    FreeBayes       ARD     LCL7    Q1      T2
#Bowtie2 GATK    HC      ARD     LCL5    Q1      T2
rm -rf $outdir/"$1"_GATK_"$2"/"$3"_"$4"_Q1_T2
mkdir $outdir/"$1"_GATK_"$2"/temp
tempdir=$outdir/"$1"_GATK_"$2"/temp

java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfeval -b $sourcedir/"$1"_GATK_"$2"/"$3"_"$4"_2."$2".GATK.bedFilt.vcf.gz -c $sourcedir/"$1"_GATK_"$2"/"$3"_"$4"_1."$2".GATK.bedFilt.vcf.gz -t $sdfdir/hg38_sdf/ -o $outdir/$1'_GATK_'$2/"$3"_"$4"_Q1_T2

java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfeval -b $sourcedir/"$1"_GATK_"$2"/"$3"_"$4"_3."$2".GATK.bedFilt.vcf.gz -c $sourcedir/"$1"_GATK_"$2"/"$3"_"$4"_1."$2".GATK.bedFilt.vcf.gz -t $sdfdir/hg38_sdf/ -o $outdir/$1'_GATK_'$2/"$3"_"$4"_Q1_T3

java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfeval -b $sourcedir/"$1"_GATK_"$2"/"$3"_"$4"_3."$2".GATK.bedFilt.vcf.gz -c $sourcedir/"$1"_GATK_"$2"/"$3"_"$4"_2."$2".GATK.bedFilt.vcf.gz -t $sdfdir/hg38_sdf/ -o $outdir/$1'_GATK_'$2/"$3"_"$4"_Q2_T3


java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfstat $outdir/$1'_GATK_'$2/"$3"_"$4"_Q1_T2/tp-baseline.vcf.gz >$outdir/$1'_GATK_'$2/"$3"_"$4"_Q1_T2/AB.stat.txt
java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfstat $outdir/$1'_GATK_'$2/"$3"_"$4"_Q1_T2/fp.vcf.gz >$outdir/$1'_GATK_'$2/"$3"_"$4"_Q1_T2/A.stat.txt
java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfstat $outdir/$1'_GATK_'$2/"$3"_"$4"_Q1_T2/fn.vcf.gz >$outdir/$1'_GATK_'$2/"$3"_"$4"_Q1_T2/B.stat.txt
java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfstat $outdir/$1'_GATK_'$2/"$3"_"$4"_Q1_T2/tp.vcf.gz >$outdir/$1'_GATK_'$2/"$3"_"$4"_Q1_T2/BA.stat.txt

java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfstat $outdir/$1'_GATK_'$2/"$3"_"$4"_Q1_T3/tp-baseline.vcf.gz >$outdir/$1'_GATK_'$2/"$3"_"$4"_Q1_T3/AB.stat.txt
java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfstat $outdir/$1'_GATK_'$2/"$3"_"$4"_Q1_T3/fp.vcf.gz >$outdir/$1'_GATK_'$2/"$3"_"$4"_Q1_T3/A.stat.txt
java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfstat $outdir/$1'_GATK_'$2/"$3"_"$4"_Q1_T3/fn.vcf.gz >$outdir/$1'_GATK_'$2/"$3"_"$4"_Q1_T3/B.stat.txt
java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfstat $outdir/$1'_GATK_'$2/"$3"_"$4"_Q1_T3/tp.vcf.gz >$outdir/$1'_GATK_'$2/"$3"_"$4"_Q1_T3/BA.stat.txt

java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfstat $outdir/$1'_GATK_'$2/"$3"_"$4"_Q2_T3/tp-baseline.vcf.gz >$outdir/$1'_GATK_'$2/"$3"_"$4"_Q2_T3/AB.stat.txt
java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfstat $outdir/$1'_GATK_'$2/"$3"_"$4"_Q2_T3/fp.vcf.gz >$outdir/$1'_GATK_'$2/"$3"_"$4"_Q2_T3/A.stat.txt
java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfstat $outdir/$1'_GATK_'$2/"$3"_"$4"_Q2_T3/fn.vcf.gz >$outdir/$1'_GATK_'$2/"$3"_"$4"_Q2_T3/B.stat.txt
java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfstat $outdir/$1'_GATK_'$2/"$3"_"$4"_Q2_T3/tp.vcf.gz >$outdir/$1'_GATK_'$2/"$3"_"$4"_Q2_T3/BA.stat.txt


mkdir $outdir/"$1"_"$2"/temp
tempdir=$outdir/"$1"_"$2"/temp

java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfeval -b $sourcedir/"$1"_"$2"/"$3"_"$4"_2."$2".bedFilt.vcf.gz -c $sourcedir/"$1"_"$2"/"$3"_"$4"_1."$2".bedFilt.vcf.gz -t $sdfdir/hg38_sdf/ -o $outdir/$1'_'$2/"$3"_"$4"_Q1_T2

java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfeval -b $sourcedir/"$1"_"$2"/"$3"_"$4"_3."$2".bedFilt.vcf.gz -c $sourcedir/"$1"_"$2"/"$3"_"$4"_1."$2".bedFilt.vcf.gz -t $sdfdir/hg38_sdf/ -o $outdir/$1'_'$2/"$3"_"$4"_Q1_T3

java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfeval -b $sourcedir/"$1"_"$2"/"$3"_"$4"_3."$2".bedFilt.vcf.gz -c $sourcedir/"$1"_"$2"/"$3"_"$4"_2."$2".bedFilt.vcf.gz -t $sdfdir/hg38_sdf/ -o $outdir/$1'_'$2/"$3"_"$4"_Q2_T3


java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfstat $outdir/$1'_'$2/"$3"_"$4"_Q1_T2/tp-baseline.vcf.gz >$outdir/$1'_'$2/"$3"_"$4"_Q1_T2/AB.stat.txt
java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfstat $outdir/$1'_'$2/"$3"_"$4"_Q1_T2/fp.vcf.gz >$outdir/$1'_'$2/"$3"_"$4"_Q1_T2/A.stat.txt
java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfstat $outdir/$1'_'$2/"$3"_"$4"_Q1_T2/fn.vcf.gz >$outdir/$1'_'$2/"$3"_"$4"_Q1_T2/B.stat.txt
java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfstat $outdir/$1'_'$2/"$3"_"$4"_Q1_T2/tp.vcf.gz >$outdir/$1'_'$2/"$3"_"$4"_Q1_T2/BA.stat.txt

java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfstat $outdir/$1'_'$2/"$3"_"$4"_Q1_T3/tp-baseline.vcf.gz >$outdir/$1'_'$2/"$3"_"$4"_Q1_T3/AB.stat.txt
java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfstat $outdir/$1'_'$2/"$3"_"$4"_Q1_T3/fp.vcf.gz >$outdir/$1'_'$2/"$3"_"$4"_Q1_T3/A.stat.txt
java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfstat $outdir/$1'_'$2/"$3"_"$4"_Q1_T3/fn.vcf.gz >$outdir/$1'_'$2/"$3"_"$4"_Q1_T3/B.stat.txt
java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfstat $outdir/$1'_'$2/"$3"_"$4"_Q1_T3/tp.vcf.gz >$outdir/$1'_'$2/"$3"_"$4"_Q1_T3/BA.stat.txt

java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfstat $outdir/$1'_'$2/"$3"_"$4"_Q2_T3/tp-baseline.vcf.gz >$outdir/$1'_'$2/"$3"_"$4"_Q2_T3/AB.stat.txt
java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfstat $outdir/$1'_'$2/"$3"_"$4"_Q2_T3/fp.vcf.gz >$outdir/$1'_'$2/"$3"_"$4"_Q2_T3/A.stat.txt
java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfstat $outdir/$1'_'$2/"$3"_"$4"_Q2_T3/fn.vcf.gz >$outdir/$1'_'$2/"$3"_"$4"_Q2_T3/B.stat.txt
java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfstat $outdir/$1'_'$2/"$3"_"$4"_Q2_T3/tp.vcf.gz >$outdir/$1'_'$2/"$3"_"$4"_Q2_T3/BA.stat.txt



