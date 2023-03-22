# this could be useful here for dynamic downloading and preparation of proteomes https://evodify.com/snakemake-checkpoint-tutorial/

rule OF_prepareproteomes:
	output: "checkpoints/OF_proteomes.done"
	params:
		proteomes_directory = config["params"]["proteomes_directory"]
	shell:
		'''
		mkdir -p orthofinder/ && \
		ln -s {params.proteomes_directory}/* orthofinder/ && \
		touch {output}
		'''

rule OF_prepareSpeciesOfInterest:
	input:
		predictedpep = "transdecoder/predicted.pep"
	output: proteome_organism()
	params:
		organism = config["organism"]
	shell:
		'''
		ln -s ../{input.predictedpep} {output}
		'''

rule orthofinder:
	input: 
		of_proteomes_done = "checkpoints/OF_proteomes.done",
		spp_of_interest = proteome_organism()
	params:
		proteomes_directory = "./orthofinder/",
		userparams = config["params"]["orthofinder_params"]
	conda: "../envs/orthofinder.yml"
	output: "checkpoints/orthofinder.DONE"
	log: "logs/orthofinder.log"
	shell:
		'''
		orthofinder {params.userparams} \
		-f {params.proteomes_directory} && \
		touch {output}
		'''


	
