# gene_annot
snakemake pipeline from transcripts to annotated protein sequences 

## About

This is a snakemake wrapper of a number of well-known, standardised tools to annotate a dataset of transcripts based on sequence-homology and protein domain methods.

## What it does

Briefly, this workflow will extract the longest coding sequences per transcript (longest isoform per gene) from a genome annotation. It will translate these to proteins, and proceed with a multi-evidence functional annotation (EggNOG mapper, interproscan, blast best reciprocal hits, and Orthofinder). If needed, the pipeline will download and prepare the necessary databases for these steps.

![workflow graphical DAG](graphics/annot.png?raw=true "workflow graphical DAG")

Eventually the pipeline will aim at generating two final output files; one with the functional annotation of all the predicted protein-coding genes, and one with the functional annotation of a subset of the genes with high-confidence of being a transcription factor.

The user will be able to proceed with downstream analyses of their own and to use any of the intermediate or secondarily derived outputs of this workflow.

## Input

The necessar input to run this workflow is:

* A .fasta file of a genome of interest,
* A .gtf annotation of the genes of the genome of interest,
* A config.yaml file with all the necessary parameters, specificially:
	* A name of the organism (this will eventually be used to tag all the files in the run),
	* The path to the genome of interest,
	* The path to the gtf of interest,
	* Parameters for the different tools (otherwise the workflow will use the ones specified by default)

The user can use the pre-included config.yaml file as a template for their own run.

Alternatively, the user can provide a set of transcripts in a transcripts.fna file at the root directory of the workflow or a set of protein sequences in the path `transdecoder/predicted.pep`. Snakemake will recognise these and start the workflow from these files.

## How to run

NOTE: At the moment the workflow uses checkpoints (empty files whose names are recognised by snakemake) as a means to connect rules. If one whishes to restart the workflow or resume from a specific step, please consider removing the `checkpoints/` directory or any specific checkpoint of interest.

First of all make sure that you have snakemake and conda accessible from your running environment. You can always create a conda environment with snakemake in it (this is how I do it myself).

```sh
# create venv
mamba create -n snakemake_venv -c bioconda snakemake

# activate venv
conda activate snakemake_venv
```

 After cloning this repository, prepare the config file and the genome and annotation files.

 Then, move to the root directory of the workflow and run snakemake like this

```sh
# move to the directory of the workflow
cd gene_annot/

# run snakemake
snakemake --use-conda
```

Optionally you can add options like `--cores NUMCORES` to use a specific amount of cores, and `--rerun-incomplete` to retry and re-run the steps that might have gone wrong in a previous attempt. Please refer to the snakemake documentation for more information.