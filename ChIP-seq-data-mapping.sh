# This code is used to map ChIP-seq data to reference genome;

trim_galore --paired --trim-n hex_S7_1.fastq.gz hex_S7_2.fastq.gz
bowtie2 -N 0 -p 8 -k 1 -x /u/project/jacobsen/zhenhuiz/tair10/TAIR10_small_chr.fasta -1 hex_S7_R1.fastq.gz -2 hex_S7_R2.fastq.gz | samtools view -bS - > hex_S7.bam
samtools sort hex_S7.bam -o hex_S7.sort.bam
samtools rmdup hex_S7.sort.bam hex_S7.sort.rmdup.bam
rm hex_S7.bam
rm hex_S7.sort.bam
samtools index hex_S7.sort.rmdup.bam
bamCoverage --bam hex_S7.sort.rmdup.bam -o hex_S7.bw --normalizeUsing RPKM --binSize 5 -p 1
