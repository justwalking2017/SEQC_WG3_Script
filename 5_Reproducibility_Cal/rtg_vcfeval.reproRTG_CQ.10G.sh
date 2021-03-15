#!/bin/sh
#
#$ -N repsnv_cnt
#$ -S /bin/bash
#$ -cwd
#$ -j y
#$ -pe hostcore 4 
#$ -R y
#$ -o /dev/ngs007/hhong/BedFilt_CQHP/CQ/cal_gtRepSNV.RTG10G.log

export mybin=/dev/ngs002/hhong/bin/rtg-tools-3.9
#export JAVA=/storage2/bgong/tools/jdk/bin
export JAVA=/dev/ngs002/hhong/bin/rtg-tools-3.9/jre/bin
export PATH=$JAVA:$mybin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:$PATH
sourcedir=/dev/ngs007/hhong/BedFilt_CQHP/CQ
sourcedir1=/dev/ngs002/hhong/SEQC2/high_reproSNV/1_3replicatesMrg/2_mrgOut
sourcedir2=/dev/ngs003/bpan/snvNum_stat/CQ/9_2median_RGFfilter_0502
sdfdir=/dev/ngs004/hhong/CQ/hg38
outdir=/dev/ngs007/hhong/BedFilt_CQHP/CQ_comp6_RTG-sentieonVS49
#for aligner in Bowtie2 BWA ISAAC stampy;do
#for caller in HC ISAAC FreeBayes Samtools Varscan SNVer;do
#for caller in FreeBayes; do
mkdir $outdir/$1'_RTG'
mkdir $outdir/$1'_sentieon'
#for name in ARD_LCL5_1 ARD_LCL5_2 ARD_LCL5_3 ARD_LCL6_1 ARD_LCL6_2 ARD_LCL6_3 ARD_LCL7_1 ARD_LCL7_2 ARD_LCL7_3 ARD_LCL8_1 ARD_LCL8_2 ARD_LCL8_3 ARD_NIST8398_1 ARD_NIST8398_2 ARD_NIST8398_3 NVG_LCL5_1 NVG_LCL5_2 NVG_LCL5_3 NVG_LCL6_1 NVG_LCL6_2 NVG_LCL6_3 NVG_LCL7_1 NVG_LCL7_2 NVG_LCL7_3 NVG_LCL8_1 NVG_LCL8_2 NVG_LCL8_3 WUX_LCL5_1 WUX_LCL5_2 WUX_LCL5_3 WUX_LCL6_1 WUX_LCL6_2 WUX_LCL6_3 WUX_LCL7_1 WUX_LCL7_2 WUX_LCL7_3 WUX_LCL8_1 WUX_LCL8_2 WUX_LCL8_3;do
#for name in ARD_LCL5 ARD_LCL6 ARD_LCL7 ARD_LCL8 ARD_NIST8398 NVG_LCL5 NVG_LCL6 NVG_LCL7 NVG_LCL8 WUX_LCL5 WUX_LCL6 WUX_LCL7 WUX_LCL8; do

#command example: qsub rtg_vcfeval.5.sh ARD_LCL5_1  Bowtie2 FreeBayes
#input 3 column: sampleName BWA Caller 

mkdir $outdir/$1'_RTG'/$2'_GATK_'$3
mkdir $outdir/$1'_RTG'/$2'_'$3
mkdir $outdir/$1'_RTG'/temp
tempdir=$outdir/$1'_RTG'/temp
java -Djava.io.tmpdir=$tempdir -Xmx10g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfeval -b $sourcedir/"$2"_GATK_"$3"/"$1"."$3".GATK.bedFilt.vcf.gz -c $sourcedir/RTG_RTG/"$1".RTG.bedFilt.vcf.gz -t $sdfdir/hg38_sdf/ -o $outdir/$1'_RTG'/$2'_GATK_'$3
java -Djava.io.tmpdir=$tempdir -Xmx10g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfeval -b $sourcedir/"$2"_"$3"/"$1"."$3".bedFilt.vcf.gz -c $sourcedir/RTG_RTG/"$1".RTG.bedFilt.vcf.gz -t $sdfdir/hg38_sdf/ -o $outdir/$1'_RTG'/$2'_'$3


