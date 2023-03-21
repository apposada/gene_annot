rule makeblastdb:
	input:
		predictedpep = "transdecoder/predicted.pep"
	output: "checkpoints/makeblastdb.done"
	conda: "../envs/blast.yml"
	log: "logs/makeblastdb.log"
	shell:
		'''
		makeblastdb -dbtype prot -in {input.predictedpep} && \
		touch {output}
		'''

rule recipbesthits:
	input:
		predictedpep = "transdecoder/predicted.pep",
		swissprotdone = "checkpoints/dlswissprot.DONE",
		blastdbdone = "checkpoints/makeblastdb.done"
	output: "predicted_rbh.tsv"
	params:
		rbh1 = config["params"]["rbh1"],
		rbh2 = config["params"]["rbh2"],
		db_dir = "assets/dynamic/blast_db"
	conda: "../envs/blast.yml"
	shell:
		'''
		blastp -db {params.db_dir}/uniprot_sprot.fasta -query {input.predictedpep} \
		{params.rbh1} | \
		tee rbh_1_2_orig.tsv | \
		cut -f1,2 > rbh_1_2.tsv && \
		blastp -db {input.predictedpep} -query {params.db_dir}/uniprot_sprot.fasta \
		{params.rbh2} | \
		tee rbh_2_1_orig.tsv | \
		cut -f1,2 > rbh_2_1.tsv && \
		grep -f rbh_2_1.tsv rbh_1_2.tsv > {output}
		'''