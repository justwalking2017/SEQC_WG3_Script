# Methods for alignment and variant calling SEQC2 data using RTG Core

The following describes the processing used to align and call samples using RTG alignment and variant calling algorithms. Particular groups of files used for calling depends on the particular replicates being run so below we describe the RTG commands used to produce alignments ready for calling, and example variant calling commands for the different scenarios.

## Preprocessing of raw FASTQ files

All FASTQs underwent quality-based filtering to trim off poor quality read ends (using `rtg fastqtrim` --end-quality-threshold 15) and formatting to the RTG SDF format (which allows random access to arbitrary chunks of reads during mapping) using `rtg format`. FASTQ file pairs for each replicate were merged to a single per-replicate SDF and assigned a unique read group. An example formatting command line to merge, fastqtrim and format a single replicate follows:

    rtg format -f fastq -o NA12878-r1-H3WNJDSXX_S8.sdf \
         -l <(find $FASTQ_DIR -name "e00093-NA12878-r1-H3WNJDSXX_S8_L*R1_001.fastq.gz" | sort | xargs zcat | rtg fastqtrim -E 15 -o - -i -) \
         -r <(find $FASTQ_DIR -name "e00093-NA12878-r1-H3WNJDSXX_S8_L*R2_001.fastq.gz" | sort | xargs zcat | rtg fastqtrim -E 15 -o - -i -) \
         --sam-rg '@RG\tID:NA12878-r1-H3WNJDSXX_S8\tSM:NA12878\tPL:ILLUMINA'


## Alignment to reference genome

Alignment of the reads for each sample to the reference genome was via `rtg map`, processing reads from the input SDF file in chunks to permit partitioning of the alignment across multiple nodes. A typical chunk size was 40 million read pairs. During alignment, an appropriate pedigree file was supplied to the mapping command to allow the aligner to lookup the sex of the sample.

    rtg map -i NA12878-r1-H3WNJDSXX_S8.sdf -t GRCh38.d1.vd1.sdf \
        -o map_NA12878-r1-H3WNJDSXX_S8.sdf_000000000_039999999 \
        --tempdir /tmp_grid --start-read 0 --end-read 40000000 \
        --repeat-freq 95% --orientation fr --pedigree pedigree.ped

After primary alignment, an additional mate-pair rescue tool (currently in development) was executed on any reads which were unmapped but for which the other arm of the pair was uniquely mapped, and any rescued alignments were included in subsequent variant calling.


## Variant calling

Across the various samples and families in the SEQC2 project several variant calling modes were employed. When calling a single sample in isolation, the `rtg snp` command was used, for example:

    rtg snp -t GRCh38.d1.vd1.sdf \
        -T 8 --pedigree pedigree.ped \
        --enable-allelic-fraction --XXcom.rtg.variant.mask-homopolymer=true \
        -o snp_NA12878-r1-H3WNJDSXX_S8 \
        map_NA12878-r1-H3WNJDSXX_S8.sdf_*/alignments.bam

The final argument supplies all the alignment BAMs corresponding to the particular sample (or, during joint callint, multiple samples) being called.

When joint variant calling multiple samples within a family, the `rtg family` command was used, in order to incorporate mendelian inheritance into the calling, for example:

    rtg family -t GRCh38.d1.vd1.sdf \
        -T 8 --pedigree pedigree.ped \
        --enable-allelic-fraction --XXcom.rtg.variant.mask-homopolymer=true
        -o family_hapmap_trio \
        map_hapmap_trio*/alignments.bam

## Replicate calling and post-calling analysis

Analysis of Mendelian inheritance errors were computed using `rtg mendelian`. Overall variant statistics for each sample were computed using `rtg vcfstats`. For more details, see the accompanying README files for each group of variant call sets.

