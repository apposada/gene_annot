rule emapper:
	input:
		pep = "transdecoder/longest.pep",
		DBdone = "eggnogdb.DONE"
	params:
		eggnog = config["params"]["emapper"]
		outdir = "./eggnog"
	output: "emapper.DONE"
	conda: "../envs/eggnog.yml"
	log: "logs/emapper.log"
	shell:
		'''
		emapper.py --cpu 12 \
        -i {input.pep} \
		--itype proteins \
        {params.eggnog} \
        --output {params.output} && \
		touch {output}
		'''