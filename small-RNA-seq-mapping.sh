# this code is used to map small RNA reads to reference genome

trim_galore --paired Col-0-floral_R1.fastq.gz Col-0-floral_R2.fastq.gz --trim-n -a AGATCGGAAGAGCACACGTCTGAACTCCAGTCAC -a2 GATCGTCGGACTGTAGAACTCTGAACGTGTAGATCTCGGTGGTCGCCGTATCATT
bowtie2 -N 0 -p 8 -k 1 -x /u/project/jacobsen/zhenhuiz/tair10/TAIR10_small_chr.fasta -1 Col-0-floral_R1_val_1.fq.gz -2 Col-0-floral_R2_val_2.fq.gz | samtools view -bS - > Col-0-floral.bam
samtools sort Col-0-floral.bam -o Col-0-floral.sort.bam
rm Col-0-floral.bam
samtools index Col-0-floral.sort.bam
bamCoverage --bam Col-0-floral.sort.bam -o Col-0-floral.sort.bw  --normalizeUsing RPKM --binSize 1 -p 2
