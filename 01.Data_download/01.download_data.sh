#!/bin/bash

# Define the list of SRA data to download
nanopore_sra_list=(SRR11178050 SRR11178051 SRR11178052 SRR11178053 SRR11178054 SRR11178055 SRR11178056 SRR11178057)

for sra in ${nanopore_sra_list[@]}
do
	echo "# Downloading $sra..."
	fastq-dump --outdir ../data/ --gzip --skip-technical --readids --read-filter pass --dumpbase --clip $sra
done

