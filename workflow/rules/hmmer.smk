rule hmmerevidence:
	input: 
		longorfs = "longorfs.done",
		hmmerdone = "dlhmmer.DONE"
	output:"pfam.domtblout"
	conda: "../envs/hmmscan.yml"
	shell:
		'''
		hmmscan --cpu 12  \
		--domtblout {output} \
		~/DATA/static/databases/pfam/Pfam-A.hmm \
		transcripts.transdecoder_dir/longest_orfs.pep
		'''