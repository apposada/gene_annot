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
	shell:
		'''
		wget {params.hmmerURL} && touch {output}
		'''

rule downloadswissprot:
	output:"dlswissprot.DONE"
	params:
		swissprotURL = config["params"]["swissprot_url"]
	shell:
		'''
		wget {params.swissprotURL} && touch {output}
		'''

rule downloadanimaltfdb:
	output: "dlanimaltfdb.DONE"
	params:
		animaltfdbURL = config["params"]["animalTFDB_url"]
	shell:
		'''
		wget {params.animaltfdbURL} && touch {output}
		'''