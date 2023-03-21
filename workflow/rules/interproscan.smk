#Interproscan must be manually installed and DBs pressed by the user
rule interproscan_pfam_panther_sfam:
	input:
		predictedpep = "transdecoder/predicted.pep"
	output: "checkpoints/ipr.done"
	params:
		outdir = "predicted.pep_interproscan",
		ipr_path = config["params"]["interproscan_path"]
	conda: "../envs/interproscan.yml"
	log: "logs/interproscan_pfam_panther.log"
	shell:
		'''
		mkdir -p {params.outdir} && \
		{params.ipr_path}/interproscan.sh -i {input.predictedpep} \
		-f tsv \
		-d {params.outdir} \
		--cpu 12 \
		-goterms \
		--appl Pfam, PANTHER, SUPERFAMILY \
		2> {log} && \
		touch {output}
		'''

rule parse_ipr_pfam_tfs:
	input: "checkpoints/ipr.done"
	output: "predicted.pep_pfam_tfs.tsv"
	params:
		outdir = "predicted.pep_interproscan",
		pfamTFDB = config["params"]["PATH_TO_PFAM_TF_DATABASE"]
	shell:
		'''
		python3 workflow/scripts/parse_iprfile.py {params.outdir}/predicted.pep.tsv {params.pfamTFDB} {output}
		'''

rule parse_ipr_sfam_tfs:
	input: "checkpoints/ipr.done"
	output: "predicted.pep_sfam_tfs.tsv"
	params:
		outdir = "predicted.pep_interproscan",
		sfamTFDB = config["params"]["PATH_TO_SFAM_TF_DATABASE"]
	shell:
		'''
		python3 workflow/scripts/parse_iprfile.py {params.outdir}/predicted.pep.tsv {params.sfamTFDB} {output}
		'''