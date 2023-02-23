rule makeblastdb:
	input:
		predictedpep = "transdecoder/predicted.pep"
	output: "makeblastdb.done"
	conda: "../envs/blastp.yml"
	log: "logs/makeblastdb.log"
	shell:
		'''
		makeblastdb -dbtype prot -in {input.predictedpep} && \
		touch {output}
		'''

rule recipbesthits:
	input:
		predictedpep = "transdecoder/predicted.pep",
		swissprotdone = "dlswissprot.DONE",
		blastdbdone = "makeblastdb.done"
	output: "predicted_rbh.tsv"
	params:
		rbh1 = config["params"]["rbh1"],
		rbh2 = config["params"]["rbh2"]
	conda: "../envs/blastp.yml"
	shell:
		'''
		blastp -db uniprot_sprot.fa -query {input.predictedpep} \
		{params.rbh1} | \
		tee rbh_1_2_orig.tsv | \
		cut -f1,2 > rbh_1_2.tsv && \
		blastp -db {input.predictedpep} -query uniprot_sprot.fa \
		{params.rbh2} | \
		tee rbh_2_1_orig.tsv | \
		cut -f1,2 > rbh_2_1.tsv && \
		grep -f rbh_2_1.tsv rbh_1_2.tsv > {output}
		'''