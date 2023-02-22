rule longorfs:
	input:
		transcripts = "data/transcripts.fna"
	output: "longorfs.done"
	conda: "../envs/transdecoder.yml"
	shell:
		'''
		TransDecoder.LongOrfs -t {input.transcripts} && touch {output}
		'''