mkdir $outdir/$1'_sentieon'/$2'_GATK_'$3
mkdir $outdir/$1'_sentieon'/$2'_'$3
mkdir $outdir/$1'_sentieon'/temp
tempdir=$outdir/$1'_sentieon'/temp
java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfeval -b $sourcedir/"$2"_GATK_"$3"/"$1"."$3".GATK.bedFilt.vcf.gz -c $sourcedir/sentieon_sentieon/"$1".sentieon.bedFilt.vcf.gz -t $sdfdir/hg38_sdf/ -o $outdir/$1'_sentieon'/"$2"_GATK_"$3"
java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfeval -b $sourcedir/"$2"_"$3"/"$1"."$3".bedFilt.vcf.gz -c $sourcedir/sentieon_sentieon/"$1".sentieon.bedFilt.vcf.gz -t $sdfdir/hg38_sdf/ -o $outdir/$1'_sentieon'/"$2"_"$3"


java -Djava.io.tmpdir=$tempdir -Xmx10g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfstat $outdir/$1'_RTG'/"$2"_GATK_"$3"/tp-baseline.vcf.gz >$outdir/$1'_RTG'/"$2"_GATK_"$3"/AB.stat.txt
java -Djava.io.tmpdir=$tempdir -Xmx10g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfstat $outdir/$1'_RTG'/"$2"_GATK_"$3"/fp.vcf.gz >$outdir/$1'_RTG'/"$2"_GATK_"$3"/A.stat.txt
java -Djava.io.tmpdir=$tempdir -Xmx10g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfstat $outdir/$1'_RTG'/"$2"_GATK_"$3"/fn.vcf.gz >$outdir/$1'_RTG'/"$2"_GATK_"$3"/B.stat.txt
java -Djava.io.tmpdir=$tempdir -Xmx10g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfstat $outdir/$1'_RTG'/"$2"_GATK_"$3"/tp.vcf.gz >$outdir/$1'_RTG'/"$2"_GATK_"$3"/BA.stat.txt

java -Djava.io.tmpdir=$tempdir -Xmx10g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfstat $outdir/$1'_RTG'/"$2"_"$3"/tp-baseline.vcf.gz >$outdir/$1'_RTG'/"$2"_"$3"/AB.stat.txt
java -Djava.io.tmpdir=$tempdir -Xmx10g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfstat $outdir/$1'_RTG'/"$2"_"$3"/fp.vcf.gz >$outdir/$1'_RTG'/"$2"_"$3"/A.stat.txt
java -Djava.io.tmpdir=$tempdir -Xmx10g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfstat $outdir/$1'_RTG'/"$2"_"$3"/fn.vcf.gz >$outdir/$1'_RTG'/"$2"_"$3"/B.stat.txt
java -Djava.io.tmpdir=$tempdir -Xmx10g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfstat $outdir/$1'_RTG'/"$2"_"$3"/tp.vcf.gz >$outdir/$1'_RTG'/"$2"_"$3"/BA.stat.txt


java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfstat $outdir/$1'_sentieon'/"$2"_GATK_"$3"/tp-baseline.vcf.gz >$outdir/$1'_sentieon'/"$2"_GATK_"$3"/AB.stat.txt
java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfstat $outdir/$1'_sentieon'/"$2"_GATK_"$3"/fp.vcf.gz >$outdir/$1'_sentieon'/"$2"_GATK_"$3"/A.stat.txt
java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfstat $outdir/$1'_sentieon'/"$2"_GATK_"$3"/fn.vcf.gz >$outdir/$1'_sentieon'/"$2"_GATK_"$3"/B.stat.txt
java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfstat $outdir/$1'_sentieon'/"$2"_GATK_"$3"/tp.vcf.gz >$outdir/$1'_sentieon'/"$2"_GATK_"$3"/BA.stat.txt

java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfstat $outdir/$1'_sentieon'/"$2"_"$3"/tp-baseline.vcf.gz >$outdir/$1'_sentieon'/"$2"_"$3"/AB.stat.txt
java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfstat $outdir/$1'_sentieon'/"$2"_"$3"/fp.vcf.gz >$outdir/$1'_sentieon'/"$2"_"$3"/A.stat.txt
java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfstat $outdir/$1'_sentieon'/"$2"_"$3"/fn.vcf.gz >$outdir/$1'_sentieon'/"$2"_"$3"/B.stat.txt
java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfstat $outdir/$1'_sentieon'/"$2"_"$3"/tp.vcf.gz >$outdir/$1'_sentieon'/"$2"_"$3"/BA.stat.txt
#done
#done
#done

