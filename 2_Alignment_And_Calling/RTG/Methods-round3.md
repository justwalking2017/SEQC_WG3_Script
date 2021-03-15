# RTG variant calls for SEQC2 HapMap trio and Chinese quartet (combined edition)

This folder contains VCFs produced by the RTG alignment and variant
calling available in [RTG Core](http://realtimegenomics.com/products/rtg-core)
on the all of the SEQC2 sequencing datasets to date (more details below).

Example RTG commands listed below can also be executed using the free
utility package [RTG Tools](http://realtimegenomics.com/products/rtg-tools)

Note that RTG variant calls utilize sex-aware calling, so variant
calls on the non-PAR regions of the sex chromosomes will be haploid or
diploid depending on the sample sex. Sample sex (and pedigree where
appropriate) metadata is contained in the VCF headers, and can also be
viewed in PED format via:

    rtg pedfilter in.vcf

For the trio and quartet datasets, child calls are phased according to
parental inheritance where possible, and in such cases the GT field is
ordered such that the paternally inherited allele is first and the
maternally inherited allele is second. Putative de novo variants are
annotated in the VCF using the DN and DNP annotations, and a reasonable
set of candidate de novos for the hapmap trio can be selected with a
filter such as (adjust sample names as appropriate if attempting on one
of the quartet call sets):

    rtg vcffilter -i in.vcf -o out.vcf --keep-expr '"hapmap-son".DN=="Y" && "hapmap-son".DNP>30 && "hapmap-father".GT=="0/0" && "hapmap-mother".GT=="0/0"'

The unfiltered calls produced by the RTG variant callers aim toward high
sensitivity, allowing the user to perform subsequent filtering to
satisfy their own stringency requirements. We typically recommend
filtering using the provided RTG AVR score, which is determined by a
machine learning model that scores variants on a per sample basis. For
these SEQC2 call-sets, we have applied a moderate AVR filter using a
threshold of 0.1 (variants where any sample has AVR not meeting the
threshold will have a `AVR_0.1` FILTER status) via:

    rtg vcffilter -i in.vcf -o out.vcf --min-avr-score 0.1 --all-samples --fail "AVR_0.1"

This filter can be removed if desired, for sample using RTG Tools:

    rtg vcfsubset -i in.vcf -o out.vcf --remove-filter AVR_0.1

Ignoring this filter may be appropriate when integrating or comparing
separate call-sets. We also recommend that when performing cross-VCF
comparisons, a representation-agnostic tool such as `rtg vcfeval` or
`hap.py` be employed, in order to allow identifying cases where one
variant call set uses different representational conventions to the
other call set.


## HapMap trio

All variant calling was against the primary chromosomes of the
GRCh38.d1.vd1 Reference Sequence from NCBI. These calls are provided in
`hapmap_trio_combined_rtg-family.avr-0.1.vcf.gz`

Variant calls are provided from the pedigree-aware RTG family caller
(`rtg family`), for all of the following datasets:

    hapmap-father 13283-SEQC2-WG3-wellB1-C1_S2
    hapmap-father 13283-SEQC2-WG3-wellB2-C1_S9
    hapmap-father 13283-SEQC2-WG3-wellB3-C1_S16
    hapmap-father LP6005856-DNA_B01
    hapmap-father LP6005856-DNA_E01
    hapmap-father LP6005856-DNA_H01

    hapmap-mother 13283-SEQC2-WG3-wellC1-D1_S3
    hapmap-mother 13283-SEQC2-WG3-wellC2-D1_S10
    hapmap-mother 13283-SEQC2-WG3-wellC3-D1_S17
    hapmap-mother LP6005856-DNA_A02
    hapmap-mother LP6005856-DNA_C01
    hapmap-mother LP6005856-DNA_F01

    hapmap-son    13283-SEQC2-WG3-wellA1-A4_S1
    hapmap-son    13283-SEQC2-WG3-wellA2-A4_S8
    hapmap-son    13283-SEQC2-WG3-wellA3-A4_S15
    hapmap-son    LP6005856-DNA_A01
    hapmap-son    LP6005856-DNA_D01
    hapmap-son    LP6005856-DNA_G01

The total combined depth of coverage from these datasets is approximately
400x for each member of the trio.

An example commandline for filtering one of these trio sets to identify
putative de novo variants by selecting sites where both parents are REF
and the son is called as a de novo with relatively high de novo score is
something like:

    rtg vcffilter -i trio_in.vcf.gz -o trio_de_novos_out.vcf.gz --keep-expr '"hapmap-son".DN=="Y"&&"hapmap-son".DNP>30&&"hapmap-father".GT=="0/0"&&"hapmap-mother".GT=="0/0"'



## Chinese quartet

All variant calling was against the primary chromosomes of the
GRCh38.d1.vd1 Reference Sequence from NCBI. These calls are provided in
`quartet_combined_rtg-family.avr-0.1.vcf.gz`

For the quartet, all call sets used the pedigree-aware RTG family caller
(`rtg family`). The two daughter samples (LCL5 and LCL6) were treated as
regular offspring of the parents (i.e. without any knowledge that they
are twins). The call set provided used all of the following datasets:

    LCL5  13283-SEQC2-WG3-wellD1-5_S4
    LCL5  13283-SEQC2-WG3-wellD2-5_S11
    LCL5  13283-SEQC2-WG3-wellD3-5_S18
    LCL5  LCL5-Quartet_DNA_ILM_ARD_LCL5_1_20170403
    LCL5  LCL5-Quartet_DNA_ILM_ARD_LCL5_2_20170403
    LCL5  LCL5-Quartet_DNA_ILM_ARD_LCL5_3_20170403
    LCL5  LCL5-Quartet_DNA_ILM_NVG_LCL5_1_20170329
    LCL5  LCL5-Quartet_DNA_ILM_NVG_LCL5_2_20170329
    LCL5  LCL5-Quartet_DNA_ILM_NVG_LCL5_3_20170329
    LCL5  LCL5-Quartet_DNA_ILM_WUX_LCL5_1_20170216
    LCL5  LCL5-Quartet_DNA_ILM_WUX_LCL5_2_20170216
    LCL5  LCL5-Quartet_DNA_ILM_WUX_LCL5_3_20170216

    LCL6  13283-SEQC2-WG3-wellE1-6_S5
    LCL6  13283-SEQC2-WG3-wellE2-6_S12
    LCL6  13283-SEQC2-WG3-wellE3-6_S19
    LCL6  LCL6-Quartet_DNA_ILM_ARD_LCL6_1_20170403
    LCL6  LCL6-Quartet_DNA_ILM_ARD_LCL6_2_20170403
    LCL6  LCL6-Quartet_DNA_ILM_ARD_LCL6_3_20170403
    LCL6  LCL6-Quartet_DNA_ILM_NVG_LCL6_1_20170329
    LCL6  LCL6-Quartet_DNA_ILM_NVG_LCL6_2_20170329
    LCL6  LCL6-Quartet_DNA_ILM_NVG_LCL6_3_20170329
    LCL6  LCL6-Quartet_DNA_ILM_WUX_LCL6_1_20170216
    LCL6  LCL6-Quartet_DNA_ILM_WUX_LCL6_2_20170216
    LCL6  LCL6-Quartet_DNA_ILM_WUX_LCL6_3_20170216

    LCL7  13283-SEQC2-WG3-wellF1-7_S6
    LCL7  13283-SEQC2-WG3-wellF2-7_S13
    LCL7  13283-SEQC2-WG3-wellF3-7_S20
    LCL7  LCL7-Quartet_DNA_ILM_ARD_LCL7_1_20170403
    LCL7  LCL7-Quartet_DNA_ILM_ARD_LCL7_2_20170403
    LCL7  LCL7-Quartet_DNA_ILM_ARD_LCL7_3_20170403
    LCL7  LCL7-Quartet_DNA_ILM_NVG_LCL7_1_20170329
    LCL7  LCL7-Quartet_DNA_ILM_NVG_LCL7_2_20170329
    LCL7  LCL7-Quartet_DNA_ILM_NVG_LCL7_3_20170329
    LCL7  LCL7-Quartet_DNA_ILM_WUX_LCL7_1_20170216
    LCL7  LCL7-Quartet_DNA_ILM_WUX_LCL7_2_20170216
    LCL7  LCL7-Quartet_DNA_ILM_WUX_LCL7_3_20170216

    LCL8  13283-SEQC2-WG3-wellG1-8_S7
    LCL8  13283-SEQC2-WG3-wellG2-8_S14
    LCL8  13283-SEQC2-WG3-wellG3-8_S21
    LCL8  LCL8-Quartet_DNA_ILM_ARD_LCL8_1_20170403
    LCL8  LCL8-Quartet_DNA_ILM_ARD_LCL8_2_20170403
    LCL8  LCL8-Quartet_DNA_ILM_ARD_LCL8_3_20170403
    LCL8  LCL8-Quartet_DNA_ILM_NVG_LCL8_1_20170329
    LCL8  LCL8-Quartet_DNA_ILM_NVG_LCL8_2_20170329
    LCL8  LCL8-Quartet_DNA_ILM_NVG_LCL8_3_20170329
    LCL8  LCL8-Quartet_DNA_ILM_WUX_LCL8_1_20170216
    LCL8  LCL8-Quartet_DNA_ILM_WUX_LCL8_2_20170216
    LCL8  LCL8-Quartet_DNA_ILM_WUX_LCL8_3_20170216

The total combined depth of coverage from these datasets is approximately
460x for each member of the quartet.



## Summary Statistics

Also included is a directory `vcfstats-and-mendelian-output` which
contains the summary statistics obtained by running `rtg vcfstats` and
`rtg mendelian` on each VCF file. Brief summary metrics are:

### Hapmap Trio

Lines with `replicate_` prefix are from RTG calls based on initial
sequencing data (no NovaSeq), described previously.

Lines with `Nov_` prefix are from RTG calls based on NovaSeq data alone,
described previously.

Lines with `Combined` prefix correspond to the combined calls described
above.

````
                    Total   Mother   Father      Son  Ti/Tv  Phased  MIE rate
replicate_1       5720720  4295743  4322868  4294001   2.06   89.4%   0.19%
replicate_2       5726330  4301435  4327425  4300330   2.06   89.3%   0.19%
replicate_3       5721231  4298335  4322370  4295187   2.06   89.4%   0.20%
replicate_123     5705248  4286812  4310163  4283324   2.06   89.6%   0.29%
Nov_replicate_1   6025480  4579829  4550572  4563222   1.98   89.1%   0.24%
Nov_replicate_2   6044014  4602252  4564726  4576031   1.98   89.2%   0.18%
Nov_replicate_3   6045304  4602601  4565467  4575665   1.98   89.2%   0.18%
Nov_replicate_all 6078848  4627382  4595122  4602284   1.97   89.4%   0.29%
Combined          6063418  4610757  4580371  4583043   1.95   89.6%   0.38%
````

### Chinese Quartet

Lines with `ARD_` etc prefixes are from RTG calls based on initial
sequencing data (no NovaSeq), described previously.

Lines with `Nov_` prefix are from previous RTG calls based on NovaSeq
data alone, described previously.

Lines with `Combined` prefix correspond to the combined calls from all
data as described above.

````
                    Total     LCL7     LCL8     LCL5     LCL6  Ti/Tv  Phased  MIE rate
ARD_replicate_1   5655015  4369147  4396210  4397335  4397951   1.99   92.5%   0.04%
ARD_replicate_2   5662139  4375925  4402866  4405193  4405251   1.99   92.5%   0.04%
ARD_replicate_3   5659048  4372923  4400404  4401206  4401482   2.00   92.5%   0.04%
NVG_replicate_1   5616448  4340675  4365057  4368804  4368381   2.00   92.5%   0.04%
NVG_replicate_2   5626140  4338753  4379266  4370642  4370052   2.00   92.5%   0.04%
NVG_replicate_3   5613267  4335180  4364974  4364542  4364716   2.00   92.5%   0.04%
WUX_replicate_1   5775653  4464714  4498830  4497064  4496337   1.99   92.5%   0.04%
WUX_replicate_2   5775768  4468053  4495864  4497474  4496624   1.99   92.5%   0.03%
WUX_replicate_3   5779917  4469757  4500325  4501295  4501704   1.99   92.5%   0.03%
ARD_replicate_123 5751598  4446538  4473783  4469852  4470002   1.98   92.5%   0.10%
NVG_replicate_123 5688850  4397323  4424572  4421087  4421055   1.99   92.4%   0.11%
WUX_replicate_123 5847784  4526656  4555216  4550844  4550780   1.98   92.6%   0.12%
ARD_NVG_WUX_all   5791634  4483833  4510737  4504115  4504064   1.97   92.7%   0.23%
Nov_replicate_1   5875204  4559153  4584576  4589214  4589368   1.98   92.3%   0.06%
Nov_replicate_2   5881989  4564116  4590209  4593667  4594061   1.98   92.3%   0.07%
Nov_replicate_3   5861169  4546075  4573169  4576008  4575388   1.98   92.3%   0.05%
Nov_replicate_all 5925152  4603432  4629321  4631201  4631377   1.96   92.5%   0.13%
Combined          5916128  4597344  4623719  4622220  4622285   1.94   92.6%   0.21%
````



