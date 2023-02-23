rule gffread:
	input:
		genome = genome,
		gtf = "data/longest.gff3",
		indexdone = "genomeindex.done"
	output:
		transcripts="transdecoder/transcripts.fna",
		done="gffread.done"
	log: "logs/gffread.log"
	conda: "../envs/gffread.yml"
	shell:
		'''
		gffread -w transcripts.fna -g {input.genome} {input.gtf} 2> {log} &1>2 && \
		touch ./steps/{output.done}
		cp transcripts.fna {output.transcripts}
		'''
