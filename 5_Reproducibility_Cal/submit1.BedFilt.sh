for i in Bowtie2 BWA ISAAC stampy;do for j in FreeBayes HC ISAAC Samtools SNVer Varscan;do  for k in ARD NVG WUX; do for l in LCL5 LCL6 LCL7 LCL8; do qsub -l hostname=ncshpc203 rtg_vcfilter.ByBed.CQ.sh $i $j $k $l; sleep 2; done done done done
 
for i in Bowtie2 BWA ISAAC stampy;do for j in FreeBayes HC ISAAC Samtools SNVer Varscan;do  for k in ARD NVG WUX; do for l in LCL5 LCL6 LCL7 LCL8; do qsub -l hostname=ncshpc206 rtg_vcfilter.ByBed.CQ.sh $i $j $k $l; sleep 2; done done done done

for i in ARD NVG WUX; do for j in LCL5 LCL6 LCL7 LCL8; do qsub -l hostname=ncshpc205 rtg_vcfilter.ByBed.CQ.sh RTG RTG $i $j; sleep 2; done; done
for i in ARD NVG WUX; do for j in LCL5 LCL6 LCL7 LCL8; do qsub -l hostname=ncshpc205 rtg_vcfilter.ByBed.CQ.sh sentieon sentieon $i $j; sleep 2; done; done
