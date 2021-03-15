cat pairlist.aligner.txt | while read line; do for i in ARD_NIST8398_1 ARD_NIST8398_2 ARD_NIST8398_3 ; do for j in FreeBayes HC ISAAC Samtools SNVer stampy Varscan; do qsub -l hostname=ncshpc204 rtg_vcfeval.reproAlignerV.sh $i $j $line; sleep 2; done done done

