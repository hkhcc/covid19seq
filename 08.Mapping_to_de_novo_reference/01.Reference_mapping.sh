#!/bin/bash

# Define the list of additional SRA data to download
# SRR11300652 - Australia
# SRR11397727 - Australia
# SRR11393278 - USA
# SRR11393277 - USA
# SRR11347377 - USA
# SRR11313287 - Wuhan
# SRR11313494 - Wuhan
# SRR10902284 - SZ
# SRR10948474 - SZ
# SRR11178057 - HK
# SRR11178056 - HK

additional_nanopore_sra_list=(SRR11300652 SRR11397727 SRR11393278 SRR11393277 SRR11347377 SRR11313287 SRR11313494 SRR10902284 SRR10948474 SRR11178057 SRR11178056 SRR11178055 SRR11178054 SRR11178053 SRR11178052 SRR11178051 SRR11178050)

for sra in ${additional_nanopore_sra_list[@]}
do
	if [ -f "${sra}_refmap.bam.bai" ]; then
		
		echo "# $sra already processed!" 

	else
		echo "# Processing $sra..."
			../bin/minimap2-2.17_x64-linux/minimap2 -x map-ont -a ../ref/de_novo_sars-cov-2.fasta ../data/${sra}_pass.fastq.gz | samtools sort > ${sra}_refmap.bam
		samtools index ${sra}_refmap.bam
	fi
	
done

