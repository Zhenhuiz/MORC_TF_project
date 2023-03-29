# MORC_TF_project
Contain code for MORC and TF project

small RNA-seq analysis 

Small RNA-seq reads were downloaded from a previous paper. Adaptor sequence (TGGAATTCTCGG) was trimmed with trim_galore, and trimmed reads were mapped to the reference genome TAIR10 using Bowtie2 with only one unique hit and zero mismatches.

ATAC-seq analysis

ATAC-seq read adaptors were removed using trim_galore. The reads were then mapped to the Arabidopsis thaliana reference genome, TAIR10, using Bowtie2 (-X 2000 -m 1). Reads of chloroplast and mitochondrial DNA were filtered out and duplicate reads were removed using Samtools. ATAC-Seq open chromatin peaks of each replicate were called using MACS2 with parameters of -p 0.01 --nomodel --shift -100 --extsize 200. Consensus sets of chromatin peaks for all samples were merged by bedtools (v2.26.0) intersect allowing a distance of 10 base pairs. Following this, edgeR was used to define significant changes between peaks [Fold Change, (FC) > 2 and False Discovery Rate, (FDR) < 0.05]. ATAC-seq peak distributions were annotated using ChIPseeker. TF footprints were analyzed by TOBIAS with 572 plant TF motifs downloaded from JASPAR (http://jaspar.genereg.net/).

RNA-seq analysis

Cleaned short reads were aligned to the reference genome, TAIR10, by Bowtie2 (v2.1.0). Expression abundance was then calculated by RSEM using the default parameters [37]. Heatmaps were visualized using the R package pheatmap. Differential expression analysis was conducted using edgeR  [35]. A threshold of p-value < 0.05 and Fold Change > 2 were used to decide whether there were any significant differences in expression between samples. 

ChIP-seq analysis

ChIP-seq data was aligned to the TAIR10 reference genome with Bowtie2 (v2.1.0), only including uniquely mapped reads without any mismatches. Duplicated reads were removed by Samtools. ChIP-seq peaks were called by MACS2 (v2.1.1) and annotated using ChIPseeker [36]. Differential peaks were called by the bdgdiff function in MACS2 [38]. ChIP-seq data metaplots were plotted by deeptools (v2.5.1). Correlation of MORC7 with ChIP-seq data was conducted with ChromHMM. H3K9ac, H3K27ac, H4K16ac, H3K4me1, H3K4me3, H3K36me2, H3K36me3, H3K9me2, H3K27me3, Pol II, and Pol V, as published previously, were included in this analysis (Additional file 6: Table S5). Motif enrichment analysis was performed with MEME (v5.0.5).

Whole-genome bisulfite sequencing (BS-seq) analysis

Previously published whole-genome bisulfite sequencing data for morc-mutants and wild type was reanalyzed. Briefly, Trim_galore (http://www.bioinformatics.babraham.ac.uk/projects/trim_galore/) was used to trim adapters. BS-seq reads were aligned to the TAIR10 reference genome by BSMAP (v2.90), allowing two mismatches and one best hit (-v 2 -w 1). Reads with three or more consecutive CHH sites were considered to be unconverted reads and were filtered out. DNA methylation levels were defined as #C/ (#C + #T).
