rule longestisoforms:
	input: "data/parsed.gff3"
	output: "data/longest.gff3"
	conda: "../envs/"
	log:
	shell:
		'''
		agat_sp_keep_longest_isoform.pl --gff {input} -o {output}
		'''