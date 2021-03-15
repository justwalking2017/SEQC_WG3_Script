#!/bin/sh
#
#$ -N repsnv_cnt
#$ -S /bin/bash
#$ -cwd
#$ -j y
#$ -pe hostcore 4
#$ -R y
#$ -o /dev/ngs005/scratch/hhong/rep_repro_analysis/CQ/17_snvGT-CS_1119/8_bedtools_allInOneMrg/bedtools.multiinter.log

## set path
export JAVA_HOME=/storage2/bgong/tools/jdk1.8.0_91 # JAVA version (build 1.8.0_91-b14)
export ztools=/storage2/zliu/bin
#export bedtools=/storage2/zliu/bin/bedtools2/bin
export bedtools=/dev/ngs002/hhong/bin/bedtools

# export tools
export bowtie=$ztools/bowtie2-2.2.9
export PICARD=$ztools/picard-2.7.1/picard.jar
export FreeBayes=$ztools/freebayes
config_file=$ztools/isaac_variant_caller-1.0.7/etc/ivc_config_default_wgs.ini
issac_caller=$ztools/isaac_variant_caller-1.0.7/bin/configureWorkflow.pl
GATK=$ztools/GATK3.7/GenomeAnalysisTK.jar
bcftools=$ztools/bcftools-1.3.1
samtools=$ztools/samtools-1.3.1
VarScan=$ztools/VarScan-2.3.9/VarScan.v2.3.9.jar
SNVer=$ztools/SNVer-0.5.3/SNVerIndividual.jar
export mybin=$bedtools:$JAVA_HOME/bin:$ztools/bowtie2-2.2.9:$ztools/GATK3.7:$ztools/bcftools-1.3.1:$ztools/samtools-1.3.1:$ztools/SNVer-0.5.3:$ztools/isaac_variant_caller-1.0.7/etc:$ztools/isaac_variant_caller-1.0.7/bin:$ztools/gvcftools-0.14/bin
export PATH=$bedtools:$mybin:/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:/sbin:$PATH

sourcedir=/dev/ngs005/scratch/hhong/rep_repro_analysis/CQ/17_snvGT-CS_1119/7_bedtools_alignOut
outdir=/dev/ngs005/scratch/hhong/rep_repro_analysis/CQ/17_snvGT-CS_1119/8_bedtools_allInOneMrg
outdir2=/dev/ngs005/scratch/hhong/rep_repro_analysis/CQ/11_filt_combine/3_labsMerged
##Create environment variable with names of processed vcf files and make union vcf using vcflib vcfcombine
##The union vcf has a column corresponding to the genotype call from each vcf

#export LD_LIBRARY_PATH=/usr/local/lib64/:$LD_LIBRARY_PATH
bedtools multiinter -i $sourcedir/"$1"_HC_8alignCS_3labCS_3repCS.sort.vcf $sourcedir/"$1"_sentieon_sentieon_3labCS_3repCS.sort.vcf $sourcedir/"$1"_FreeBayes_8alignCS_3labCS_3repCS.sort.vcf $sourcedir/"$1"_Samtools_8alignCS_3labCS_3repCS.sort.vcf $sourcedir/"$1"_SNVer_8alignCS_3labCS_3repCS.sort.vcf $sourcedir/"$1"_Varscan_8alignCS_3labCS_3repCS.sort.vcf  $sourcedir/"$1"_RTG_RTG_3labCS_3repCS.sort.vcf $sourcedir/"$1"_ISAAC_8alignCS_3labCS_3repCS.sort.vcf   >$outdir/"$1"_callerMrg_alignerMrg_labMrg_repMrg.txt

#perl $outdir/callerVcfFetch_vcfV.update1130.pl $outdir/"$1"_callerMrg_alignerMrg_labMrg_repMrg.txt $1
perl $outdir/callerVcfFetch_vcfV.update1203.v3.pl $outdir/"$1"_callerMrg_alignerMrg_labMrg_repMrg.txt $1
perl /dev/ngs001/bpan/bin/GIAB_bin/vcfsorter.pl /dev/ngs004/hhong/CQ/hg38/hg38.dict $outdir/"$1"_8callerCS_8alignCS_3labCS_3repCS.vcf >$outdir/"$1"_8callerCS_8alignCS_3labCS_3repCS.sort.vcf








