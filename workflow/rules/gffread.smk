rule gffread:
	input:
		genome = genome,
		gtf = "data/longest.gff3",
		indexdone = "checkpoints/genomeindex.done"
	output:
		transcripts = "transdecoder/transcripts.fna",
		done = "checkpoints/gffread.done"
	log: "logs/gffread.log"
	conda: "../envs/gffread.yml"
	shell:
		'''
		gffread -w {output.transcripts} -g {input.genome} {input.gtf} && \
		touch {output.done}
		'''
