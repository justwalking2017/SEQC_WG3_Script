for i in Bowtie2 BWA ISAAC stampy; do  for j in FreeBayes HC ISAAC Samtools SNVer Varscan; do for k in LCL5 ; do qsub -l hostname=ncshpc206 fetchVCFbyPerl.GATK.sh $i $j $k ; sleep 2; done; done done

for i in Bowtie2 BWA ISAAC stampy; do  for j in FreeBayes HC ISAAC Samtools SNVer Varscan; do for k in LCL5 ; do qsub -l hostname=ncshpc204 fetchVCFbyPerl.noGATK.sh $i $j $k ; sleep 2; done; done done


for i in LCL5; do qsub -l hostname=ncshpc206 fetchVCFbyPerl.noGATK.sh RTG RTG $i; sleep 2; done

for i in LCL5; do qsub -l hostname=ncshpc206 fetchVCFbyPerl.noGATK.sh sentieon sentieon $i; sleep 2; done 


