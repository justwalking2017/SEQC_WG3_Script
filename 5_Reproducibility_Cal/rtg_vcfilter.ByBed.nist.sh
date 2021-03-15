#!/bin/sh
#
#$ -N bedFilt
#$ -S /bin/bash
#$ -cwd
#$ -j y
#$ -pe multicore 4 
#$ -R y
#$ -o /dev/ngs007/hhong/BedFilt_CQHP/CQ/bedFilter_run.nist.log 

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
mkdir $outdir/$1'_'$2
mkdir $outdir/$1'_GATK_'$2
#for name in ARD_LCL5_1 ARD_LCL5_2 ARD_LCL5_3 ARD_LCL6_1 ARD_LCL6_2 ARD_LCL6_3 ARD_LCL7_1 ARD_LCL7_2 ARD_LCL7_3 ARD_LCL8_1 ARD_LCL8_2 ARD_LCL8_3 ARD_NIST8398_1 ARD_NIST8398_2 ARD_NIST8398_3 NVG_LCL5_1 NVG_LCL5_2 NVG_LCL5_3 NVG_LCL6_1 NVG_LCL6_2 NVG_LCL6_3 NVG_LCL7_1 NVG_LCL7_2 NVG_LCL7_3 NVG_LCL8_1 NVG_LCL8_2 NVG_LCL8_3 WUX_LCL5_1 WUX_LCL5_2 WUX_LCL5_3 WUX_LCL6_1 WUX_LCL6_2 WUX_LCL6_3 WUX_LCL7_1 WUX_LCL7_2 WUX_LCL7_3 WUX_LCL8_1 WUX_LCL8_2 WUX_LCL8_3;do
#for name in ARD_LCL5 ARD_LCL6 ARD_LCL7 ARD_LCL8 ARD_NIST8398 NVG_LCL5 NVG_LCL6 NVG_LCL7 NVG_LCL8 WUX_LCL5 WUX_LCL6 WUX_LCL7 WUX_LCL8; do
#java -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar bgzip $sourcedir/"$1"_GATK_"$2"/"$3"_1."$2".GATK.vcf
#java -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar index -f vcf $sourcedir/"$1"_GATK_"$2"/"$3"_1."$2".GATK.vcf.gz

#java -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar bgzip $sourcedir/"$1"_GATK_"$2"/"$3"_2."$2".GATK.vcf
#java -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar index -f vcf $sourcedir/"$1"_GATK_"$2"/"$3"_2."$2".GATK.vcf.gz

#java -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar bgzip $sourcedir/"$1"_GATK_"$2"/"$3"_3."$2".GATK.vcf
#java -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar index -f vcf $sourcedir/"$1"_GATK_"$2"/"$3"_3."$2".GATK.vcf.gz

#dpFilt
#java -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar bgzip $sourcedir/"$1"_"$2"/"$3"_1."$2".vcf
#java -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar index -f vcf $sourcedir/"$1"_"$2"/"$3"_1."$2".vcf.gz

#java -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar bgzip $sourcedir/"$1"_"$2"/"$3"_2."$2".vcf
#java -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar index -f vcf $sourcedir/"$1"_"$2"/"$3"_2."$2".vcf.gz

#java -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar bgzip $sourcedir/"$1"_"$2"/"$3"_3."$2".vcf
#java -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar index -f vcf $sourcedir/"$1"_"$2"/"$3"_3."$2".vcf.gz



#java -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar bgzip $sourcedir/"$1"_GATK_"$2"/"$3"_3."$2".vcf 
#java -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar index -f vcf $sourcedir/"$1"_GATK_"$2"/"$3"_3."$2".vcf.gz 
mkdir $outdir/"$1"_GATK_"$2"/temp
tempdir=$outdir/"$1"_GATK_"$2"/temp
java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcffilter -i $sourcedir/"$1"_GATK_"$2"/"$3"_"$4"_1."$2".GATK.raw.vcf.gz --bed-regions=$beddir/HighRepro_"$4".bed -o $outdir/"$1"_GATK_"$2"/"$3"_"$4"_1."$2".GATK.bedFilt 

java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcffilter -i $sourcedir/"$1"_GATK_"$2"/"$3"_"$4"_2."$2".GATK.raw.vcf.gz --bed-regions=$beddir/HighRepro_"$4".bed -o $outdir/"$1"_GATK_"$2"/"$3"_"$4"_2."$2".GATK.bedFilt

java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcffilter -i $sourcedir/"$1"_GATK_"$2"/"$3"_"$4"_3."$2".GATK.raw.vcf.gz --bed-regions=$beddir/HighRepro_"$4".bed -o $outdir/"$1"_GATK_"$2"/"$3"_"$4"_3."$2".GATK.bedFilt

mkdir $outdir/"$1"_"$2"/temp
tempdir=$outdir/"$1"_"$2"/temp
java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcffilter -i $sourcedir/"$1"_"$2"/"$3"_"$4"_1."$2".raw.vcf.gz --bed-regions=$beddir/HighRepro_"$4".bed -o $outdir/"$1"_"$2"/"$3"_"$4"_1."$2".bedFilt

java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcffilter -i $sourcedir/"$1"_"$2"/"$3"_"$4"_2."$2".raw.vcf.gz --bed-regions=$beddir/HighRepro_"$4".bed -o $outdir/"$1"_"$2"/"$3"_"$4"_2."$2".bedFilt

java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcffilter -i $sourcedir/"$1"_"$2"/"$3"_"$4"_3."$2".raw.vcf.gz --bed-regions=$beddir/HighRepro_"$4".bed -o $outdir/"$1"_"$2"/"$3"_"$4"_3."$2".bedFilt


java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfstat $outdir/"$1"_GATK_"$2"/"$3"_"$4"_1."$2".GATK.bedFilt.vcf.gz >$outdir/"$1"_GATK_"$2"/stat_"$3"_"$4"_1."$2".GATK.bedFilt.txt
java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfstat $outdir/"$1"_GATK_"$2"/"$3"_"$4"_2."$2".GATK.bedFilt.vcf.gz >$outdir/"$1"_GATK_"$2"/stat_"$3"_"$4"_2."$2".GATK.bedFilt.txt
java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfstat $outdir/"$1"_GATK_"$2"/"$3"_"$4"_3."$2".GATK.bedFilt.vcf.gz >$outdir/"$1"_GATK_"$2"/stat_"$3"_"$4"_3."$2".GATK.bedFilt.txt

java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfstat $outdir/"$1"_"$2"/"$3"_"$4"_1."$2".bedFilt.vcf.gz >$outdir/"$1"_"$2"/stat_"$3"_"$4"_1."$2".bedFilt.txt
java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfstat $outdir/"$1"_"$2"/"$3"_"$4"_2."$2".bedFilt.vcf.gz >$outdir/"$1"_"$2"/stat_"$3"_"$4"_2."$2".bedFilt.txt
java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfstat $outdir/"$1"_"$2"/"$3"_"$4"_3."$2".bedFilt.vcf.gz >$outdir/"$1"_"$2"/stat_"$3"_"$4"_3."$2".bedFilt.txt


#done
#done
#done
