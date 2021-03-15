grep "^SNPs" */*/AB.stat.txt >z_sum/NovaSeq1_depthFilt_CQHP_SNV.AB.txt
grep "^SNPs" */*/A.stat.txt >z_sum/NovaSeq1_depthFilt_CQHP_SNV.A.txt
grep "^SNPs" */*/B.stat.txt >z_sum/NovaSeq1_depthFilt_CQHP_SNV.B.txt
grep "^SNPs" */*/BA.stat.txt >z_sum/NovaSeq1_depthFilt_CQHP_SNV.BA.txt

grep "^Insertions" */*/AB.stat.txt >z_sum/NovaSeq1_depthFilt_CQHP_Ins.AB.txt
grep "^Insertions" */*/A.stat.txt >z_sum/NovaSeq1_depthFilt_CQHP_Ins.A.txt
grep "^Insertions" */*/B.stat.txt >z_sum/NovaSeq1_depthFilt_CQHP_Ins.B.txt
grep "^Insertions" */*/BA.stat.txt >z_sum/NovaSeq1_depthFilt_CQHP_Ins.BA.txt

grep "^Deletions" */*/AB.stat.txt >z_sum/NovaSeq1_depthFilt_CQHP_Del.AB.txt
grep "^Deletions" */*/A.stat.txt >z_sum/NovaSeq1_depthFilt_CQHP_Del.A.txt
grep "^Deletions" */*/B.stat.txt >z_sum/NovaSeq1_depthFilt_CQHP_Del.B.txt
grep "^Deletions" */*/BA.stat.txt >z_sum/NovaSeq1_depthFilt_CQHP_Del.BA.txt

paste z_sum/NovaSeq1_depthFilt_CQHP_SNV.* | awk '{print $3"\t"$6"\t"$9"\t"$12}' >z_sum/totl_NovaSeq1_depthFilt_CQHP.SNV_AB_A_BA_B.txt
paste z_sum/NovaSeq1_depthFilt_CQHP_Ins.* | awk '{print $3"\t"$6"\t"$9"\t"$12}' >z_sum/totl_NovaSeq1_depthFilt_CQHP.Ins_AB_A_BA_B.txt
paste z_sum/NovaSeq1_depthFilt_CQHP_Del.* | awk '{print $3"\t"$6"\t"$9"\t"$12}' >z_sum/totl_NovaSeq1_depthFilt_CQHP.Del_AB_A_BA_B.txt

paste z_sum/totl_NovaSeq1_depthFilt_CQHP.SNV_AB_A_BA_B.txt z_sum/totl_NovaSeq1_depthFilt_CQHP.Ins_AB_A_BA_B.txt z_sum/totl_NovaSeq1_depthFilt_CQHP.Del_AB_A_BA_B.txt >z_sum/totl_NovaSeq1_depthFilt_CQHP_SNV_Ins_Del.AB_A_BA_B.txt
