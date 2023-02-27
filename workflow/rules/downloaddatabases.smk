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
		hmmerURL = config["params"]["hmmer_url"]
	conda: "../envs/hmmer.yml"
	shell:
		'''
		wget {params.hmmerURL} && \
		gunzip Pfam-A.hmm.gz && \
		hmmpress Pfam-A.hmm && \
		touch {output}
		'''

rule downloadswissprot:
	output:"checkpoints/dlswissprot.DONE"
	params:
		swissprotURL = config["params"]["swissprot_url"]
	conda: "../envs/blast.yml"
	shell:
		'''
		wget {params.swissprotURL} && \
		gunzip uniprot_sprot.fasta.gz && \
		makeblastdb -dbtype prot -in uniprot_sprot.fasta && \
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
