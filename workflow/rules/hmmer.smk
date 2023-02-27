rule hmmerevidence:
	input: 
		longorfs = "checkpoints/longorfs.done",
		hmmerdone = "checkpoints/dlhmmer.DONE"
	output:"transdecoder/evidences/pfam.domtblout"
	conda: "../envs/hmmer.yml"
	shell:
		'''
		hmmscan --cpu 12  \
		--domtblout {output} \
		Pfam-A.hmm \
		transdecoder/transdecoder_dir/longest_orfs.pep
		'''