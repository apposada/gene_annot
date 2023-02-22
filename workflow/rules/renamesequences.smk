rule renamesequences:
	input: "data/transcripts.fna"
	output: "data/transcripts_renamed.fna"
	shell:
		'''
		perl-pe "s/(^>[a-zA-Z0-9_.]+) .*/\1/" {input} > {output}
		'''