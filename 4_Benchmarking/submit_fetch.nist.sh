for i in Bowtie2 BWA ISAAC stampy; do  for j in FreeBayes HC ISAAC Samtools SNVer Varscan; do for k in NIST8398 ; do qsub -l hostname=ncshpc207 fetchVCFbyPerl.GATK.nist.sh $i $j $k ; sleep 2; done; done done

for i in Bowtie2 BWA ISAAC stampy; do  for j in FreeBayes HC ISAAC Samtools SNVer Varscan; do for k in NIST8398 ; do qsub -l hostname=ncshpc207 fetchVCFbyPerl.noGATK.nist.sh $i $j $k ; sleep 2; done; done done


for i in NIST8398; do qsub -l hostname=ncshpc207 fetchVCFbyPerl.noGATK.nist.sh RTG RTG $i; sleep 2; done

for i in NIST8398; do qsub -l hostname=ncshpc207 fetchVCFbyPerl.noGATK.nist.sh sentieon sentieon $i; sleep 2; done 


