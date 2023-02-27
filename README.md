# gene_annot
snakemake pipeline from transcripts to annotated protein sequences 

## About

This is a snakemake wrapper of a number of well-known, standardised tools to annotate a dataset of transcripts based on sequence-homology and protein domain methods.

## Input

The only essential (for the moment) input is a .fasta file of a genome AND a .gtf annotation of the genes of your organism. Alternatively, you can provide a transcripts.fasta file with yout sequences of interest.
