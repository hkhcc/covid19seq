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
# SRR11178057 - HK (already downloaded)
# SRR11178056 - HK (already downloaded)

additional_nanopore_sra_list=(SRR11300652 SRR11397727 SRR11393278 SRR11393277 SRR11347377 SRR11313287 SRR11313494 SRR10902284 SRR10948474 SRR11178057 SRR11178056 SRR11178055 SRR11178054 SRR11178053 SRR11178052 SRR11178051 SRR11178050)

for sra in ${additional_nanopore_sra_list[@]}
do
	echo "# Processing $sra..."
	longshot --force_overwrite -P 0.01 --sample_id $sra --min_alt_count 20 --min_alt_frac 0.5 --no_haps --bam ../08.Mapping_to_de_novo_reference/${sra}_refmap.bam --ref ../ref/de_novo_sars-cov-2.fasta --out ${sra}.vcf
done

