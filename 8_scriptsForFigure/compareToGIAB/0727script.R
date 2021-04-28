setwd("C:/Users/Bohu.Pan/Desktop/Project_DBB/SEQC_CQ_HP/2020-03-AddressInterConcern/Justin/03192020_SourceDataForFigureX")
happy_compare <- read_samplesheet("seqc2.csv",lazy=TRUE)
e <- extract_metrics(happy_compare, table = "summary")
extract_metrics(happy_compare, table = "summary") %>% 
  filter(Filter == "PASS") %>% 
  hc_summarise_metrics(df = ., group_cols = c("Group.Id", "Type")) %>% 
  knitr::kable()


summary <- extract_metrics(happy_compare, table = "summary")
build_metrics <- extract_metrics(happy_compare, table = "build.metrics")
merged_df <- summary %>% 
  inner_join(build_metrics)

#find credible intervals
hdi_recall <- extract_metrics(happy_compare, table = "extended") %>% 
  filter(Subtype == "*", Filter == "PASS", Subset.Level >= 0, 
         Subset %in% c("*","SimpleRepeat_homopolymer_gt11_slop5", "alldifficultregions","alllowmapandsegdupregions","notinalldifficultregions","notinalllowmapandsegdupregions")) %>% 
  estimate_hdi(successes_col = "TRUTH.TP", totals_col = "TRUTH.TOTAL", 
               group_cols = c("Group.Id", "Subset", "Type"), aggregate_only = TRUE)
str(hdi_recall)
ggplot(data=hdi_recall[hdi_recall$replicate_id==".aggregate",],aes(x=Subset,y=1-observed_p))+geom_point(stat="identity",size=3 ) +
  geom_errorbar(aes(ymin=1-lower, ymax=1-upper), width=.4,
                position=position_dodge(0.05))+ scale_y_continuous(trans='log10', limits=c(.0001, 1.3))+theme_grey(base_size = 22)+ylab("False Negative Rate vs. GIABv4.0") + coord_flip()+scale_fill_manual(values=cbbPalette) + facet_grid( Type ~ Group.Id, scales = "free_y")

##self_modification
hdi_recall$Type <- ordered(hdi_recall$Type, levels = c("SNP","INDEL"),labels=c("SNV","INDEL"))
as.factor(hdi_recall$Subset)
sourceXa<-hdi_recall[hdi_recall$replicate_id==".aggregate",]
str(sourceXa)
write.table(sourceXa, file = "SourceData_FigureXa.txt", append = FALSE, quote = FALSE, sep = "\t")


png("XA_SEQC-GIAB.07272020.png",width=16,height=10,units="in",res=600)
ggplot(data=hdi_recall[hdi_recall$replicate_id==".aggregate",],
       aes(x=Subset,y=1-observed_p,color=Group.Id))+geom_point(stat="identity",size=3 ) +
  scale_color_manual(values=c( "red", "blue"))+
  geom_errorbar(aes(ymin=1-lower, ymax=1-upper), width=0.4,size=1.2,position=position_dodge(0.05))+ 
  scale_y_continuous(trans='log10', limits=c(.0001, 1.3))+theme_grey(base_size = 22)+
  scale_x_discrete("Subset", labels = c("SimpleRepeat_homopolymer_gt11_slop5" = "SimpleRepeat_homo-\npolymer_gt11_slop5",
                                        "alllowmapandsegdupregions" = "All_low-map_and_\nsegdup_region",
                                        "notinalldifficultregions" = "Not_in_all_\ndifficult_regions",
                                        "notinalllowmapandsegdupregions" = "Not_in_all_low-map_\nand_segdup_regions",
                                        "alldifficultregions" = "All_difficult_regions",
                                        "*"="All_variants\n(no stratification)"))+
  ylab("False Negative Rate vs. GIABv4.0") + 
  xlab("")+
  coord_flip()+scale_fill_manual(values=cbbPalette) +
  facet_grid( ~Type, scales = "free_y")+
  theme_bw()+
  theme(
    legend.position=c(0.58,0.08),
    #legend.position="none",
    legend.title = element_blank(),
    strip.background =element_rect(fill="white",size=1.2),
    strip.text = element_text(colour = 'black',size=20,face = "bold"),
    legend.background = element_rect(fill="white", size=0.5, linetype="solid",colour ="black"),
    legend.text = element_text(colour="black", size = 16, face = "bold"),
    axis.ticks = element_line(colour = "black", size = 1.2),
    axis.text=element_text(size=20),
    panel.background = element_blank(),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    axis.title=element_text(size=20,face="bold"),
    axis.text.x = element_text(face="plain", color="black", 
                               size=22),
    axis.text.y = element_text(face="plain", color="black", 
                               size=22),
    panel.border = element_rect(size=1.2, color="black"),
    plot.margin = margin(1, 1.5, 1, 1, "cm")
  )
