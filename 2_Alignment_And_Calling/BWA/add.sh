#!/bin/sh
for name in WUX_LCL5_1 WUX_LCL5_2 WUX_LCL5_3 WUX_LCL6_1 WUX_LCL6_2 WUX_LCL6_3 WUX_LCL7_1 WUX_LCL7_2 WUX_LCL7_3 WUX_LCL8_1 WUX_LCL8_2 WUX_LCL8_3;do
outdir=/dev/ngs004/hhong/CQ/wf/BWA/$name
cp $outdir/$name.aln.sorted.dup.RG.bai $outdir/$name.aln.sorted.dup.RG.bam.bai
cp $outdir/$name.aln.sorted.dedup.realigned.recal.bai $outdir/$name.aln.sorted.dedup.realigned.recal.bam.bai
done