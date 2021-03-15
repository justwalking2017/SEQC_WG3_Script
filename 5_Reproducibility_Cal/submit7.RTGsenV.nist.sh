for i in ARD_NIST8398_1 ARD_NIST8398_2 ARD_NIST8398_3 ; do for j in Bowtie2 BWA ISAAC stampy; do for k in FreeBayes HC ISAAC Samtools SNVer Varscan; do qsub -l hostname=ncshpc207 rtg_vcfeval.reproRTG_CQ.10G.sh $i $j $k ; sleep 2; done done done