dev.off()


hdi_precision <- extract_metrics(happy_compare, table = "extended") %>% 
  filter(Subtype == "*", Filter == "PASS", Subset.Level >= 0, 
         Subset %in% c("*","SimpleRepeat_homopolymer_gt11_slop5", "alldifficultregions","alllowmapandsegdupregions","notinalldifficultregions","notinalllowmapandsegdupregions")) %>% 
  estimate_hdi(successes_col = "QUERY.TP", totals_col = "QUERY.TOTAL", 
               group_cols = c("Group.Id", "Subset", "Type"), aggregate_only = TRUE)

hdi_precision$Type <- ordered(hdi_precision$Type, levels = c("SNP","INDEL"),labels=c("SNV","INDEL"))
sourceXb<-hdi_precision[hdi_precision$replicate_id==".aggregate" & hdi_precision$Group.Id=="NoHRbed",]
str(sourceXb)
write.table(sourceXb, file = "SourceData_FigureXb.txt", append = FALSE, quote = FALSE, sep = "\t")

png("XB_SEQC-GIAB.03262020.png",width=16,height=10,units="in",res=600)
ggplot(data=hdi_precision[hdi_precision$replicate_id==".aggregate" & hdi_precision$Group.Id=="NoHRbed",],aes(x=Subset,y=1-observed_p))+
  geom_point(stat="identity",size=3 ) + 
  geom_errorbar(aes(ymin=1-lower, ymax=round(1-upper,digits=5)), width=.4,size=1.2, position=position_dodge(0.05)) + 
  scale_y_continuous(trans='log10')+theme_grey(base_size = 22)+
  scale_x_discrete("Subset", labels = c("SimpleRepeat_homopolymer_gt11_slop5" = "SimpleRepeat_homo-\npolymer_gt11_slop5",
                                        "alllowmapandsegdupregions" = "All_low-map_and_\nsegdup_region",
                                        "notinalldifficultregions" = "Not_in_all_\ndifficult_regions",
                                        "notinalllowmapandsegdupregions" = "Not_in_all_low-map_\nand_segdup_regions",
                                        "alldifficultregions" = "All_difficult_regions",
                                        "*"="All_variants\n(no stratification)")) +
  ylab("False Positive Rate vs. GIABv4.0") + coord_flip()+scale_fill_manual(values=cbbPalette) + 
  facet_grid( ~Type, scales = "free_y") +
  theme_bw()+
  theme(
    # legend.position=c(0.58,0.08),
    #legend.position="none",
    #legend.title = element_blank(),
    strip.background =element_rect(fill="white",size=1.2),
    strip.text = element_text(colour = 'black',size=20,face = "bold"),
    legend.background = element_rect(fill="white", size=0.5, linetype="solid",colour ="black"),
    legend.text = element_text(colour="black", size = 16, face = "bold"),
    axis.ticks = element_line(colour = "black", size = 1.2),
    axis.text=element_text(size=20),
    panel.background = element_blank(),
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    axis.title=element_text(size=20,face="bold"),
    axis.text.x = element_text(face="plain", color="black", 
                               size=22),
    axis.text.y = element_text(face="plain", color="black", 
                               size=22),
    panel.border = element_rect(size=1.2, color="black"),
    plot.margin = margin(1, 1.5, 1, 1, "cm"))
dev.off()
