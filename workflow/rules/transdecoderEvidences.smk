rule transdecoder_predict_evidence:
	input:
		dlhmmer = "checkpoints/dlhmmer.DONE",
		dlswissprot = "checkpoints/dlswissprot.DONE",
		transcripts = "transdecoder/transcripts.fna",
		longorfsdone = "checkpoints/longorfs.done",
		pfam = "transdecoder/evidences/pfam.domtblout",
		blastp = "transdecoder/evidences/blastp.outfmt6"
	output: 
		transdecoderDone = "checkpoints/transdecoder.DONE",
		transdecoderTSV = "transdecoder/predict_evidences/transdecoder.tsv",
		predictedpep = "transdecoder/predicted.pep"
	params:
		awkexpr1 = r"""/^>/ {{ sub(/^>/, ""); seqname=$1; sub(/^[^ ]* /, ""); extra_info=$0; printf("%s\t%s\n", seqname, extra_info) }}""",
		awkexpr2 = r"""{sub(/\.p[0-9]+ .*/,"")}1""",
		outdir = "./transdecoder/transdecoder_dir"
	conda: "../envs/transdecoder.yml"
	shell:
		'''
		TransDecoder.Predict -t {input.transcripts} \
        --retain_pfam_hits {input.pfam} \
        --retain_blastp_hits {input.blastp} \
        --single_best_only \
		--output_dir {params.outdir} && \
		mv transcripts.fna.transdecoder* {params.outdir} && \
		awk {params.awkexpr1:q} {params.outdir}/transcripts.fna.transdecoder.pep > {output.transdecoderTSV} && \
		awk {params.awkexpr2:q} {params.outdir}/transcripts.fna.transdecoder.pep > {output.predictedpep} && \
		touch {output.transdecoderDone}
		'''