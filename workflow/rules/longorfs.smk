rule longorfs:
	input:
		transcripts = "transdecoder/transcripts.fna"
	output: "checkpoints/longorfs.done"
	conda: "../envs/transdecoder.yml"
	shell:
		'''
		TransDecoder.LongOrfs -t {input.transcripts} \
		--output_dir ./transdecoder/transdecoder_dir/ \
		&& touch {output}
		'''

