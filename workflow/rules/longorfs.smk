rule longorfs:
	input:
		transcripts = "transdecoder/transcripts.fna"
	output: "steps/longorfs.done"
	conda: "../envs/transdecoder.yml"
	shell:
		'''
		TransDecoder.LongOrfs -t {input.transcripts} && touch {output}
		'''

