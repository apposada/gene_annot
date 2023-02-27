rule parsegtf: 
	input:
		gtf = annot,
	output:
		gff3 = "data/parsed.gff3"
	conda: "../envs/agat.yml"
	log: "logs/parsegtf.log"
	shell:
		'''
		agat_convert_sp_gxf2gxf.pl --gff {input.gtf} -o {output.gff3} \
		2> {log} &&1>2
		'''