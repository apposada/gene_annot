rule downloadeggnog:
	params:
		database = config["params"]["eggnogdatabase"]
	conda:"../envs/eggnog.yml"
	output: "checkpoints/eggnogdb.DONE"
	log: "logs/download_eggnog_db.log"
	shell:
		'''
		download_eggnog_data.py -y -H -f  -d {params.database} 2> {log} && \
		touch {output}
		'''

rule downloadhmmer:
	output:"checkpoints/dlhmmer.DONE"
	params:
		hmmerURL = config["params"]["hmmer_url"],
		db_dir = "assets/dynamic/hmmer_db"
	conda: "../envs/hmmer.yml"
	shell:
		'''
		wget {params.hmmerURL} -P {params.db_dir} && \
		gunzip {params.db_dir}/Pfam-A.hmm.gz && \
		hmmpress {params.db_dir}/Pfam-A.hmm && \
		touch {output}
		'''

rule downloadswissprot:
	output:"checkpoints/dlswissprot.DONE"
	params:
		swissprotURL = config["params"]["swissprot_url"],
		db_dir = "assets/dynamic/blast_db"
	conda: "../envs/blast.yml"
	shell:
		'''
		wget {params.swissprotURL} -P {params.db_dir} && \
		gunzip {params.db_dir}/uniprot_sprot.fasta.gz && \
		makeblastdb -dbtype prot -in {params.db_dir}/uniprot_sprot.fasta && \
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