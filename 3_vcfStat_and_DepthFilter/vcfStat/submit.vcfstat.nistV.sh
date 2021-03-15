for i in Bowtie2 BWA ISAAC stampy;do for j in FreeBayes HC ISAAC Samtools SNVer Varscan;do  for k in ARD ; do for l in NIST8398; do qsub -l hostname=ncshpc203 rtg_vcfstat.CQ.sh $i $j $k $l; sleep 2; done done done done

for i in ARD; do for j in NIST8398; do qsub -l hostname=ncshpc203 rtg_vcfstat.CQ.sh RTG RTG $i $j; sleep 2; done; done
for i in ARD; do for j in NIST8398; do qsub -l hostname=ncshpc203 rtg_vcfstat.CQ.sh sentieon sentieon $i $j; sleep 2; done; done

