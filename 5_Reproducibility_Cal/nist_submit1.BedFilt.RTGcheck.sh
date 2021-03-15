for i in ARD ; do for j in NIST8398; do qsub -l hostname=ncshpc203 rtg_vcfilter.ByBed.nist.RTG.sh RTG RTG $i $j; sleep 2; done; done
