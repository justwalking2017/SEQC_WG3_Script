
This repository contains code for SEQC2#WG3 project

**Code**

    1_QC/                         ##Source codes for quality control of fastq files
    2_Alignment_And_Calling/      ##Source codes for generating pipelines for each sample and generated shell file for each sample of various pipelines
    3_vcfStat_and_DepthFilter/    ##Source codes for variant statistic by RTG tool and depth filtering by perl script 
    4_Benchmarking/               ##Source codes for make final benchmark vcf and bed files
    5_Reproducibility_Cal/        ##Source codes for calculation of reproducibility
    6_PRF_Cal/                    ##Source codes for calculation of Precision/Recal/F-score
    7_VarianceAnalysis/           ##description for detail of variance analysis

**Reference Used:**

GRCh38.d1.vd1 Reference Sequence: 

   https://gdc.cancer.gov/about-data/data-harmonization-and-generation/gdc-reference-files

Files for GATK recalibration:

 ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/technical/reference/GRCh38_reference_genome/other_mapping_resources/Mills_and_1000G_gold_standard.indels.b38.primary_assembly.vcf.gz
     
  ftp://ftp.1000genomes.ebi.ac.uk/vol1/ftp/technical/reference/GRCh38_reference_genome/other_mapping_resources/ALL.wgs.1000G_phase3.GRCh38.ncbi_remapper.20150424.shapeit2_indels.vcf.gz


ftp://gsapubftp-anonymous@ftp.broadinstitute.org/bundle/hg38/dbsnp_146.hg38.vcf.gz

**Prerequisites**
    x86_64-linux
    Java (version > jdk1.8.0_91)
    Perl (version >5.26.2)
    R (version >3.6.1)
    
    fastqc
    bowtie2-2.2.9
    bwa-0.7.15
    isaac-01.15.04.01
    stampy-1.0.29
    GATK-3.7
    picard-2.7.1
    samtools-1.3.1
    freeBayes-v1.1.0-1
    samtools-1.3.1
    bcftools-1.3.1
    bedtools-2.28.0
    SNVer-0.5.3
    Varscan.v2.3.9  
    
    

