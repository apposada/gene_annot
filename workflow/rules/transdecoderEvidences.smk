rule transdecoder_predict_evidence:
	input:
		transcripts = "data/transcripts.fna"
		longorfsdone = "longofrs.done",
		pfam = "pfam.domtblout",
		blastp = "blastp.outfmt6"
	output: "transdecoder.DONE"
	conda: "../envs/transdecoder.yml"
	shell:
		'''
		TransDecoder.Predict -t {input} \
        --retain_pfam_hits {input.pfam} \
        --retain_blastp_hits {input.blastp} \
        --single_best_only && \
		touch {output}
		'''