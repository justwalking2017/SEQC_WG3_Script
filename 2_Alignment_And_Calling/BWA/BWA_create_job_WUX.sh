#!/bin/sh
for name in WUX_LCL5_1 WUX_LCL5_2 WUX_LCL5_3 WUX_LCL6_1 WUX_LCL6_2 WUX_LCL6_3 WUX_LCL7_1 WUX_LCL7_2 WUX_LCL7_3 WUX_LCL8_1 WUX_LCL8_2 WUX_LCL8_3;do
echo '#!/bin/sh' > "$name"_R.sh
echo '#' >> "$name"_R.sh
echo '#$ -N '$name'_BWA_aligner' >> "$name"_R.sh
echo '#$ -S /bin/bash' >> "$name"_R.sh
echo '#$ -cwd' >> "$name"_R.sh
echo '#$ -j y' >> "$name"_R.sh
echo '#$ -pe multicore 8' >> "$name"_R.sh
echo '#$ -R y' >> "$name"_R.sh
echo '#$ -o /dev/ngs004/hhong/CQ/wf/BWA/'$name'_R.log' >> "$name"_R.sh
echo '' >> "$name"_R.sh
echo '# datasets' >> "$name"_R.sh
echo 'sample='$name'' >> "$name"_R.sh
echo 'F01=/dev/ngs004/hhong/CQ/data/Quartet/DNA/20170216_DNA_ILM_WUX/Quartet_DNA_ILM_'$name'_20170216_R1.fastq.gz' >> "$name"_R.sh # please check data diectory
echo 'F02=/dev/ngs004/hhong/CQ/data/Quartet/DNA/20170216_DNA_ILM_WUX/Quartet_DNA_ILM_'$name'_20170216_R2.fastq.gz' >> "$name"_R.sh# please check data diectory
echo '## set path' >> "$name"_R.sh
echo 'export JAVA_HOME=/storage2/bgong/tools/jdk1.8.0_91 # JAVA version (build 1.8.0_91-b14)' >> "$name"_R.sh
echo 'export ztools=/storage2/zliu/bin' >> "$name"_R.sh
echo '' >> "$name"_R.sh
echo '# export tools' >> "$name"_R.sh
echo 'export bwa=$ztools/bwa-0.7.15' >> "$name"_R.sh
echo 'export PICARD=$ztools/picard-2.7.1/picard.jar' >> "$name"_R.sh
echo 'export FreeBayes=$ztools/freebayes' >> "$name"_R.sh
echo 'config_file=$ztools/isaac_variant_caller-1.0.7/etc/ivc_config_default_wgs.ini' >> "$name"_R.sh
echo 'issac_caller=$ztools/isaac_variant_caller-1.0.7/bin/configureWorkflow.pl' >> "$name"_R.sh
echo 'GATK=$ztools/GATK3.7/GenomeAnalysisTK.jar' >> "$name"_R.sh
echo 'bcftools=$ztools/bcftools-1.3.1' >> "$name"_R.sh
echo 'samtools=$ztools/samtools-1.3.1' >> "$name"_R.sh
echo 'VarScan=$ztools/VarScan-2.3.9/VarScan.v2.3.9.jar' >> "$name"_R.sh
echo 'SNVer=$ztools/SNVer-0.5.3/SNVerIndividual.jar' >> "$name"_R.sh
echo 'export mybin=$JAVA_HOME/bin:$ztools/bwa-0.7.15:$ztools/GATK3.7:$ztools/bcftools-1.3.1:$ztools/samtools-1.3.1:$ztools/SNVer-0.5.3:$ztools/isaac_variant_caller-1.0.7/etc:$ztools/isaac_variant_caller-1.0.7/bin:$ztools/gvcftools-0.14/bin' >> "$name"_R.sh
echo 'export PATH=$mybin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:$PATH' >> "$name"_R.sh
echo '' >> "$name"_R.sh
echo '# references genome and index' >> "$name"_R.sh
echo 'bwaindex=/dev/ngs004/hhong/CQ/hg38/BWA/hg38.fasta' >> "$name"_R.sh
echo '' >> "$name"_R.sh
echo '# create tempdir for middle results' >> "$name"_R.sh
# echo 'mkdir /dev/ngs004/hhong/CQ/wf/BWA/'$name'' >> "$name"_R.sh
echo 'outdir=/dev/ngs004/hhong/CQ/wf/BWA/'$name'' >> "$name"_R.sh
#echo 'mkdir /dev/ngs004/hhong/CQ/wf/BWA/'$name'/tempdir' >> "$name"_R.sh
echo 'tempdir=/dev/ngs004/hhong/CQ/wf/BWA/'$name'/tempdir' >> "$name"_R.sh
# echo '# BWA align' >> "$name"_R.sh
# echo 'echo ''BWA alignment start at time'' && echo "`date`"' >> "$name"_R.sh	
# echo 'bwa mem -t 8 -M $bwaindex $F01 $F02 > $outdir/$sample.aln.sam' >> "$name"_R.sh
# echo 'echo ''BWA alignment finish at time'' && echo "`date`"' >> "$name"_R.sh	
echo '' >> "$name"_R.sh
# echo '# sam file to bam file and sort' >> "$name"_R.sh
# echo 'java -Djava.io.tmpdir=$tempdir -Xmx20g -jar $PICARD SortSam \' >> "$name"_R.sh
# echo 'MAX_RECORDS_IN_RAM=7500000 \' >> "$name"_R.sh
# echo 'VALIDATION_STRINGENCY=SILENT \' >> "$name"_R.sh
# echo 'I=$outdir/$sample.aln.sam \' >> "$name"_R.sh
# echo 'O=$outdir/$sample.aln.sorted.bam \' >> "$name"_R.sh
# echo 'SORT_ORDER=coordinate' >> "$name"_R.sh
# echo '# remove temp file' >> "$name"_R.sh
# echo 'rm -rf $outdir/$sample.aln.bam' >> "$name"_R.sh
# echo '' >> "$name"_R.sh
# echo '# PCR duplicate mark' >> "$name"_R.sh
# echo 'java -Djava.io.tmpdir=$tempdir -Xmx20g -jar $PICARD MarkDuplicates \' >> "$name"_R.sh
# echo 'REMOVE_DUPLICATES=true \' >> "$name"_R.sh
# echo 'MAX_FILE_HANDLES_FOR_READ_ENDS_MAP=950 \' >> "$name"_R.sh
# echo 'VALIDATION_STRINGENCY=SILENT \' >> "$name"_R.sh
# echo 'I=$outdir/$sample.aln.sorted.bam \' >> "$name"_R.sh
# echo 'O=$outdir/$sample.aln.sorted.dup.bam \' >> "$name"_R.sh
# echo 'M=$outdir/$sample.marked_dup_metrics.txt' >> "$name"_R.sh
# echo '# remove temp file' >> "$name"_R.sh
# echo 'rm -rf $outdir/$sample.aln.sorted.bam' >> "$name"_R.sh
# echo '' >> "$name"_R.sh
# echo '# AddOrReplaceReadGroups' >> "$name"_R.sh
# echo 'java -Djava.io.tmpdir=$tempdir -Xmx20g -jar $PICARD AddOrReplaceReadGroups \' >> "$name"_R.sh
# echo 'I=$outdir/$sample.aln.sorted.dup.bam \' >> "$name"_R.sh
# echo 'O=$outdir/$sample.aln.sorted.dup.RG.bam \' >> "$name"_R.sh
# echo 'VALIDATION_STRINGENCY=SILENT \' >> "$name"_R.sh
# echo 'RGID=$sample \' >> "$name"_R.sh
# echo 'RGLB=$sample \' >> "$name"_R.sh
# echo 'RGPL=illumina \'>> "$name"_R.sh
# echo 'RGPU="HiSeq-XTen" \' >> "$name"_R.sh
# echo 'RGSM=$sample \' >> "$name"_R.sh
# echo 'CREATE_INDEX=true' >> "$name"_R.sh
# echo '# remove temp file' >> "$name"_R.sh
# echo 'rm -rf $outdir/$sample.aln.sorted.dup.bam' >> "$name"_R.sh
# echo '' >> "$name"_R.sh
echo '# GATK local realignment and recalibration' >> "$name"_R.sh
echo 'F=$outdir/$sample.aln.sorted.dup.RG.bam' >> "$name"_R.sh
echo '# ref information' >> "$name"_R.sh
echo 'ref=/dev/ngs004/hhong/CQ/hg38/hg38.fa' >> "$name"_R.sh
echo 'id_mills=/dev/ngs004/hhong/CQ/hg38/Mills_and_1000G_gold_standard.indels.b38.primary_assembly.vcf' >> "$name"_R.sh
echo 'id_1000g=/dev/ngs004/hhong/CQ/hg38/ALL.wgs.1000G_phase3.GRCh38.ncbi_remapper.20150424.shapeit2_indels.vcf' >> "$name"_R.sh
echo 'dbsnp=/dev/ngs004/hhong/CQ/hg38/dbsnp_146.hg38.vcf' >> "$name"_R.sh
# echo '## Realignment around indels using the GATK modules RealignerTargetCreator and IndelRealigner' >> "$name"_R.sh
# echo 'echo ''CREATE INTERVALS FOR LOCAL REALIGNMENT start at time'' && echo "`date`"' >> "$name"_R.sh
# echo 'java -Djava.io.tmpdir=$tempdir -Xmx20g \' >> "$name"_R.sh
# echo '-jar $GATK \' >> "$name"_R.sh
# echo '-T RealignerTargetCreator \' >> "$name"_R.sh
# echo '-R $ref \' >> "$name"_R.sh
# echo '-rf BadCigar \' >> "$name"_R.sh
# echo '-known $id_mills \' >> "$name"_R.sh
# echo '-known $id_1000g \' >> "$name"_R.sh
# echo '-nt 8 \' >> "$name"_R.sh
# echo '-I $F \' >> "$name"_R.sh
# echo '-log $outdir/logs/$sample.log \' >> "$name"_R.sh
# echo '-o $outdir/$sample.aln.sorted.dedup.bam.forRealigner.intervals \' >> "$name"_R.sh
# echo '--allow_potentially_misencoded_quality_scores' >> "$name"_R.sh
# echo 'echo ''CREATE INTERVALS FOR LOCAL REALIGNMENT finish at time'' && echo "`date`"' >> "$name"_R.sh
# echo '## PERFORM LOCAL REALIGNMENT' >> "$name"_R.sh
# echo 'echo ''PERFORM LOCAL REALIGNMENT start at time'' && echo "`date`"' >> "$name"_R.sh
# echo 'java -Djava.io.tmpdir=$outdir/tempdir -Xmx20g \' >> "$name"_R.sh
# echo '-jar $GATK \' >> "$name"_R.sh
# echo '-T IndelRealigner \' >> "$name"_R.sh
# echo '-R $ref \' >> "$name"_R.sh
# echo '-rf BadCigar \' >> "$name"_R.sh
# echo '-known $id_mills \' >> "$name"_R.sh
# echo '-known $id_1000g \' >> "$name"_R.sh
# echo '--consensusDeterminationModel USE_READS \' >> "$name"_R.sh
# echo '-compress 0 \' >> "$name"_R.sh
# echo '-targetIntervals $outdir/$sample.aln.sorted.dedup.bam.forRealigner.intervals \' >> "$name"_R.sh
# echo '-I $F \' >> "$name"_R.sh
# echo '-o $outdir/$sample.aln.sorted.dedup.realigned.bam \' >> "$name"_R.sh
# echo '-log $outdir/logs/$sample.log \' >> "$name"_R.sh
# echo '--allow_potentially_misencoded_quality_scores' >> "$name"_R.sh
# echo 'echo ''PERFORM LOCAL REALIGNMENT finish at time'' && echo "`date`"' >> "$name"_R.sh
# echo '## BASE RECALIBRATO' >> "$name"_R.sh
# echo 'echo ''BASE RECALIBRATO start at time'' && echo "`date`"' >> "$name"_R.sh
# echo 'java -Djava.io.tmpdir=$outdir/tempdir -Xmx20g \' >> "$name"_R.sh
# echo '-jar $GATK \' >> "$name"_R.sh
# echo '-T BaseRecalibrator \' >> "$name"_R.sh
# echo '-R $ref \' >> "$name"_R.sh
# echo '--disable_indel_quals \' >> "$name"_R.sh
# echo '-rf BadCigar \' >> "$name"_R.sh
# echo '-knownSites $dbsnp \' >> "$name"_R.sh
# echo '-knownSites $id_mills \' >> "$name"_R.sh
# echo '-knownSites $id_1000g \' >> "$name"_R.sh
# echo '-nct 8 \' >> "$name"_R.sh
# echo '-I $outdir/$sample.aln.sorted.dedup.realigned.bam \' >> "$name"_R.sh
# echo '-o $outdir/$sample.recal_data.grp \' >> "$name"_R.sh
# echo '-log $outdir/logs/$sample.log' >> "$name"_R.sh
# echo 'echo ''BASE RECALIBRATO finish at time'' && echo "`date`"' >> "$name"_R.sh
# echo '## APPLY RECALIBRATION (PRINT READS)' >> "$name"_R.sh
# echo 'echo ''APPLY RECALIBRATION start at time'' && echo "`date`"' >> "$name"_R.sh
# echo 'java -Djava.io.tmpdir=$outdir/tempdir -Xmx20g \' >> "$name"_R.sh
# echo '-jar $GATK \' >> "$name"_R.sh
# echo '-T PrintReads \' >> "$name"_R.sh
# echo '-R $ref \' >> "$name"_R.sh
# echo '-rf BadCigar \' >> "$name"_R.sh
# echo '-BQSR $outdir/$sample.recal_data.grp \' >> "$name"_R.sh
# echo '-nct 8 \' >> "$name"_R.sh
# echo '-I $outdir/$sample.aln.sorted.dedup.realigned.bam \' >> "$name"_R.sh
# echo '-o $outdir/$sample.aln.sorted.dedup.realigned.recal.bam \' >> "$name"_R.sh
# echo '--allow_potentially_misencoded_quality_scores \' >> "$name"_R.sh
# echo '-log $outdir/logs/$sample.log' >> "$name"_R.sh
# echo 'echo ''APPLY RECALIBRATION finish at time'' && echo "`date`"' >> "$name"_R.sh
# echo '## remove middle results' >> "$name"_R.sh
# echo 'rm $outdir/$sample.recal_data.grp' >> "$name"_R.sh
# echo 'rm $outdir/$sample.aln.sorted.dedup.realigned.bai' >> "$name"_R.sh
# echo 'rm $outdir/$sample.aln.sorted.dedup.realigned.bam' >> "$name"_R.sh
# echo 'rm $outdir/$sample.aln.sorted.dedup.bam.forRealigner.intervals' >> "$name"_R.sh
# echo '## SNV calling' >> "$name"_R.sh
# echo 'mkdir $outdir/'$name'_G' >> "$name"_R.sh
# echo '# GATK HaplotypeCaller' >> "$name"_R.sh
# echo 'echo ''GATK HaplotypeCaller start at time'' && echo "`date`"' >> "$name"_R.sh
# echo 'java -Djava.io.tmpdir=$tempdir -Xmx40g \' >> "$name"_R.sh
# echo '-jar $GATK \' >> "$name"_R.sh
# echo '-T HaplotypeCaller \' >> "$name"_R.sh
# echo '-R $ref \' >> "$name"_R.sh
# echo '-rf BadCigar \' >> "$name"_R.sh
# echo '--dbsnp $dbsnp \' >> "$name"_R.sh
# echo '-stand_call_conf 30 \' >> "$name"_R.sh
# echo '-I $outdir/'$name'.aln.sorted.dup.RG.bam \' >> "$name"_R.sh
# echo '-o $outdir/'$name'.HC.raw.vcf' >> "$name"_R.sh
# echo 'echo ''GATK HaplotypeCaller finish at time'' && echo "`date`"' >> "$name"_R.sh
# echo '#########################' >> "$name"_R.sh
# echo 'echo ''GATK HaplotypeCaller start at time'' && echo "`date`"' >> "$name"_R.sh
# echo 'java -Djava.io.tmpdir=$tempdir -Xmx40g \' >> "$name"_R.sh
# echo '-jar $GATK \' >> "$name"_R.sh
# echo '-T HaplotypeCaller \' >> "$name"_R.sh
# echo '-R $ref \' >> "$name"_R.sh
# echo '-rf BadCigar \' >> "$name"_R.sh
# echo '--dbsnp $dbsnp \' >> "$name"_R.sh
# echo '-stand_call_conf 30 \' >> "$name"_R.sh
# echo '-I $outdir/'$name'.aln.sorted.dedup.realigned.recal.bam \' >> "$name"_R.sh
# echo '-o $outdir/'$name'.HC.GATK.raw.vcf' >> "$name"_R.sh
# echo 'echo ''GATK HaplotypeCaller finish at time'' && echo "`date`"' >> "$name"_R.sh
# echo '# Samtools calling' >> "$name"_R.sh
# echo 'echo ''samtools mpileup start at time'' && echo "`date`"' >> "$name"_R.sh
# echo 'samtools mpileup -ugf $ref $outdir/'$name'.aln.sorted.dup.RG.bam | bcftools call -vmO v -o $outdir/$sample.Samtools.raw.vcf && echo This-Work-is-Done!' >> "$name"_R.sh
# echo 'echo ''samtools mpileup finish at time'' && echo "`date`"' >> "$name"_R.sh
# echo '#########################' >> "$name"_R.sh
# echo 'echo ''samtools mpileup start at time'' && echo "`date`"' >> "$name"_R.sh
# echo 'samtools mpileup -ugf $ref $outdir/'$name'.aln.sorted.dedup.realigned.recal.bam | bcftools call -vmO v -o $outdir/$sample.Samtools.GATK.raw.vcf && echo This-Work-is-Done!' >> "$name"_R.sh
# echo 'echo ''samtools mpileup finish at time'' && echo "`date`"' >> "$name"_R.sh
# echo '# Varscan calling' >> "$name"_R.sh
# echo 'echo ''Varscan calling start at time'' && echo "`date`"' >> "$name"_R.sh
# echo 'samtools mpileup -B -f $ref $outdir/'$name'.aln.sorted.dup.RG.bam | java -Djava.io.tmpdir=$tempdir -Xmx40g -jar $VarScan mpileup2cns --p-value 0.05 --variants 1 --output-vcf 1 > $outdir/'$name'.Varscan.raw.vcf' >> "$name"_R.sh
# echo 'echo ''Varscan calling finish at time'' && echo "`date`"' >> "$name"_R.sh
# echo '#########################' >> "$name"_R.sh
# echo 'echo ''Varscan calling start at time'' && echo "`date`"' >> "$name"_R.sh
# echo 'samtools mpileup -B -f $ref $outdir/'$name'.aln.sorted.dedup.realigned.recal.bam | java -Djava.io.tmpdir=$tempdir -Xmx40g -jar $VarScan mpileup2cns --p-value 0.05 --variants 1 --output-vcf 1 > $outdir/'$name'.Varscan.GATK.raw.vcf' >> "$name"_R.sh
# echo 'echo ''Varscan calling finish at time'' && echo "`date`"' >> "$name"_R.sh
# echo '# SNVer calling' >> "$name"_R.sh
# echo 'echo ''SNVer start at time'' && echo "`date`"' >> "$name"_R.sh
# echo 'java -Djava.io.tmpdir=$tempdir -Xmx40g \' >> "$name"_R.sh
# echo '-jar $SNVer \' >> "$name"_R.sh
# echo '-i $outdir/'$name'.aln.sorted.dup.RG.bam \' >> "$name"_R.sh
# echo '-r $ref \' >> "$name"_R.sh
# echo '-o $outdir/'$name' \' >> "$name"_R.sh
# echo '-p 0.05' >> "$name"_R.sh
# echo 'echo ''SNVer finish at time'' && echo "`date`"' >> "$name"_R.sh
# echo '#########################' >> "$name"_R.sh
# echo 'echo ''SNVer start at time'' && echo "`date`"' >> "$name"_R.sh
# echo 'java -Djava.io.tmpdir=$tempdir -Xmx40g \' >> "$name"_R.sh
# echo '-jar $SNVer \' >> "$name"_R.sh
# echo '-i $outdir/'$name'.aln.sorted.dedup.realigned.recal.bam \' >> "$name"_R.sh
# echo '-r $ref \' >> "$name"_R.sh
# echo '-o $outdir/'$name'_G \' >> "$name"_R.sh
# echo '-p 0.05' >> "$name"_R.sh
# echo 'echo ''SNVer finish at time'' && echo "`date`"' >> "$name"_R.sh
echo '# FreeBayes' >> "$name"_R.sh
echo 'echo ''FreeBayes caller start at time'' && echo "`date`"' >> "$name"_R.sh
echo '$FreeBayes -f $ref -X -u -v $outdir/'$name'.FreeBayes.raw.vcf $outdir/'$name'.aln.sorted.dup.RG.bam' >> "$name"_R.sh
echo 'echo ''FreeBayes caller finish at time'' && echo "`date`"' >> "$name"_R.sh
echo '#########################' >> "$name"_R.sh
echo 'echo ''FreeBayes caller start at time'' && echo "`date`"' >> "$name"_R.sh
echo '$FreeBayes -f $ref -X -u -v $outdir/'$name'.FreeBayes.GATK.raw.vcf $outdir/'$name'.aln.sorted.dedup.realigned.recal.bam' >> "$name"_R.sh
echo 'echo ''FreeBayes caller finish at time'' && echo "`date`"' >> "$name"_R.sh
# echo '# ISAAC caller' >> "$name"_R.sh
# echo 'echo ''ISAAC calling start at time'' && echo "`date`"' >> "$name"_R.sh
# echo '$issac_caller --BAM=$outdir/'$name'.aln.sorted.dup.RG.bam --ref=$ref --config=$config_file --output-dir=$outdir/myAnalysis' >> "$name"_R.sh
# echo 'cd $outdir/myAnalysis' >> "$name"_R.sh
# echo 'make -j 8' >> "$name"_R.sh
# echo 'echo ''ISAAC calling finish at time'' && echo "`date`"' >> "$name"_R.sh
# echo 'gzip -dc $outdir/myAnalysis/results/'$name'.aln.sorted.dup.RG.genome.vcf.gz | extract_variants > $outdir/'$name'.ISAAC.raw.vcf' >> "$name"_R.sh
# echo '#########################' >> "$name"_R.sh
# echo 'echo ''ISAAC calling start at time'' && echo "`date`"' >> "$name"_R.sh
# echo '$issac_caller --BAM=$outdir/'$name'.aln.sorted.dedup.realigned.recal.bam --ref=$ref --config=$config_file --output-dir=$outdir/myAnalysis' >> "$name"_R.sh
# echo 'cd $outdir/myAnalysis' >> "$name"_R.sh
# echo 'make -j 8' >> "$name"_R.sh
# echo 'echo ''ISAAC calling finish at time'' && echo "`date`"' >> "$name"_R.sh
# echo 'gzip -dc $outdir/myAnalysis/results/'$name'.aln.sorted.dedup.realigned.recal.genome.vcf.gz | extract_variants > $outdir/'$name'.ISAAC.GATK.raw.vcf' >> "$name"_R.sh
done 
