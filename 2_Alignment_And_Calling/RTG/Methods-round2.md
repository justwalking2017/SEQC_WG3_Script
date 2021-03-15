# RTG variant calls for SEQC2 HapMap trio and Chinese quartet (NovaSeq edition)

This folder contains VCFs produced by the RTG alignment and variant
calling available in [RTG Core](http://realtimegenomics.com/products/rtg-core)
on the SEQC2 sequencing datasets based on Illumina NovaSeq sequencing.
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
GRCh38.d1.vd1 Reference Sequence from NCBI. These are available in the
`hapmap_trio_grch38` subdirectory.

Variant calls are provided from the pedigree-aware RTG family caller
(`rtg family`), for each of the technical replicates separately, plus
one call set utilizing the data from all three replicates. The exact
datasets used in these replicates are:

"replicate 1":

    hapmap-son    13283-SEQC2-WG3-wellA1-A4_S1  ~68X
    hapmap-father 13283-SEQC2-WG3-wellB1-C1_S2  ~60X
    hapmap-mother 13283-SEQC2-WG3-wellC1-D1_S3  ~49X

"replicate 2":

    hapmap-son    13283-SEQC2-WG3-wellA2-A4_S8  ~58X
    hapmap-father 13283-SEQC2-WG3-wellB2-C1_S9  ~40X
    hapmap-mother 13283-SEQC2-WG3-wellC2-D1_S10 ~51X

"replicate 3":

    hapmap-son    13283-SEQC2-WG3-wellA3-A4_S15 ~55X
    hapmap-father 13283-SEQC2-WG3-wellB3-C1_S16 ~45X
    hapmap-mother 13283-SEQC2-WG3-wellC3-D1_S17 ~50X

"replicate all" combines the above three datasets (i.e. ~150x coverage
per sample).

An example commandline for filtering one of these trio sets to identify
putative de novo variants by selecting sites where both parents are REF
and the son is called as a de novo with relatively high de novo score is
something like:

    rtg vcffilter -i trio_in.vcf.gz -o trio_de_novos_out.vcf.gz --keep-expr '"hapmap-son".DN=="Y"&&"hapmap-son".DNP>30&&"hapmap-father".GT=="0/0"&&"hapmap-mother".GT=="0/0"'

BAMs (including indexes and RTG calibration data files) are provided for
the GRCh38 dataset.


## Chinese quartet

All variant calling was against the primary chromosomes of the
GRCh38.d1.vd1 Reference Sequence from NCBI. Analysis is provided in the
`quartet_grch38` subdirectory.

For the quartet, all call sets used the pedigree-aware RTG family caller
(`rtg family`). The two daughter samples (LCL5 and LCL6) were treated as
regular offspring of the parents (i.e. without any knowledge that they
are twins). Several call sets are provided from the various replicates
in different combinations:

"replicate 1":

    LCL5  13283-SEQC2-WG3-wellD1-5_S4  ~58X
    LCL6  13283-SEQC2-WG3-wellE1-6_S5  ~52X
    LCL7  13283-SEQC2-WG3-wellF1-7_S6  ~51X
    LCL8  13283-SEQC2-WG3-wellG1-8_S7  ~44X

"replicate 2":

    LCL5  13283-SEQC2-WG3-wellD2-5_S11  ~52X
    LCL6  13283-SEQC2-WG3-wellE2-6_S12  ~57X
    LCL7  13283-SEQC2-WG3-wellF2-7_S13  ~56X
    LCL8  13283-SEQC2-WG3-wellG2-8_S14  ~48X

"replicate 3":

    LCL5  13283-SEQC2-WG3-wellD3-5_S18  ~41X
    LCL6  13283-SEQC2-WG3-wellE3-6_S19  ~37X
    LCL7  13283-SEQC2-WG3-wellF3-7_S20  ~42X
    LCL8  13283-SEQC2-WG3-wellG3-8_S21  ~41X

"replicate all" combines the above three datasets (i.e.: ~150x coverage
per sample)

BAMs (including indexes and RTG calibration data files) are provided for
the GRCh38 dataset.


## Summary Statistics

Also included is a directory `vcfstats-and-mendelian-output` which
contains the summary statistics obtained by running `rtg vcfstats` and
`rtg mendelian` on each VCF file. Brief summary metrics are:

### Hapmap Trio

````
                 Total   Mother   Father      Son  Ti/Tv  Phased  MIE rate
replicate_1    6025480  4579829  4550572  4563222   1.98   89.1%   0.24%
replicate_2    6044014  4602252  4564726  4576031   1.98   89.2%   0.18%
replicate_3    6045304  4602601  4565467  4575665   1.98   89.2%   0.18%
replicate_all  6078848  4627382  4595122  4602284   1.97   89.4%   0.29%
````

### Chinese Quartet

````
                 Total     LCL7     LCL8     LCL5     LCL6  Ti/Tv  Phased  MIE rate
replicate_1    5875204  4559153  4584576  4589214  4589368   1.98   92.3%   0.06%
replicate_2    5881989  4564116  4590209  4593667  4594061   1.98   92.3%   0.07%
replicate_3    5861169  4546075  4573169  4576008  4575388   1.98   92.3%   0.05%
replicate_all  5925152  4603432  4629321  4631201  4631377   1.96   92.5%   0.13%
````



