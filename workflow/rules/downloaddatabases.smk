rule downloadeggnog:
	params:
		database = config["params"]["eggnogdatabase"]
	conda:"../envs/eggnog.yml"
	output: "eggnogdb.DONE"
	shell:
		'''
		download_eggnog_data.py -y -H -d {params.database} && \
		touch {output}
		'''

rule downloadhmmer:
	output:"dlhmmer.DONE"
	params:
		hmmerURL = config["params"]["hmmer_url"]
	conda: "../envs/hmmscan.yml"
	shell:
		'''
		wget {params.hmmerURL} && \
		hmmpress && \
		touch {output}
		'''

rule downloadswissprot:
	output:"dlswissprot.DONE"
	params:
		swissprotURL = config["params"]["swissprot_url"]
	conda: "../envs/blastp.yml"
	shell:
		'''
		wget {params.swissprotURL} && \
		makeblasdtb -dbtype prot -in uniprot_sprot.fasta && \
		touch {output}
		'''

rule downloadanimaltfdb:
	output: "dlanimaltfdb.DONE"
	params:
		animaltfdbURL = config["params"]["animalTFDB_url"]
	shell:
		'''
		wget {params.animaltfdbURL} && touch {output}
		'''