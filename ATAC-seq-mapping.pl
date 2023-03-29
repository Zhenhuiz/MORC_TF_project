# this script is used to map paired end ATAC seq reads to reference genome TAIR10

trim_galore --paired --trim-n Col-0_r2_1.fastq Col-0_r2_2.fastq
bowtie TAIR10_small_chr.fasta -1 Col-0_r2_1_val_1.fq -2 Col-0_r2_2_val_2.fq -X 2000 -m 1 -p 8 -S Col-0_r2.sam
samtools view -bS Col-0_r2.sam > Col-0_r2.bam
samtools sort Col-0_r2.bam -o Col-0_r2.sort.bam
samtools view -b -F 4 -o Col-0_r2.sort.filted.bam Col-0_r2.sort.bam
samtools view -h Col-0_r2.sort.filted.bam | egrep -v chrC | samtools view -bT TAIR10_small_chr.fasta - -o Col-0_r2.no_chrC.bam
samtools view -h Col-0_r2.no_chrC.bam | egrep -v chrM | samtools view -bT TAIR10_small_chr.fasta - -o Col-0_r2.no_mito.bam
samtools rmdup Col-0_r2.no_mito.bam Col-0_r2.rmdup.bam
samtools index Col-0_r2.rmdup.bam
bamCoverage --bam Col-0_r2.rmdup.bam -o Col-0_r2.rmdup.bw  --normalizeUsingRPKM --binSize 5 -p 1
java -Xmx2g -jar ~/software/picard-tools-1.141/picard.jar CollectInsertSizeMetrics I=Col-0_r2.rmdup.bam O=Col-0_r2.length.txt M=0.5 H=Col-0_r2.pdf

