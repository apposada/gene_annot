rule gffread:
	input:
		genome = genome,
		gtf = "data/longest.gff3"
		indexdone = "genomeindex.done"
	output:
		transcripts="transcripts.fna"
		done="gffread.done"
	log: "logs/gffread.log"
	conda: "../envs/gffread.yml"
	shell:
		'''
		gffread -w {output[0]} -g {input.genome} {input.gtf} 2> {log} &1>2 && \
		touch ./steps/{output[1]}
		'''
