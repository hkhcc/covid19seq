#!/bin/bash

# Collect all vcf.gz in step 09 and merge them into a multi-sample VCF
bcftools merge -0 ../09.Variant_calling/*.vcf.gz > final.vcf

# Perform plink analysis
../bin/plink/plink --allow-extra-chr --vcf final.vcf --make-bed --pca --out pca_analysis

# Perform PCA plotting
R --no-save < TreePCR_edited.R

# Perform pi calculation
vcftools --vcf final.vcf --window-pi 500 --out diversity_level

# Plot diversity level
python plotDiversityStatistics.py

# Concatenate viral sequences
cat ../10.Generate_consensus/*.fa ../ref/wuhan-hu-1.fasta ../ref/sars-cov.fasta ../ref/mers-cov.fasta ../ref/hku1-cov.fasta > cov_collection.fasta
