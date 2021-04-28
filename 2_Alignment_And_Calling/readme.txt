Scripts for this part were aligner based, for each subfold by aligner, three types of scripts included:
	scripts for generating individual script for each sample named as "$aligner_create_job_$lab.sh"
	scripts for individual sample named with "$lab_$sampleName_$replicateOrder", e.g. ARD_LCL5_1.sh
	scripts for scripts for submission individual sample into HPC cluster, named as "qsubwork_*"

For each individual script by sample:
	exact commands for each specific aligner, multiple GATK realignment processing, 6 calling were provided in order and commented by short sentence for each simple module
	Reference information and known snp/indel databases also included
