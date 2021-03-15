#for i in Bowtie2 BWA ISAAC stampy;do for j in FreeBayes HC ISAAC Samtools SNVer Varscan;do  for l in LCL5_1 LCL5_2 LCL5_3 LCL6_1 LCL6_2 LCL6_3 LCL7_1 LCL7_2 LCL7_3 LCL8_1 LCL8_2 LCL8_3; do qsub -l hostname=ncshpc203 rtg_vcfeval.reproLabV.sh $l $i $j ; sleep 2; done done done 

#for i in Bowtie2 BWA ISAAC stampy;do for j in FreeBayes HC ISAAC Samtools SNVer Varscan;do  for l in LCL5_1 LCL5_2 LCL5_3 LCL6_1 LCL6_2 LCL6_3 LCL7_1 LCL7_2 LCL7_3 LCL8_1 LCL8_2 LCL8_3; do qsub -l hostname=ncshpc206 rtg_vcfeval.reproLabV.sh $l $i $j ; sleep 2; done done done

for i in LCL5_1 LCL5_2 LCL5_3 LCL6_1 LCL6_2 LCL6_3 LCL7_1 LCL7_2 LCL7_3 LCL8_1 LCL8_2 LCL8_3; do qsub -l hostname=ncshpc206 rtg_vcfeval.reproLabV.sh $i RTG RTG ; sleep 2; done
for i in LCL5_1 LCL5_2 LCL5_3 LCL6_1 LCL6_2 LCL6_3 LCL7_1 LCL7_2 LCL7_3 LCL8_1 LCL8_2 LCL8_3; do qsub -l hostname=ncshpc206 rtg_vcfeval.reproLabV.sh $i sentieon sentieon ; sleep 2; done

