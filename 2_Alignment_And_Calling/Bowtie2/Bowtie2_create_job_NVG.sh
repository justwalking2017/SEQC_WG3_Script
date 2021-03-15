#!/bin/sh
for name in NVG_LCL5_1 NVG_LCL5_2 NVG_LCL5_3 NVG_LCL6_1 NVG_LCL6_2 NVG_LCL6_3 NVG_LCL7_1 NVG_LCL7_2 NVG_LCL7_3 NVG_LCL8_1 NVG_LCL8_2 NVG_LCL8_3;do
echo '#!/bin/sh' > $name.sh 
echo '#' >> $name.sh
echo '#$ -N '$name'_bowtie2_aligner' >> $name.sh
echo '#$ -S /bin/bash' >> $name.sh 
echo '#$ -cwd' >> $name.sh 
echo '#$ -j y' >> $name.sh 
echo '#$ -pe multicore 8' >> $name.sh 
echo '#$ -R y' >> $name.sh
echo '#$ -o /dev/ngs004/hhong/CQ/wf/Bowtie2/'$name'.log' >> $name.sh
echo '' >> $name.sh
echo '# datasets' >> $name.sh
echo 'sample='$name'' >> $name.sh
echo 'F01=/dev/ngs004/hhong/CQ/data/Quartet/DNA/20170329_DNA_ILM_NVG/Quartet_DNA_ILM_'$name'_20170329_R1.fastq.gz' >> $name.sh  # please check data diectory
echo 'F02=/dev/ngs004/hhong/CQ/data/Quartet/DNA/20170329_DNA_ILM_NVG/Quartet_DNA_ILM_'$name'_20170329_R2.fastq.gz' >> $name.sh # please check data diectory
echo '## set path' >> $name.sh 
echo 'export JAVA_HOME=/storage2/bgong/tools/jdk1.8.0_91 # JAVA version (build 1.8.0_91-b14)' >> $name.sh
echo 'export ztools=/storage2/zliu/bin' >> $name.sh
echo '' >> $name.sh
echo '# export tools' >> $name.sh
echo 'export bowtie=$ztools/bowtie2-2.2.9' >> $name.sh
echo 'export PICARD=$ztools/picard-2.7.1/picard.jar' >> $name.sh
echo 'export FreeBayes=$ztools/freebayes' >> $name.sh
echo 'config_file=$ztools/isaac_variant_caller-1.0.7/etc/ivc_config_default_wgs.ini' >> $name.sh
echo 'issac_caller=$ztools/isaac_variant_caller-1.0.7/bin/configureWorkflow.pl' >> $name.sh
echo 'GATK=$ztools/GATK3.7/GenomeAnalysisTK.jar' >> $name.sh
echo 'bcftools=$ztools/bcftools-1.3.1' >> $name.sh
echo 'samtools=$ztools/samtools-1.3.1' >> $name.sh
echo 'VarScan=$ztools/VarScan-2.3.9/VarScan.v2.3.9.jar' >> $name.sh
echo 'SNVer=$ztools/SNVer-0.5.3/SNVerIndividual.jar' >> $name.sh
echo 'export mybin=$JAVA_HOME/bin:$ztools/bowtie2-2.2.9:$ztools/GATK3.7:$ztools/bcftools-1.3.1:$ztools/samtools-1.3.1:$ztools/SNVer-0.5.3:$ztools/isaac_variant_caller-1.0.7/etc:$ztools/isaac_variant_caller-1.0.7/bin:$ztools/gvcftools-0.14/bin' >> $name.sh
echo 'export PATH=$mybin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:$PATH' >> $name.sh
echo '' >> $name.sh
echo '# references genome and index' >> $name.sh
echo 'bowtieindex=/dev/ngs004/hhong/CQ/hg38/Bowtie2/hg38.fasta' >> $name.sh
echo '' >> $name.sh
echo '# create tempdir for middle results' >> $name.sh
echo 'mkdir /dev/ngs004/hhong/CQ/wf/Bowtie2/'$name'' >> $name.sh
echo 'outdir=/dev/ngs004/hhong/CQ/wf/Bowtie2/'$name'' >> $name.sh
echo 'mkdir /dev/ngs004/hhong/CQ/wf/Bowtie2/'$name'/tempdir' >> $name.sh
echo 'tempdir=/dev/ngs004/hhong/CQ/wf/Bowtie2/'$name'/tempdir' >> $name.sh
# echo '# bowtie2 align' >> $name.sh
# echo 'echo ''bowtie2 alignment start at time'' && echo "`date`"' >> $name.sh	
# echo 'bowtie2 -p 8 -x $bowtieindex -1 $F01 -2 $F02 -S $outdir/$sample.aln.sam' >> $name.sh
# echo 'echo ''bowtie2 alignment finish at time'' && echo "`date`"' >> $name.sh	
echo '' >> $name.sh
# echo '# sam file to bam file and sort' >> $name.sh 
# echo 'java -Djava.io.tmpdir=$tempdir -Xmx20g -jar $PICARD SortSam \' >> $name.sh
# echo 'MAX_RECORDS_IN_RAM=7500000 \' >> $name.sh
# echo 'VALIDATION_STRINGENCY=SILENT \' >> $name.sh
# echo 'I=$outdir/$sample.aln.sam \' >> $name.sh
# echo 'O=$outdir/$sample.aln.sorted.bam \' >> $name.sh
# echo 'SORT_ORDER=coordinate' >> $name.sh
# echo '# remove temp file' >> $name.sh
# echo 'rm -rf $outdir/$sample.aln.bam' >> $name.sh
# echo '' >> $name.sh
# echo '# PCR duplicate mark' >> $name.sh
# echo 'java -Djava.io.tmpdir=$tempdir -Xmx20g -jar $PICARD MarkDuplicates \' >> $name.sh
# echo 'REMOVE_DUPLICATES=true \' >> $name.sh
# echo 'MAX_FILE_HANDLES_FOR_READ_ENDS_MAP=950 \' >> $name.sh
# echo 'VALIDATION_STRINGENCY=SILENT \' >> $name.sh
# echo 'I=$outdir/$sample.aln.sorted.bam \' >> $name.sh
# echo 'O=$outdir/$sample.aln.sorted.dup.bam \' >> $name.sh
# echo 'M=$outdir/$sample.marked_dup_metrics.txt' >> $name.sh
# echo '# remove temp file' >> $name.sh
# echo 'rm -rf $outdir/$sample.aln.sorted.bam' >> $name.sh
# echo '' >> $name.sh
# echo '# AddOrReplaceReadGroups' >> $name.sh
# echo 'java -Djava.io.tmpdir=$tempdir -Xmx20g -jar $PICARD AddOrReplaceReadGroups \' >> $name.sh
# echo 'I=$outdir/$sample.aln.sorted.dup.bam \' >> $name.sh
# echo 'O=$outdir/$sample.aln.sorted.dup.RG.bam \' >> $name.sh
# echo 'VALIDATION_STRINGENCY=SILENT \' >> $name.sh
# echo 'RGID=$sample \' >> $name.sh
# echo 'RGLB=$sample \' >> $name.sh
# echo 'RGPL=illumina \'>> $name.sh
# echo 'RGPU="HiSeq-XTen" \' >> $name.sh
# echo 'RGSM=$sample \' >> $name.sh
# echo 'CREATE_INDEX=true' >> $name.sh
# echo '# remove temp file' >> $name.sh
# echo 'rm -rf $outdir/$sample.aln.sorted.dup.bam' >> $name.sh
# echo '' >> $name.sh
echo '# GATK local realignment and recalibration' >> $name.sh
echo 'F=$outdir/$sample.aln.sorted.dup.RG.bam' >> $name.sh
echo '# ref information' >> $name.sh
echo 'ref=/dev/ngs004/hhong/CQ/hg38/hg38.fa' >> $name.sh
echo 'id_mills=/dev/ngs004/hhong/CQ/hg38/Mills_and_1000G_gold_standard.indels.b38.primary_assembly.vcf' >> $name.sh
echo 'id_1000g=/dev/ngs004/hhong/CQ/hg38/ALL.wgs.1000G_phase3.GRCh38.ncbi_remapper.20150424.shapeit2_indels.vcf' >> $name.sh
echo 'dbsnp=/dev/ngs004/hhong/CQ/hg38/dbsnp_146.hg38.vcf' >> $name.sh
echo '## Realignment around indels using the GATK modules RealignerTargetCreator and IndelRealigner' >> $name.sh
echo 'echo ''CREATE INTERVALS FOR LOCAL REALIGNMENT start at time'' && echo "`date`"' >> $name.sh
echo 'java -Djava.io.tmpdir=$tempdir -Xmx20g \' >> $name.sh
echo '-jar $GATK \' >> $name.sh
echo '-T RealignerTargetCreator \' >> $name.sh
echo '-R $ref \' >> $name.sh
echo '-rf BadCigar \' >> $name.sh
echo '-known $id_mills \' >> $name.sh
echo '-known $id_1000g \' >> $name.sh
echo '-nt 8 \' >> $name.sh
echo '-I $F \' >> $name.sh
echo '-log $outdir/logs/$sample.log \' >> $name.sh
echo '-o $outdir/$sample.aln.sorted.dedup.bam.forRealigner.intervals \' >> $name.sh
echo '--allow_potentially_misencoded_quality_scores' >> $name.sh
echo 'echo ''CREATE INTERVALS FOR LOCAL REALIGNMENT finish at time'' && echo "`date`"' >> $name.sh
echo '## PERFORM LOCAL REALIGNMENT' >> $name.sh
echo 'echo ''PERFORM LOCAL REALIGNMENT start at time'' && echo "`date`"' >> $name.sh
echo 'java -Djava.io.tmpdir=$outdir/tempdir -Xmx20g \' >> $name.sh
echo '-jar $GATK \' >> $name.sh
echo '-T IndelRealigner \' >> $name.sh
echo '-R $ref \' >> $name.sh
echo '-rf BadCigar \' >> $name.sh
echo '-known $id_mills \' >> $name.sh
echo '-known $id_1000g \' >> $name.sh
echo '--consensusDeterminationModel USE_READS \' >> $name.sh
echo '-compress 0 \' >> $name.sh
echo '-targetIntervals $outdir/$sample.aln.sorted.dedup.bam.forRealigner.intervals \' >> $name.sh
echo '-I $F \' >> $name.sh
echo '-o $outdir/$sample.aln.sorted.dedup.realigned.bam \' >> $name.sh
echo '-log $outdir/logs/$sample.log \' >> $name.sh
echo '--allow_potentially_misencoded_quality_scores' >> $name.sh
echo 'echo ''PERFORM LOCAL REALIGNMENT finish at time'' && echo "`date`"' >> $name.sh
echo '## BASE RECALIBRATO' >> $name.sh
echo 'echo ''BASE RECALIBRATO start at time'' && echo "`date`"' >> $name.sh
echo 'java -Djava.io.tmpdir=$outdir/tempdir -Xmx20g \' >> $name.sh
echo '-jar $GATK \' >> $name.sh
echo '-T BaseRecalibrator \' >> $name.sh
echo '-R $ref \' >> $name.sh
echo '--disable_indel_quals \' >> $name.sh
echo '-rf BadCigar \' >> $name.sh
echo '-knownSites $dbsnp \' >> $name.sh
echo '-knownSites $id_mills \' >> $name.sh
echo '-knownSites $id_1000g \' >> $name.sh
echo '-nct 8 \' >> $name.sh
echo '-I $outdir/$sample.aln.sorted.dedup.realigned.bam \' >> $name.sh
echo '-o $outdir/$sample.recal_data.grp \' >> $name.sh
echo '-log $outdir/logs/$sample.log' >> $name.sh
echo 'echo ''BASE RECALIBRATO finish at time'' && echo "`date`"' >> $name.sh
echo '## APPLY RECALIBRATION (PRINT READS)' >> $name.sh
echo 'echo ''APPLY RECALIBRATION start at time'' && echo "`date`"' >> $name.sh
echo 'java -Djava.io.tmpdir=$outdir/tempdir -Xmx20g \' >> $name.sh
echo '-jar $GATK \' >> $name.sh
echo '-T PrintReads \' >> $name.sh
echo '-R $ref \' >> $name.sh
echo '-rf BadCigar \' >> $name.sh
echo '-BQSR $outdir/$sample.recal_data.grp \' >> $name.sh
echo '-nct 8 \' >> $name.sh
echo '-I $outdir/$sample.aln.sorted.dedup.realigned.bam \' >> $name.sh
echo '-o $outdir/$sample.aln.sorted.dedup.realigned.recal.bam \' >> $name.sh
echo '--allow_potentially_misencoded_quality_scores \' >> $name.sh
echo '-log $outdir/logs/$sample.log' >> $name.sh
echo 'echo ''APPLY RECALIBRATION finish at time'' && echo "`date`"' >> $name.sh
echo '## remove middle results' >> $name.sh
echo 'rm $outdir/$sample.recal_data.grp' >> $name.sh
echo 'rm $outdir/$sample.aln.sorted.dedup.realigned.bai' >> $name.sh
echo 'rm $outdir/$sample.aln.sorted.dedup.realigned.bam' >> $name.sh
echo 'rm $outdir/$sample.aln.sorted.dedup.bam.forRealigner.intervals' >> $name.sh
echo 'cp $outdir/'$name'.aln.sorted.dup.RG.bai $outdir/'$name'.aln.sorted.dup.RG.bam.bai' >> $name.sh
echo 'cp $outdir/'$name'.aln.sorted.dedup.realigned.recal.bai $outdir/'$name'.aln.sorted.dedup.realigned.recal.bam.bai' >> $name.sh
echo '## SNV calling' >> $name.sh
echo 'mkdir $outdir/'$name'_G' >> $name.sh
echo '# GATK HaplotypeCaller' >> $name.sh 
echo 'echo ''GATK HaplotypeCaller start at time'' && echo "`date`"' >> $name.sh
echo 'java -Djava.io.tmpdir=$tempdir -Xmx40g \' >> $name.sh
echo '-jar $GATK \' >> $name.sh
echo '-T HaplotypeCaller \' >> $name.sh
echo '-R $ref \' >> $name.sh
echo '-rf BadCigar \' >> $name.sh
echo '--dbsnp $dbsnp \' >> $name.sh
echo '-stand_call_conf 30 \' >> $name.sh
echo '-I $outdir/'$name'.aln.sorted.dup.RG.bam \' >> $name.sh
echo '-o $outdir/'$name'.HC.raw.vcf' >> $name.sh
echo 'echo ''GATK HaplotypeCaller finish at time'' && echo "`date`"' >> $name.sh
echo '#########################' >> $name.sh
echo 'echo ''GATK HaplotypeCaller start at time'' && echo "`date`"' >> $name.sh
echo 'java -Djava.io.tmpdir=$tempdir -Xmx40g \' >> $name.sh
echo '-jar $GATK \' >> $name.sh
echo '-T HaplotypeCaller \' >> $name.sh
echo '-R $ref \' >> $name.sh
echo '-rf BadCigar \' >> $name.sh
echo '--dbsnp $dbsnp \' >> $name.sh
echo '-stand_call_conf 30 \' >> $name.sh
echo '-I $outdir/'$name'.aln.sorted.dedup.realigned.recal.bam \' >> $name.sh
echo '-o $outdir/'$name'.HC.GATK.raw.vcf' >> $name.sh
echo 'echo ''GATK HaplotypeCaller finish at time'' && echo "`date`"' >> $name.sh
echo '# Samtools calling' >> $name.sh
echo 'echo ''samtools mpileup start at time'' && echo "`date`"' >> $name.sh
echo 'samtools mpileup -ugf $ref $outdir/'$name'.aln.sorted.dup.RG.bam | bcftools call -vmO v -o $outdir/$sample.Samtools.raw.vcf && echo This-Work-is-Done!' >> $name.sh
echo 'echo ''samtools mpileup finish at time'' && echo "`date`"' >> $name.sh
echo '#########################' >> $name.sh
echo 'echo ''samtools mpileup start at time'' && echo "`date`"' >> $name.sh
echo 'samtools mpileup -ugf $ref $outdir/'$name'.aln.sorted.dedup.realigned.recal.bam | bcftools call -vmO v -o $outdir/$sample.Samtools.GATK.raw.vcf && echo This-Work-is-Done!' >> $name.sh
echo 'echo ''samtools mpileup finish at time'' && echo "`date`"' >> $name.sh
echo '# Varscan calling' >> $name.sh
echo 'echo ''Varscan calling start at time'' && echo "`date`"' >> $name.sh
echo 'samtools mpileup -B -f $ref $outdir/'$name'.aln.sorted.dup.RG.bam | java -Djava.io.tmpdir=$tempdir -Xmx40g -jar $VarScan mpileup2cns --p-value 0.05 --variants 1 --output-vcf 1 > $outdir/'$name'.Varscan.raw.vcf' >> $name.sh
echo 'echo ''Varscan calling finish at time'' && echo "`date`"' >> $name.sh
echo '#########################' >> $name.sh
echo 'echo ''Varscan calling start at time'' && echo "`date`"' >> $name.sh
echo 'samtools mpileup -B -f $ref $outdir/'$name'.aln.sorted.dedup.realigned.recal.bam | java -Djava.io.tmpdir=$tempdir -Xmx40g -jar $VarScan mpileup2cns --p-value 0.05 --variants 1 --output-vcf 1 > $outdir/'$name'.Varscan.GATK.raw.vcf' >> $name.sh
echo 'echo ''Varscan calling finish at time'' && echo "`date`"' >> $name.sh
echo '# SNVer calling' >> $name.sh
echo 'echo ''SNVer start at time'' && echo "`date`"' >> $name.sh
echo 'java -Djava.io.tmpdir=$tempdir -Xmx40g \' >> $name.sh
echo '-jar $SNVer \' >> $name.sh
echo '-i $outdir/'$name'.aln.sorted.dup.RG.bam \' >> $name.sh
echo '-r $ref \' >> $name.sh
echo '-o $outdir/'$name' \' >> $name.sh
echo '-p 0.05' >> $name.sh 
echo 'echo ''SNVer finish at time'' && echo "`date`"' >> $name.sh
echo '#########################' >> $name.sh
echo 'echo ''SNVer start at time'' && echo "`date`"' >> $name.sh
echo 'java -Djava.io.tmpdir=$tempdir -Xmx40g \' >> $name.sh
echo '-jar $SNVer \' >> $name.sh
echo '-i $outdir/'$name'.aln.sorted.dedup.realigned.recal.bam \' >> $name.sh
echo '-r $ref \' >> $name.sh
echo '-o $outdir/'$name'_G \' >> $name.sh
echo '-p 0.05' >> $name.sh 
echo 'echo ''SNVer finish at time'' && echo "`date`"' >> $name.sh
echo '# FreeBayes' >> $name.sh
echo 'echo ''FreeBayes caller start at time'' && echo "`date`"' >> $name.sh
echo '$FreeBayes -f $ref -X -u -v $outdir/'$name'.FreeBayes.raw.vcf $outdir/'$name'.aln.sorted.dup.RG.bam' >> $name.sh
echo 'echo ''FreeBayes caller finish at time'' && echo "`date`"' >> $name.sh
echo '#########################' >> $name.sh
echo 'echo ''FreeBayes caller start at time'' && echo "`date`"' >> $name.sh
echo '$FreeBayes -f $ref -X -u -v $outdir/'$name'.FreeBayes.GATK.raw.vcf $outdir/'$name'.aln.sorted.dedup.realigned.recal.bam' >> $name.sh
echo 'echo ''FreeBayes caller finish at time'' && echo "`date`"' >> $name.sh
echo '# ISAAC caller' >> $name.sh
echo 'echo ''ISAAC calling start at time'' && echo "`date`"' >> $name.sh
echo '$issac_caller --BAM=$outdir/'$name'.aln.sorted.dup.RG.bam --ref=$ref --config=$config_file --output-dir=$outdir/myAnalysis' >> $name.sh
echo 'cd $outdir/myAnalysis' >> $name.sh
echo 'make -j 8' >> $name.sh
echo 'echo ''ISAAC calling finish at time'' && echo "`date`"' >> $name.sh
echo 'gzip -dc $outdir/myAnalysis/results/'$name'.aln.sorted.dup.RG.genome.vcf.gz | extract_variants > $outdir/'$name'.ISAAC.raw.vcf' >> $name.sh
echo '#########################' >> $name.sh
echo 'echo ''ISAAC calling start at time'' && echo "`date`"' >> $name.sh
echo '$issac_caller --BAM=$outdir/'$name'.aln.sorted.dedup.realigned.recal.bam --ref=$ref --config=$config_file --output-dir=$outdir/myAnalysis' >> $name.sh
echo 'cd $outdir/myAnalysis' >> $name.sh
echo 'make -j 8' >> $name.sh
echo 'echo ''ISAAC calling finish at time'' && echo "`date`"' >> $name.sh
echo 'gzip -dc $outdir/myAnalysis/results/'$name'.aln.sorted.dedup.realigned.recal.genome.vcf.gz | extract_variants > $outdir/'$name'.ISAAC.GATK.raw.vcf' >> $name.sh
done 
