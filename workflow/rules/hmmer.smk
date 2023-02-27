rule hmmerevidence:
	input: 
		longorfs = "checkpoints/longorfs.done",
		hmmerdone = "checkpoints/dlhmmer.DONE"
	output:"transdecoder/evidences/pfam.domtblout"
	params:
		db_dir = "assets/dynamic/hmmer_db"
	conda: "../envs/hmmer.yml"
	shell:
		'''
		hmmscan --cpu 12  \
		--domtblout {output} \
		{params.db_dir}/Pfam-A.hmm \
		transdecoder/transdecoder_dir/longest_orfs.pep
		'''