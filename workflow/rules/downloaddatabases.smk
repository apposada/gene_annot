rule downloadeggnog:
	params:
		database = config["params"]["eggnogdatabase"]
	conda:"../envs/eggnog.yml"
	output: "checkpoints/eggnogdb.DONE"
	shell:
		'''
		download_eggnog_data.py -y -H -d {params.database} && \
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

# rule downloadSFAM:
# 	output: "checkpoints/dlSFAM.DONE"
# 	params:
# 		SFAM_URL = config["params"]["SUPERFAMILY_URL"]
# 	shell:
# 		'''
# 		wget {params.SFAM_URL} && touch {output}
# 		'''

#this should be user-provided maybe? a table that snakemake can read using functions?
rule downloadOrthofinderGenomes:
	output: "dlOFgenomes.DONE"
	params:
