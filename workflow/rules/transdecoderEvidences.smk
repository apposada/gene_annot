rule transdecoder_predict_evidence:
	input:
		transcripts = "transdecoder/transcripts.fna",
		longorfsdone = "checkpoints/longorfs.done",
		pfam = "pfam.domtblout",
		blastp = "blastp.outfmt6"
	output: 
		transdecoderDone = "checkpoints/transdecoder.DONE",
		transdecoderTSV = "transdecoder/transdecoder.tsv",
		predictedpep = "transdecoder/predicted.pep"
	params:
		awkexpr1 = r"""/^>/ {{ sub(/^>/, ""); seqname=$1; sub(/^[^ ]* /, ""); extra_info=$0; printf("%s\t%s\n", seqname, extra_info) }}""",
		awkexpr2 = r"""{sub(/\.p[0-9]+ .*/,"")}1"""
	conda: "../envs/transdecoder.yml"
	shell:
		'''
		TransDecoder.Predict -t {input} \
        --retain_pfam_hits {input.pfam} \
        --retain_blastp_hits {input.blastp} \
        --single_best_only && \
		touch {output.transdecoderDone} && \
		awk {params.awkexpr1:q} transcripts.fna.transdecoder.pep > {output.transdecoderTSV} && \
		awk {params.awkexpr2:q} transcripts.fna.transdecoder.pep > {output.predictedpep}
		'''