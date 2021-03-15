#!/bin/sh
#
#$ -N repsnv_cnt
#$ -S /bin/bash
#$ -cwd
#$ -j y
#$ -pe hostcore 4 
#$ -R y
#$ -o /dev/ngs004/hhong/CQ/ChineseQuartet_to_hg38/4_Calling_vcfFile/vcfstat.log

export bedtools=/storage2/zliu/bin/bedtools2/bin
export mybin=/dev/ngs002/hhong/bin/rtg-tools-3.9
export JAVA=/storage2/bgong/tools/jdk/bin
export PATH=$bedtools:$JAVA:$mybin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:$PATH
sourcedir=/dev/ngs004/hhong/CQ/ChineseQuartet_to_hg38/4_Calling_vcfFile
beddir=/dev/ngs002/hhong/SEQC2/high_reproBed/CQ/z_4_0805_filtMendelian_HighBed
sdfdir=/dev/ngs004/hhong/CQ/hg38
outdir=/dev/ngs004/hhong/CQ/ChineseQuartet_to_hg38/4_Calling_vcfFile/statOut
##Command Example: qsub rtg_vcfstat.sh Bowtie2 HC ARD LCL5
##Four input: aligner caller Lab sample

mkdir $outdir/$1'_'$2
mkdir $outdir/$1'_GATK_'$2
mkdir $outdir/"$1"_GATK_"$2"/temp
tempdir=$outdir/"$1"_GATK_"$2"/temp
java -Djava.io.tmpdir=$tempdir -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfstat $sourcedir/$1'_GATK_'$2/"$3"_"$4"_1."$2".GATK.raw.vcf.gz >$outdir/$1'_GATK_'$2/stat_"$3"_"$4"_1."$2".GATK.raw.vcf.txt
java -Djava.io.tmpdir=$tempdir -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfstat $sourcedir/$1'_GATK_'$2/"$3"_"$4"_2."$2".GATK.raw.vcf.gz >$outdir/$1'_GATK_'$2/stat_"$3"_"$4"_2."$2".GATK.raw.vcf.txt
java -Djava.io.tmpdir=$tempdir -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfstat $sourcedir/$1'_GATK_'$2/"$3"_"$4"_3."$2".GATK.raw.vcf.gz >$outdir/$1'_GATK_'$2/stat_"$3"_"$4"_3."$2".GATK.raw.vcf.txt

mkdir $outdir/"$1"_"$2"/temp
tempdir=$outdir/"$1"_"$2"/temp
java -Djava.io.tmpdir=$tempdir -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfstat $sourcedir/$1'_'$2/"$3"_"$4"_1."$2".raw.vcf.gz >$outdir/$1'_'$2/stat_"$3"_"$4"_1."$2".raw.vcf.txt
java -Djava.io.tmpdir=$tempdir -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfstat $sourcedir/$1'_'$2/"$3"_"$4"_2."$2".raw.vcf.gz >$outdir/$1'_'$2/stat_"$3"_"$4"_2."$2".raw.vcf.txt
java -Djava.io.tmpdir=$tempdir -jar /dev/ngs002/hhong/bin/rtg-tools-3.9/RTG.jar vcfstat $sourcedir/$1'_'$2/"$3"_"$4"_3."$2".raw.vcf.gz >$outdir/$1'_'$2/stat_"$3"_"$4"_3."$2".raw.vcf.txt


#done
#done
#done

