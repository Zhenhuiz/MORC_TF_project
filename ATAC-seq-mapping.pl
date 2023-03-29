# this script is used to map paired end ATAC seq reads to reference genome TAIR10
@file=<*_R1.fastq.gz>;
foreach(@file){

	print "Inputing $_\n";
	($name)=$_=~/(\S+)_R1.fastq.gz/;
	open out, ">$name\_mapping.pbs";
	print out "#!/bin/sh
#\$ \-cwd
#\$ \-o ./
#\$ \-V
#\$ \-S /bin/bash
#\$ \-l h_data=16g,h_rt=20:00:00
#\$ \-e ./
#\$ \-pe shared 2

module load java/jre-1.7.0_45
trim_galore --paired --trim-n $name\_R1.fastq.gz $name\_R2.fastq.gz
bowtie2 -x TAIR10_small_chr.fasta -N 0 -p 8 -k 1 -X 2000 -1 $name\_R1_val_1.fq.gz -2 $name\_R2_val_2.fq.gz \| samtools view -bS - > $name.bam
samtools sort $name.bam -o $name.sort.bam
rm $name\_R1_val_1.fq.gz 
rm $name\_R2_val_2.fq.gz
samtools view -b -F 4 -o $name.sort.filted.bam $name.sort.bam
samtools view -h $name.sort.filted.bam | egrep -v chrC | samtools view -bT TAIR10_small_chr.fasta - -o $name.no_chrC.bam
samtools view -h $name.no_chrC.bam | egrep -v chrM | samtools view -bT TAIR10_small_chr.fasta - -o $name.no_mito.bam
samtools rmdup $name.no_mito.bam $name.rmdup.bam
samtools index $name.rmdup.bam
bamCoverage --bam $name.rmdup.bam -o $name.rmdup.bw  --normalizeUsing RPKM --binSize 5 -p 8
java -Xmx2g -jar ~/software/picard-tools-1.141/picard.jar CollectInsertSizeMetrics I=$name.rmdup.bam O=$name.length.txt M=0.5 H=$name.pdf
rm $name.sam
rm $name.bam
rm $name.sort.bam
rm $name.no_chrC.bam
rm $name.no_mito.bam
rm $name.sort.filted.bam\n";
	close out;
	system("qsub $name\_mapping.pbs");
}
