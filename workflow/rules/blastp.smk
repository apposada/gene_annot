rule blastpevidence:
	input: 
		longorfs = "checkpoints/longorfs.done",
		swissprotdone = "checkpoints/dlswissprot.DONE"
	output:"transdecoder/evidences/blastp.outfmt6"
	params:
		db_dir = "assets/dynamic/hmmer_db"
	conda: "../envs/blast.yml"
	shell:
		'''
		blastp -query transdecoder/transdecoder_dir/longest_orfs.pep \
		-db {params.db_dir}/uniprot_sprot.fasta \
		-max_target_seqs 1 \
		-outfmt 6 \
		-evalue 1e-5 \
		-num_threads 10 > {output}
		'''