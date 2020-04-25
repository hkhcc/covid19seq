#!/bin/bash

# Define the list of SRA data to process
nanopore_sra_list=(SRR11178050 SRR11178051 SRR11178052 SRR11178053 SRR11178054 SRR11178055 SRR11178056 SRR11178057)

for sra in ${nanopore_sra_list[@]}
do
	echo "# Processing $sra..."
	# we load only 500Mbp for indexing each time to decrease memory requirement
	../bin/minimap2-2.17_x64-linux/minimap2 -t 2 -I 500M --split-prefix splittemp -a ../ref/hg19.fa.gz ../data/${sra}_pass.fastq.gz | samtools fastq -n -f 4 - | gzip > ${sra}_non_human.fastq.gz
done

