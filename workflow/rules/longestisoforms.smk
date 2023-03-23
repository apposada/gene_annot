rule longestisoforms:
	input: "data/parsed.gff3"
	output: "data/longest.gff3"
	conda: "../envs/agat.yml"
	log: "logs/longestisoforms.log"
	shell:
		'''
		agat_sp_keep_longest_isoform.pl --gff {input} -o {output} \
		2> {log}
		'''