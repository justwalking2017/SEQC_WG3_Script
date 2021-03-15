# RTG variant calls for SEQC2 HapMap trio, NIST8398 and Chinese quartet

This folder contains VCFs produced by the RTG alignment and variant calling
available in [RTG Core](http://realtimegenomics.com/products/rtg-core)
on the SEQC2 sequencing datasets. Example RTG commands listed below can
also be executed using the free utility package
[RTG Tools](http://realtimegenomics.com/products/rtg-tools)

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

The HapMap trio has been processed against both the UCSC hg19 reference
from the GATK hg19 bundle, with calling made to the primary chromosomes,
as well as the GRCh38.d1.v1 Reference Sequence from NCBI. These are
available in the subdirectories `hapmap_trio_hg19` and `hapmap_trio_grch38`,
respectively.

Variant calls are provided from the pedigree-aware RTG family caller
(`rtg family`), for each of the technical replicates separately, plus
one call set utilizing the data from all three replicates. The exact
datasets used in these replicates are:

"replicate 1":

    hapmap-father LP6005856-DNA_B01
    hapmap-mother LP6005856-DNA_C01
    hapmap-son LP6005856-DNA_A01

"replicate 2":

    hapmap-father LP6005856-DNA_E01
    hapmap-mother LP6005856-DNA_F01
    hapmap-son-LP6005856-DNA_D01

"replicate 3":

    hapmap-father LP6005856-DNA_H01
    hapmap-mother LP6005856-DNA_A02
    hapmap-son LP6005856-DNA_G01

"replicate 123" combines the above three datasets giving ~230x coverage
per sample.

An example commandline for filtering one of these trio sets to identify
putative de novo variants by selecting sites where both parents are REF
and the son is called as a de novo with relatively high de novo score is
something like:

    rtg vcffilter -i trio_in.vcf.gz -o trio_de_novos_out.vcf.gz --keep-expr '"hapmap-son".DN=="Y"&&"hapmap-son".DNP>30&&"hapmap-father".GT=="0/0"&&"hapmap-mother".GT=="0/0"'

BAMs (including indexes and RTG calibration data files) are provided for
the GRCh38 dataset.


## NIST8398

All calling was against the primary chromosomes of the GRCh38.d1.vd1
Reference Sequence from NCBI. Analysis is provided in the
`nist8398_grch38` subdirectory.

For the NIST8398 sample (only sequenced at ARD), calls made using the
RTG singleton caller (`rtg snp`) are provided, for each of the technical
replicates separately, plus one call set utilizing the data from all
three replicates. The replicates are:

"replicate 1":

    NIST8398-Quartet_DNA_ILM_ARD_NIST8398_1_20170403

"replicate 2":

    NIST8398-Quartet_DNA_ILM_ARD_NIST8398_2_20170403

"replicate 3":

    NIST8398-Quartet_DNA_ILM_ARD_NIST8398_3_20170403

"replicate 123" combines the above three datasets giving ~92x coverage.

In addition, two VCFs are included which have been created by using `rtg
vcfeval` to find the intersections of the three single replicate call
sets:

NIST8398_ARD_intersect_3of3_rtg-snp.avr-0.1.vcf.gz contains calls found
in all three of the replicate call sets.

NIST8398_ARD_intersect_2of3_rtg-snp.avr-0.1.vcf.gz contains calls found
in at least two of the three replicate call sets.

A demonstration of evaluating these call sets against the GIAB/NIST
3.3.2 gold standard from
ftp://ftp-trace.ncbi.nih.gov/giab/ftp/release/NA12878_HG001/NISTv3.3.2/
using RTG Tools can be executed with the following commands:

    rtg format -o GRCh38.d1.vd1.sdf GRCh38.d1.vd1.fa.gz
    for calls in replicate_1 replicate_2 replicate_3 replicate_123 intersect_2of3 intersect_3of3; do
        rtg vcfeval -t GRCh38.d1.vd1.sdf -o NIST8398_${calls}.eval -c NIST8398_ARD_${calls}_rtg-snp.avr-0.1.vcf.gz -b HG001_GRCh38_GIAB_highconf_CG-IllFB-IllGATKHC-Ion-10X-SOLID_CHROM1-X_v.3.3.2_highconf_PGandRTGphasetransfer.vcf.gz -e HG001_GRCh38_GIAB_highconf_CG-IllFB-IllGATKHC-Ion-10X-SOLID_CHROM1-X_v.3.3.2_highconf_nosomaticdel_noCENorHET7.bed -f AVR -m roc-only
    done
    rtg rocplot --title "ROC: RTG calls vs GIABv3.3.2" --png NIST8398-roc.png *.eval/weighted_roc.tsv.gz

(the output of these evaluations is included)

BAMs (including indexes and RTG calibration data files) are provided for
the GRCh38 dataset.


## Chinese quartet

All calling was against the primary chromosomes of the GRCh38.d1.vd1
Reference Sequence from NCBI. Analysis is provided in the
`quartet_grch38` subdirectory.

For the quartet, all call sets used the pedigree-aware RTG family caller
(`rtg family`). The two daughter samples (LCL5 and LCL6) were treated as
regular offspring of the parents (i.e. without any knowledge that they
are twins). Several call sets are provided from the various replicates
in different combinations:

ARD "replicate 1" comprises:

    LCL5-Quartet_DNA_ILM_ARD_LCL5_1_20170403
    LCL6-Quartet_DNA_ILM_ARD_LCL6_1_20170403
    LCL7-Quartet_DNA_ILM_ARD_LCL7_1_20170403
    LCL8-Quartet_DNA_ILM_ARD_LCL8_1_20170403

ARD "replicate 2" comprises:

    LCL5-Quartet_DNA_ILM_ARD_LCL5_2_20170403
    LCL6-Quartet_DNA_ILM_ARD_LCL6_2_20170403
    LCL7-Quartet_DNA_ILM_ARD_LCL7_2_20170403
    LCL8-Quartet_DNA_ILM_ARD_LCL8_2_20170403

ARD "replicate 3" comprises:

    LCL5-Quartet_DNA_ILM_ARD_LCL5_3_20170403
    LCL6-Quartet_DNA_ILM_ARD_LCL6_3_20170403
    LCL7-Quartet_DNA_ILM_ARD_LCL7_3_20170403
    LCL8-Quartet_DNA_ILM_ARD_LCL8_3_20170403

ARD "replicate 123" combines the above three datasets (~93x per sample)

NVG "replicate 1" comprises:

    LCL5-Quartet_DNA_ILM_NVG_LCL5_1_20170329
    LCL6-Quartet_DNA_ILM_NVG_LCL6_1_20170329
    LCL7-Quartet_DNA_ILM_NVG_LCL7_1_20170329
    LCL8-Quartet_DNA_ILM_NVG_LCL8_1_20170329

NVG "replicate 2" comprises:

    LCL5-Quartet_DNA_ILM_NVG_LCL5_2_20170329
    LCL6-Quartet_DNA_ILM_NVG_LCL6_2_20170329
    LCL7-Quartet_DNA_ILM_NVG_LCL7_2_20170329
    LCL8-Quartet_DNA_ILM_NVG_LCL8_2_20170329

NVG "replicate 3" comprises:

    LCL5-Quartet_DNA_ILM_NVG_LCL5_3_20170329
    LCL6-Quartet_DNA_ILM_NVG_LCL6_3_20170329
    LCL7-Quartet_DNA_ILM_NVG_LCL7_3_20170329
    LCL8-Quartet_DNA_ILM_NVG_LCL8_3_20170329

NVG "replicate 123" combines the above three datasets (~96x per sample)

WUX "replicate 1" comprises:

    LCL5-Quartet_DNA_ILM_WUX_LCL5_1_20170216
    LCL6-Quartet_DNA_ILM_WUX_LCL6_1_20170216
    LCL7-Quartet_DNA_ILM_WUX_LCL7_1_20170216
    LCL8-Quartet_DNA_ILM_WUX_LCL8_1_20170216

WUX "replicate 2" comprises:

    LCL5-Quartet_DNA_ILM_WUX_LCL5_2_20170216
    LCL6-Quartet_DNA_ILM_WUX_LCL6_2_20170216
    LCL7-Quartet_DNA_ILM_WUX_LCL7_2_20170216
    LCL8-Quartet_DNA_ILM_WUX_LCL8_2_20170216

WUX "replicate 2" comprises:

    LCL5-Quartet_DNA_ILM_WUX_LCL5_3_20170216
    LCL6-Quartet_DNA_ILM_WUX_LCL6_3_20170216
    LCL7-Quartet_DNA_ILM_WUX_LCL7_3_20170216
    LCL8-Quartet_DNA_ILM_WUX_LCL8_3_20170216

WUX "replicate 123" combines the above three datasets (~110x per sample)

A final dataset "ARD_NVG_WUX_all" combines all of the above datasets,
giving ~300x coverage per sample.

BAMs (including indexes and RTG calibration data files) are provided for
the GRCh38 dataset.

