#!/bin/sh
#
#$ -N PRF_cnt
#$ -S /bin/bash
#$ -cwd
#$ -j y
#$ -pe multicore 4 
#$ -R y
#$ -o /dev/ngs007/hhong/NovaSeq1/6_1_depthFilt_PRF/cal_PRFcal_run.log

export mybin=/dev/ngs002/hhong/bin/rtg-tools-3.9
export JAVA=/storage2/bgong/tools/jdk/bin
export PATH=$JAVA:$mybin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:$PATH
sourcedir=/dev/ngs007/hhong/NovaSeq1/4_depthFilter
sdfdir=/dev/ngs004/hhong/CQ/hg38
hrvcf=/dev/ngs004/hhong/CQ/ChineseQuartet_to_hg38/4_HR_VCF
outdir=/dev/ngs007/hhong/NovaSeq1/6_1_depthFilt_PRF


mkdir $outdir/"$1"_"$2"
mkdir $outdir/"$1"_"$2"/temp
tempdir=$outdir/"$1"_"$2"/temp


java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfeval -b $hrvcf/MVfilt_"$4"_8callerCS_8alignCS_3labCS_3repCS.dsFilt.vcf.gz -c $sourcedir/"$1"_"$2"/"$3"_"$4"_1."$2".dpFilt.vcf.gz -t $sdfdir/hg38_sdf/ -o $outdir/$1'_'$2/"$3"_"$4"_T1
java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfeval -b $hrvcf/MVfilt_"$4"_8callerCS_8alignCS_3labCS_3repCS.dsFilt.vcf.gz -c $sourcedir/"$1"_"$2"/"$3"_"$4"_2."$2".dpFilt.vcf.gz -t $sdfdir/hg38_sdf/ -o $outdir/$1'_'$2/"$3"_"$4"_T2
java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfeval -b $hrvcf/MVfilt_"$4"_8callerCS_8alignCS_3labCS_3repCS.dsFilt.vcf.gz -c $sourcedir/"$1"_"$2"/"$3"_"$4"_3."$2".dpFilt.vcf.gz -t $sdfdir/hg38_sdf/ -o $outdir/$1'_'$2/"$3"_"$4"_T3

java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfstat $outdir/$1'_'$2/"$3"_"$4"_T1/tp-baseline.vcf.gz >$outdir/$1'_'$2/"$3"_"$4"_T1/AB.stat.txt
java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfstat $outdir/$1'_'$2/"$3"_"$4"_T1/fp.vcf.gz >$outdir/$1'_'$2/"$3"_"$4"_T1/A.stat.txt
java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfstat $outdir/$1'_'$2/"$3"_"$4"_T1/fn.vcf.gz >$outdir/$1'_'$2/"$3"_"$4"_T1/B.stat.txt
java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfstat $outdir/$1'_'$2/"$3"_"$4"_T1/tp.vcf.gz >$outdir/$1'_'$2/"$3"_"$4"_T1/BA.stat.txt

java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfstat $outdir/$1'_'$2/"$3"_"$4"_T2/tp-baseline.vcf.gz >$outdir/$1'_'$2/"$3"_"$4"_T2/AB.stat.txt
java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfstat $outdir/$1'_'$2/"$3"_"$4"_T2/fp.vcf.gz >$outdir/$1'_'$2/"$3"_"$4"_T2/A.stat.txt
java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfstat $outdir/$1'_'$2/"$3"_"$4"_T2/fn.vcf.gz >$outdir/$1'_'$2/"$3"_"$4"_T2/B.stat.txt
java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfstat $outdir/$1'_'$2/"$3"_"$4"_T2/tp.vcf.gz >$outdir/$1'_'$2/"$3"_"$4"_T2/BA.stat.txt

java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfstat $outdir/$1'_'$2/"$3"_"$4"_T3/tp-baseline.vcf.gz >$outdir/$1'_'$2/"$3"_"$4"_T3/AB.stat.txt
java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfstat $outdir/$1'_'$2/"$3"_"$4"_T3/fp.vcf.gz >$outdir/$1'_'$2/"$3"_"$4"_T3/A.stat.txt
java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfstat $outdir/$1'_'$2/"$3"_"$4"_T3/fn.vcf.gz >$outdir/$1'_'$2/"$3"_"$4"_T3/B.stat.txt
java -Djava.io.tmpdir=$tempdir -Xmx20g -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfstat $outdir/$1'_'$2/"$3"_"$4"_T3/tp.vcf.gz >$outdir/$1'_'$2/"$3"_"$4"_T3/BA.stat.txt
