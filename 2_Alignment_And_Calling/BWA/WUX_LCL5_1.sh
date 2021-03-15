#!/bin/sh
#
#$ -N WUX_LCL5_1_BWA_aligner
#$ -S /bin/bash
#$ -cwd
#$ -j y
#$ -pe multicore 8
#$ -R y
#$ -o /dev/ngs004/hhong/CQ/wf/BWA/WUX_LCL5_1.log

# datasets
sample=WUX_LCL5_1
F01=/dev/ngs004/hhong/CQ/data/Quartet/DNA/20170216_DNA_ILM_WUX/Quartet_DNA_ILM_WUX_LCL5_1_20170216_R1.fastq.gz
F02=/dev/ngs004/hhong/CQ/data/Quartet/DNA/20170216_DNA_ILM_WUX/Quartet_DNA_ILM_WUX_LCL5_1_20170216_R2.fastq.gz
## set path
export JAVA_HOME=/storage2/bgong/tools/jdk1.8.0_91 # JAVA version (build 1.8.0_91-b14)
export ztools=/storage2/zliu/bin

# export tools
export bwa=$ztools/bwa-0.7.15
export PICARD=$ztools/picard-2.7.1/picard.jar
export FreeBayes=$ztools/freebayes
config_file=$ztools/isaac_variant_caller-1.0.7/etc/ivc_config_default_wgs.ini
issac_caller=$ztools/isaac_variant_caller-1.0.7/bin/configureWorkflow.pl
GATK=$ztools/GATK3.7/GenomeAnalysisTK.jar
bcftools=$ztools/bcftools-1.3.1
samtools=$ztools/samtools-1.3.1
VarScan=$ztools/VarScan-2.3.9/VarScan.v2.3.9.jar
SNVer=$ztools/SNVer-0.5.3/SNVerIndividual.jar
export mybin=$JAVA_HOME/bin:$ztools/bwa-0.7.15:$ztools/GATK3.7:$ztools/bcftools-1.3.1:$ztools/samtools-1.3.1:$ztools/SNVer-0.5.3:$ztools/isaac_variant_caller-1.0.7/etc:$ztools/isaac_variant_caller-1.0.7/bin:$ztools/gvcftools-0.14/bin
export PATH=$mybin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:$PATH

# references genome and index
bwaindex=/dev/ngs004/hhong/CQ/hg38/BWA/hg38.fasta

# create tempdir for middle results
outdir=/dev/ngs004/hhong/CQ/wf/BWA/WUX_LCL5_1
# mkdir /dev/ngs004/hhong/CQ/wf/BWA/WUX_LCL5_1/tempdir
tempdir=/dev/ngs004/hhong/CQ/wf/BWA/WUX_LCL5_1/tempdir

