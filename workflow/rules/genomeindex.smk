rule genomeindex:
	input:
		genome = genome,
	output: "checkpoints/genomeindex.done"
	params:
		genomeindex = config["params"]["genomeindex"]
	log: "logs/genomeindex.log"
	conda: "../envs/samtools.yml"
	shell:
		'''
		samtools faidx {input.genome} \
		&& touch {output} 
		'''