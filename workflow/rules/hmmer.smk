rule hmmerevidence:
	input: 
		longorfs = "checkpoints/longorfs.done",
		hmmerdone = "checkpoints/dlhmmer.DONE"
	output:"pfam.domtblout"
	conda: "../envs/hmmscan.yml"
	shell:
		'''
		hmmscan --cpu 12  \
		--domtblout {output} \
		~/DATA/static/databases/pfam/Pfam-A.hmm \
		transcripts.transdecoder_dir/longest_orfs.pep
		'''