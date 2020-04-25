#!/bin/bash

# Define the list of SRA data to process
nanopore_sra_list=(SRR11178050 SRR11178051 SRR11178052 SRR11178053 SRR11178054 SRR11178055 SRR11178056 SRR11178057)

for sra in ${nanopore_sra_list[@]}
do
	echo "# Processing $sra..."
	# 1. correction and assembly of the non-human reads
	../bin/canu-2.0/Linux-amd64/bin/canu -d ${sra}_non_human -p ${sra}_non_human genomeSize=30k -nanopore-raw ../02.Remove_human_sequences/${sra}_non_human.fastq.gz
	# 2. correction and assembly of SARS-CoV baited presumptive viral sequences
	../bin/canu-2.0/Linux-amd64/bin/canu -d ${sra}_baited_viral -p ${sra}_baited_viral genomeSize=30k -nanopore-raw ../03.Extract_viral_sequences/${sra}_viral_reads.fastq.gz
done

