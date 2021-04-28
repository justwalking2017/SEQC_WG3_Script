Generate_HR_VCF/	##scripts for generating high reproducible VCF
	Three types of scripts included in this directory:
		shell scripts named with "bedtools_$factors", factors could be replicate/lab/aligner/caller, the script was used to merge multiple vcf files into one text file get the consistent information for each position at different level-by factor with Bedtools-multiinter
		perl scripts named with "$factorsVcfFetch_vcfV", factors could be replicate/lab/aligner/caller, the script fetched consistent variants according the position information from above shell script
		shell script named with "submit_*" were used for submitting kinds of tasks

Generate_HR_Bed/	##scripts for generating high reproducible Bed
		CQandNIST/	#scripts for generating HR bed for CQ and NIST sample
			shell scripts named with "callableBed_generate_*" were used for generating bed files from bam by GATK callableLoci
			shell scripts named with "all81_mrg.$sampleName.sh" were used for combine all callable bed files into one text file which indicates consisitent level[1-81] of each position.
			
		HP/	#scripts for generating HR bed for HP sample