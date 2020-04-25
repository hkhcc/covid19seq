#!/bin/bash

# Define the list of SRA data to process
nanopore_sra_list=(SRR11178050 SRR11178051 SRR11178052 SRR11178053 SRR11178054 SRR11178055 SRR11178056 SRR11178057)

# 1. Collect the initial contigs
for sra in ${nanopore_sra_list[@]}
do
	echo "# Copying $sra..."
	cp ../04.Correct_and_assembly/${sra}_non_human/${sra}_non_human.contigs.fasta ./
	cp ../04.Correct_and_assembly/${sra}_baited_viral/${sra}_baited_viral.contigs.fasta ./
done

# 2. Perform re-assembly
../bin/canu-2.0/Linux-amd64/bin/canu -d grand_assembly -p grand_assembly genomeSize=30k -corrected \
-trimmed -assemble -nanopore *.fasta
