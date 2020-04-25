#!/bin/bash

# Define the list of SRA data to process
# nanopore_sra_list=(SRR11178050 SRR11178051 SRR11178052 SRR11178053 SRR11178054 SRR11178055 SRR11178056 SRR11178057)

# Define the input file list
genome_file_list=(grand_assembly/grand_assembly.contigs.fasta)


# 1. Run Prodigal on the genome files
for genome_file in ${genome_file_list[@]}
do
	echo "# Processing $genome_file..."
	genome_file_basename=`basename $genome_file`
	../bin/Prodigal/prodigal -a ${genome_file_basename}_prodigal_output.faa -o ${genome_file_basename}_prodigal_output.gbk -i ../05.Contig_reassembly/$genome_file
done