# GATK local realignment and recalibration
F=$outdir/$sample.aln.sorted.dup.RG.bam
# ref information
ref=/dev/ngs004/hhong/CQ/hg38/hg38.fa
id_mills=/dev/ngs004/hhong/CQ/hg38/Mills_and_1000G_gold_standard.indels.b38.primary_assembly.vcf
id_1000g=/dev/ngs004/hhong/CQ/hg38/ALL.wgs.1000G_phase3.GRCh38.ncbi_remapper.20150424.shapeit2_indels.vcf
dbsnp=/dev/ngs004/hhong/CQ/hg38/dbsnp_146.hg38.vcf
## Realignment around indels using the GATK modules RealignerTargetCreator and IndelRealigner
# echo CREATE INTERVALS FOR LOCAL REALIGNMENT start at time && echo "`date`"
# java -Djava.io.tmpdir=$tempdir -Xmx20g \
# -jar $GATK \
# -T RealignerTargetCreator \
# -R $ref \
# -rf BadCigar \
# -known $id_mills \
# -known $id_1000g \
# -nt 8 \
# -I $F \
# -log $outdir/logs/$sample.log \
# -o $outdir/$sample.aln.sorted.dedup.bam.forRealigner.intervals \
# --allow_potentially_misencoded_quality_scores
# echo CREATE INTERVALS FOR LOCAL REALIGNMENT finish at time && echo "`date`"
# PERFORM LOCAL REALIGNMENT
# echo PERFORM LOCAL REALIGNMENT start at time && echo "`date`"
# java -Djava.io.tmpdir=$outdir/tempdir -Xmx20g \
# -jar $GATK \
# -T IndelRealigner \
# -R $ref \
# -rf BadCigar \
# -known $id_mills \
# -known $id_1000g \
# --consensusDeterminationModel USE_READS \
# -compress 0 \
# -targetIntervals $outdir/$sample.aln.sorted.dedup.bam.forRealigner.intervals \
# -I $F \
# -o $outdir/$sample.aln.sorted.dedup.realigned.bam \
# -log $outdir/logs/$sample.log \
# --allow_potentially_misencoded_quality_scores
# echo PERFORM LOCAL REALIGNMENT finish at time && echo "`date`"
# BASE RECALIBRATO
# echo BASE RECALIBRATO start at time && echo "`date`"
# java -Djava.io.tmpdir=$outdir/tempdir -Xmx20g \
# -jar $GATK \
# -T BaseRecalibrator \
# -R $ref \
# --disable_indel_quals \
# -rf BadCigar \
# -knownSites $dbsnp \
# -knownSites $id_mills \
# -knownSites $id_1000g \
# -nct 8 \
# -I $outdir/$sample.aln.sorted.dedup.realigned.bam \
# -o $outdir/$sample.recal_data.grp \
# -log $outdir/logs/$sample.log
# echo BASE RECALIBRATO finish at time && echo "`date`"
# APPLY RECALIBRATION (PRINT READS)
# echo APPLY RECALIBRATION start at time && echo "`date`"
# java -Djava.io.tmpdir=$outdir/tempdir -Xmx20g \
# -jar $GATK \
# -T PrintReads \
# -R $ref \
# -rf BadCigar \
# -BQSR $outdir/$sample.recal_data.grp \
# -nct 8 \
# -I $outdir/$sample.aln.sorted.dedup.realigned.bam \
# -o $outdir/$sample.aln.sorted.dedup.realigned.recal.bam \
# --allow_potentially_misencoded_quality_scores \
# -log $outdir/logs/$sample.log
# echo APPLY RECALIBRATION finish at time && echo "`date`"
# remove middle results
# rm $outdir/$sample.recal_data.grp
# rm $outdir/$sample.aln.sorted.dedup.realigned.bai
# rm $outdir/$sample.aln.sorted.dedup.realigned.bam
# rm $outdir/$sample.aln.sorted.dedup.bam.forRealigner.intervals
# SNV calling
# mkdir $outdir/WUX_LCL5_1_G
GATK HaplotypeCaller
# echo GATK HaplotypeCaller start at time && echo "`date`"
# java -Djava.io.tmpdir=$tempdir -Xmx40g \
# -jar $GATK \
# -T HaplotypeCaller \
# -R $ref \
# -rf BadCigar \
# --dbsnp $dbsnp \
# -stand_call_conf 30 \
# -I $outdir/WUX_LCL5_1.aln.sorted.dup.RG.bam \
# -o $outdir/WUX_LCL5_1.HC.raw.vcf
# echo GATK HaplotypeCaller finish at time && echo "`date`"
########################
# echo GATK HaplotypeCaller start at time && echo "`date`"
# java -Djava.io.tmpdir=$tempdir -Xmx40g \
# -jar $GATK \
# -T HaplotypeCaller \
# -R $ref \
# -rf BadCigar \
# --dbsnp $dbsnp \
# -stand_call_conf 30 \
# -I $outdir/WUX_LCL5_1.aln.sorted.dedup.realigned.recal.bam \
# -o $outdir/WUX_LCL5_1.HC.GATK.raw.vcf
# echo GATK HaplotypeCaller finish at time && echo "`date`"
Samtools calling
# echo samtools mpileup start at time && echo "`date`"
# samtools mpileup -ugf $ref $outdir/WUX_LCL5_1.aln.sorted.dup.RG.bam | bcftools call -vmO v -o $outdir/$sample.Samtools.raw.vcf && echo This-Work-is-Done!
# echo samtools mpileup finish at time && echo "`date`"
########################
# echo samtools mpileup start at time && echo "`date`"
# samtools mpileup -ugf $ref $outdir/WUX_LCL5_1.aln.sorted.dedup.realigned.recal.bam | bcftools call -vmO v -o $outdir/$sample.Samtools.GATK.raw.vcf && echo This-Work-is-Done!
# echo samtools mpileup finish at time && echo "`date`"
Varscan calling
# echo Varscan calling start at time && echo "`date`"
# samtools mpileup -B -f $ref $outdir/WUX_LCL5_1.aln.sorted.dup.RG.bam | java -Djava.io.tmpdir=$tempdir -Xmx40g -jar $VarScan mpileup2cns --p-value 0.05 --variants 1 --output-vcf 1 > $outdir/WUX_LCL5_1.Varscan.raw.vcf
# echo Varscan calling finish at time && echo "`date`"
#########################
echo Varscan calling start at time && echo "`date`"
samtools mpileup -B -f $ref $outdir/WUX_LCL5_1.aln.sorted.dedup.realigned.recal.bam | java -Djava.io.tmpdir=$tempdir -Xmx40g -jar $VarScan mpileup2cns --p-value 0.05 --variants 1 --output-vcf 1 > $outdir/WUX_LCL5_1.Varscan.GATK.raw.vcf
echo Varscan calling finish at time && echo "`date`"
# SNVer calling
echo SNVer start at time && echo "`date`"
java -Djava.io.tmpdir=$tempdir -Xmx40g \
-jar $SNVer \
-i $outdir/WUX_LCL5_1.aln.sorted.dup.RG.bam \
-r $ref \
-o $outdir/WUX_LCL5_1 \
-p 0.05
echo SNVer finish at time && echo "`date`"
#########################
echo SNVer start at time && echo "`date`"
java -Djava.io.tmpdir=$tempdir -Xmx40g \
-jar $SNVer \
-i $outdir/WUX_LCL5_1.aln.sorted.dedup.realigned.recal.bam \
-r $ref \
-o $outdir/WUX_LCL5_1_G \
-p 0.05
echo SNVer finish at time && echo "`date`"

