rule blastpevidence:
	input: 
		longorfs = "steps/longorfs.done",
		swissprotdone = "dlswissprot.DONE"
	output:"blastp.outfmt6"
	conda: "../envs/blast.yml"
	shell:
		'''
		blastp -query transcripts.transdecoder_dir/longest_orfs.pep \
		-db uniprot_sprot.fasta \
		-max_target_seqs 1 \
		-outfmt 6 \
		-evalue 1e-5 \
		-num_threads 10 > {output}
		'''