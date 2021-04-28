#install.packages("devtools")
#devtools::install_github("Illumina/happyCompare")
#devtools::install_github("Illumina/happyR")
#install.packages("magrittr")
library(magrittr)
library("happyR")
library("happyCompare")
library(dplyr)
library(ggplot2)
cbbPalette <- c("#000000", "#E69F00", "#56B4E9", "#009E73", "#F0E442", "#0072B2", "#D55E00", "#CC79A7")

# happy_input <- system.file("/Applications/bioinfo/happyCompare/tests/data/pcrfree_vs_nano/filtered_happy/", "NA12878-I30_S1.summary.csv", package = "happyR")
# happy_prefix <- sub(".summary.csv", "", happy_input)
# 
# # happy_prefix is the -o argument to hap.py, here: path/to/files/happy_demo
# hapdata <- read_happy("/Applications/bioinfo/happyCompare/tests/data/pcrfree_vs_nano/filtered_happy/NA12878-I30_S1")
# #> Reading summary table
# #> Reading extended table
# #> Reading precision-recall curve data
# hapdata

happy_compare <- read_samplesheet("/Users/jzook/Documents/OneDrive - National Institute of Standards and Technology (NIST)/MyPapers/SEQC2_WG3_germline/seqc2.csv", lazy = TRUE)
sapply(happy_compare, class)
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

ggplot(data=hdi_recall[hdi_recall$replicate_id==".aggregate",],aes(x=Subset,y=1-observed_p))+geom_point(stat="identity",size=3 ) +
  geom_errorbar(aes(ymin=1-lower, ymax=1-upper), width=.4,
                position=position_dodge(0.05))+ scale_y_continuous(trans='log10', limits=c(.0001, 1.3))+theme_grey(base_size = 22)+ylab("False Negative Rate vs. GIABv4.0") + coord_flip()+scale_fill_manual(values=cbbPalette) + facet_grid( Type ~ Group.Id, scales = "free_y")

hdi_precision <- extract_metrics(happy_compare, table = "extended") %>% 
  filter(Subtype == "*", Filter == "PASS", Subset.Level >= 0, 
         Subset %in% c("*","SimpleRepeat_homopolymer_gt11_slop5", "alldifficultregions","alllowmapandsegdupregions","notinalldifficultregions","notinalllowmapandsegdupregions")) %>% 
  estimate_hdi(successes_col = "QUERY.TP", totals_col = "QUERY.TOTAL", 
               group_cols = c("Group.Id", "Subset", "Type"), aggregate_only = TRUE)

ggplot(data=hdi_precision[hdi_precision$replicate_id==".aggregate" & hdi_precision$Group.Id=="NoHRbed",],aes(x=Subset,y=1-observed_p))+geom_point(stat="identity",size=3 ) +
  geom_errorbar(aes(ymin=1-lower, ymax=round(1-upper,digits=5)), width=.4,
                position=position_dodge(0.05))+ scale_y_continuous(trans='log10')+theme_grey(base_size = 22)+ylab("False Positive Rate vs. GIABv4.0") + coord_flip()+scale_fill_manual(values=cbbPalette) + facet_grid( Type ~ . , scales = "free_y")
