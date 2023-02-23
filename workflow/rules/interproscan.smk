rule interproscan_pfam_panther:
	input:
		predictedpep = "transdecoder/predicted.pep",
		hmmerdone = "checkpoints/dlhmmer.DONE"
	output: "predicted.pep_pfam_tfs.tsv"
	params:
		outdir = "predicted.pep_interproscan",
		pfamTFDB = config["params"]["PATH_TO_PFAM_TF_DATABASE"]
	conda: "../envs/interproscan.yml"
	log: 
	shell:
		'''
		interproscan.sh -i {input.predictedpep} \
		-d {params.outdir} \
		--cpu 12 \
		-goterms \
		--appl Pfam, PANTHER \
		2> {log} &1>2

		while read p; \
		do grep -w $p {params.outdir}/predicted.pep.tsv >> {output} ; \
		done < {params.pfamTFDB}
		'''

rule interproscan_SUPERFAMILY:
	input: 
		predictedpep = "transdecoder/predicted.pep",
		superfamilydone = "checkpoints/dlSFAM.DONE"
	output: "predicted.pep_sfam_tfs.tsv"
	params:
		outdir = "predicted.pep_interproscan",
		sfamTFDB = config["params"]["PATH_TO_SFAM_TF_DATABASE"]
	conda: "../envs/interproscan.yml"
	log: 
	shell:
		'''
		interproscan.sh -i {input.predictedpep} \
		-d {params.outdir} \
		--cpu 12 \
		-goterms \
		--appl SUPERFAMILY \
		2> {log} &1>2

		while read p; \
		do grep -w $p {params.outdir}/predicted.pep.tsv >> {output} ; \
		done < {params.sfamTFDB}
		'''