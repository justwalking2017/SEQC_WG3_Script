#!/bin/sh
#
#$ -N bedFilt
#$ -S /bin/bash
#$ -cwd
#$ -j y
#$ -pe multicore 4 
#$ -R y
#$ -o /dev/ngs007/hhong/BedFilt_CQHP/CQ/bedFilter_run.nist.RTG.log 

export mybin=/dev/ngs002/hhong/bin/rtg-tools-3.9
#export JAVA=/storage2/bgong/tools/jdk/bin
export JAVA=/dev/ngs002/hhong/bin/rtg-tools-3.9/jre/bin
export PATH=$JAVA:$mybin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:$PATH
sourcedir=/dev/ngs004/hhong/CQ/ChineseQuartet_to_hg38/4_Calling_vcfFile
sourcedir1=/dev/ngs002/hhong/SEQC2/high_reproSNV/1_3replicatesMrg/2_mrgOut
sourcedir2=/dev/ngs003/bpan/snvNum_stat/CQ/9_2median_RGFfilter_0502
beddir=/dev/ngs004/hhong/CQ/ChineseQuartet_to_hg38/4_HR_bed
sdfdir=/dev/ngs004/hhong/CQ/hg38
outdir=/dev/ngs007/hhong/BedFilt_CQHP/CQ
#for aligner in Bowtie2 BWA ISAAC stampy;do
#for caller in HC ISAAC FreeBayes Samtools Varscan SNVer;do
#for caller in FreeBayes; do
mkdir $outdir/$1'_check_'$2
mkdir $outdir/"$1"_check_"$2"/temp
tempdir=$outdir/"$1"_check_"$2"/temp
java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcffilter -i $sourcedir/"$1"_"$2"/"$3"_"$4"_1."$2".raw.vcf.gz --bed-regions=$beddir/HighRepro_"$4".bed -o $outdir/"$1"_check_"$2"/"$3"_"$4"_1."$2".bedFilt

java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcffilter -i $sourcedir/"$1"_"$2"/"$3"_"$4"_2."$2".raw.vcf.gz --bed-regions=$beddir/HighRepro_"$4".bed -o $outdir/"$1"_check_"$2"/"$3"_"$4"_2."$2".bedFilt

java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcffilter -i $sourcedir/"$1"_"$2"/"$3"_"$4"_3."$2".raw.vcf.gz --bed-regions=$beddir/HighRepro_"$4".bed -o $outdir/"$1"_check_"$2"/"$3"_"$4"_3."$2".bedFilt


java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfstat $outdir/"$1"_"$2"/"$3"_"$4"_1."$2".bedFilt.vcf.gz >$outdir/"$1"_check_"$2"/stat_"$3"_"$4"_1."$2".bedFilt.txt
java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfstat $outdir/"$1"_"$2"/"$3"_"$4"_2."$2".bedFilt.vcf.gz >$outdir/"$1"_check_"$2"/stat_"$3"_"$4"_2."$2".bedFilt.txt
java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfstat $outdir/"$1"_"$2"/"$3"_"$4"_3."$2".bedFilt.vcf.gz >$outdir/"$1"_check_"$2"/stat_"$3"_"$4"_3."$2".bedFilt.txt


#done
#done
#done
