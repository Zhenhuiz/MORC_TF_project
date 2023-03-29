# this code is used to map RNA-seq reads to reference transcript

rsem-calculate-expression -p 6 --bowtie2 --bowtie2-path ~/software/bowtie2-2.1.0/ ./hex_r3.fq tair10 ./hex_r3
samtools sort ./hex_r3.temp/hex_r3.bam -o hex_r3.sort.bam
samtools index hex_r3.sort.bam
