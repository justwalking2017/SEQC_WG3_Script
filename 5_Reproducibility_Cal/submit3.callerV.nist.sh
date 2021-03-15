cat pairlist.caller.txt | while read line; do for i in ARD_NIST8398_1 ARD_NIST8398_2 ARD_NIST8398_3 ; do for j in Bowtie2 BWA ; do qsub -l hostname=ncshpc203 rtg_vcfeval.reproCallerV.sh $i $j $line; sleep 2; done done done

cat pairlist.caller.txt | while read line; do for i in ARD_NIST8398_1 ARD_NIST8398_2 ARD_NIST8398_3 ; do for j in ISAAC stampy; do qsub -l hostname=ncshpc205 rtg_vcfeval.reproCallerV.sh $i $j $line; sleep 2; done done done

