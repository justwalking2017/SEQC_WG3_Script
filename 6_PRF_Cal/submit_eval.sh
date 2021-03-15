for i in Bowtie2 BWA ISAAC stampy;do 
for j in FreeBayes HC Strelka Samtools SNVer Varscan;do  
for k in ILM; do 
for l in A C D LCL5 LCL6 LCL7 LCL8 ; do
qsub -l hostname=ncshpc204 rtg_vcfeval.vsHR.sh $i $j $k $l 
sleep 2 
done 
done 
done 
done
