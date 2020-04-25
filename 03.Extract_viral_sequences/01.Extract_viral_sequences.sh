#!/bin/bash

# Define the list of SRA data to process
nanopore_sra_list=(SRR11178050 SRR11178051 SRR11178052 SRR11178053 SRR11178054 SRR11178055 SRR11178056 SRR11178057)

for sra in ${nanopore_sra_list[@]}
do
	echo "# Processing $sra..."
	# we load only 500Mbp for indexing each time to decrease memory requirement
	#../bin/minimap2-2.17_x64-linux/minimap2 -t 4 -a ../ref/wuhan-hu-1.fasta ../02.Remove_human_sequences/${sra}_non_human.fastq.gz | samtools fastq -n -F 4 - | gzip > ${sra}_viral_reads.fastq.gz
	../bin/minimap2-2.17_x64-linux/minimap2 -t 4 -a ../ref/sars-cov.fasta ../02.Remove_human_sequences/${sra}_non_human.fastq.gz | samtools fastq -n -F 4 - | gzip > ${sra}_viral_reads.fastq.gz
done

