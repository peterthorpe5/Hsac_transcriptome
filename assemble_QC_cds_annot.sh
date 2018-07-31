#!/bin/bash
#$ -cwd
#Abort on any error,
set -e

#This will give an error if bowtie is not on the $PATH
#(and thus quit the script right away)
cd /deNovoTranscriptome/fastq14112016
echo About to run Trinity!
ulimit -s unlimited
wait

PATH/trinityrnaseq-2.1.1/Trinity --trimmomatic --seqType fq --max_memory 230G --left /deNovoTranscriptome/fastq14112016/raw/R1.fq.gz --right /deNovoTranscriptome/fastq14112016/raw/R2.fq.gz --seqType fq --CPU 16 --min_kmer_cov 2 --SS_lib_type FR --output /deNovoTranscriptome/trinity_Pete_defaultTrimmo_20161124


echo trinity is finished...!!!!!!!!!!!!!!!!!!

#first run transrate on the assembly TWICE!!

cd /deNovoTranscriptome/pete_assembly_default_trimmo

# transrate command
transrate --assembly Trinity.fasta --left /deNovoTranscriptome/fastq14112016/raw/R1.fq.gz --right /deNovoTranscriptome/fastq14112016/raw/R2.fq.gz --threads 12

cd ./transrate_results/Trinity

transrate --assembly good.Trinity.fasta --left /deNovoTranscriptome/fastq14112016/raw/R1.fq.gz --right /deNovoTranscriptome/fastq14112016/raw/R2.fq.gz --threads 8

cd /deNovoTranscriptome/pete_assembly_default_trimmo


#########################################################################################################
##### shell script to annotate mpO using pfamAB domains	######################################
######################################################################################################

# 				transdecoder picking the cds, guided by swiss prot+GROS+GPAL+BUX sequences and pfam domains

PATH/TransDecoder-2.0.1/TransDecoder.LongOrfs -t /deNovoTranscriptome/pete_assembly_default_trimmo/good.Trinity.fasta

blastp -query /deNovoTranscriptome/pete_assembly_default_trimmo/good.Trinity.fasta.transdecoder_dir/longest_orfs.pep -db PATH/scratch/blast_databases/nem_plus_uniprot.fasta -max_target_seqs 1 -outfmt 6 -evalue 1e-5 -num_threads 16 > blastp.outfmt6

hmmscan --cpu 16 --domtblout pfam.domtblout PATH/scratch/TransDecoder_r20131117/pfam/Pfam-AB.hmm.bin /deNovoTranscriptome/pete_assembly_default_trimmo/good.Trinity.fasta.transdecoder_dir/longest_orfs.pep

PATH/TransDecoder-2.0.1/TransDecoder.Predict -t /deNovoTranscriptome/pete_assembly_default_trimmo/good.Trinity.fasta --retain_pfam_hits pfam.domtblout --retain_blastp_hits blastp.outfmt6

#
#wait

########################################################################################################################################################
#				for trinnotate
#	pfam domains


 
hmmscan --cpu 16 --domtblout TrinotatePFAM.out PATH/scratch/TransDecoder_r20131117/pfam/Pfam-AB.hmm.bin /deNovoTranscriptome/pete_assembly_default_trimmo/good.Trinity.fasta.transdecoder.longest.pep > pfam_pep.log
#
#
##		swissprot
blastx -query /deNovoTranscriptome/pete_assembly_default_trimmo/good.Trinity.fasta -db PATH/scratch/blast_databases/uniprot_sprot.faa -num_threads 16 -max_target_seqs 1 -outfmt 6 > blastx_trin.outfmt6
#
blastp -query /deNovoTranscriptome/pete_assembly_default_trimmo/good.Trinity.fasta.transdecoder.longest.pep -db PATH/scratch/blast_databases/uniprot_sprot.faa -num_threads 16 -max_target_seqs 1 -outfmt 6 > blastp_trin.outfmt6
#
##		uniref
blastx -query /deNovoTranscriptome/pete_assembly_default_trimmo/good.Trinity.fasta-db PATH/scratch/Trinotate-2.0.2/uniprot_uniref90.trinotate.pep -num_threads 16 -max_target_seqs 1 -outfmt 6 > uniref90.blastx.outfmt6
#
blastp -query /deNovoTranscriptome/pete_assembly_default_trimmo/good.Trinity.fasta.transdecoder.longest.pep -db PATH/Trinotate-2.0.2/uniprot_uniref90.trinotate.pep -num_threads 16 -max_target_seqs 1 -outfmt 6 > uniref90.blastp.outfmt6


#blastx -query /mnt/shared/scratch/sb42178/deNovoTranscriptome/pete_assembly_default_trimmo/good.Trinity.fasta -db /mnt/shared/scratch/path/path/Trinotate-3.0.1/uniprot_sprot.pep -num_threads 16 -max_target_seqs 1 -outfmt 6 > blastx_swiss_pro.outfmt6
blastp -query /mnt/shared/scratch/sb42178/deNovoTranscriptome/pete_assembly_default_trimmo/good.Trinity.fasta.transdecoder.longest.pep -db /mnt/shared/scratch/path/path/Trinotate-3.0.1/uniprot_sprot.pep -num_threads 16 -max_target_seqs 1 -outfmt 6 > blastp_swiss_pro.outfmt6

#
#blastp -query Rp.v1.AA.fasta -db /home/path/path/Trinotate-2.0.2/uniprot_uniref90.trinotate.pep -num_threads 4 -max_target_seqs 1 -outfmt 6 > uniref90.blastp.outfmt6
diamond blastp -k 1 -p 12 --sensitive -v -q /mnt/shared/scratch/sb42178/deNovoTranscriptome/pete_assembly_default_trimmo/good.Trinity.fasta.transdecoder.longest.pep -d /home/path/scratch/path/Trinotate-3.0.1/uniprot.dmnd -a longest.pep.blastp.uniref90.dmnd.diamond
diamond view -a longest.pep.blastp.uniref90.dmnd.*.daa -f tab -o uniprot.blastp.outfmt6
#
## 

#
## 		generate the trans to genes map
PATH/trinityrnaseq_r20140717/util/support_scripts/get_Trinity_gene_to_trans_map.pl scratch/se41398/Longi_Xiphi/cd90.fasta >  Trinity.fasta.gene_trans_map
#
#
#
##
##		Running signalP to predict signal peptides
signalp -f short -n signalp.out /deNovoTranscriptome/pete_assembly_default_trimmo/good.Trinity.fasta.transdecoder.longest.pep 
##wait
#
##		Running tmHMM to predict transmembrane regions
tmhmm --short < /deNovoTranscriptome/pete_assembly_default_trimmo/good.Trinity.fasta.transdecoder.longest.pep > tmhmm.out
##wait
#		Running RNAMMER to identify rRNA transcripts
/home/peter/Trinotate_r20131110/util/rnammer_support/RnammerTranscriptome.pl --transcriptome good.Trinity.fasta--path_to_rnammer /home/peter/rnammer
#
##wait
#
#
#
#
#######################################################################################################################################################################################
#
##		TRINNOTATE
#
wget "ftp://ftp.broadinstitute.org/pub/Trinity/Trinotate_v2.0_RESOURCES/Trinotate.sprot_uniref90.20150131.boilerplate.sqlite.gz" -O Trinotate.sqlite.gz
#
#
#
gunzip Trinotate.sqlite.gz
#
#
#
# load protein hits
Trinotate Trinotate.sqlite LOAD_swissprot_blastp blastp_trin.outfmt6

# load transcript hits
Trinotate Trinotate.sqlite LOAD_swissprot_blastx blastx_trin.outfmt6
Optional: load Uniref90 blast hits (requires the more comprehensive boilerplate database, as described above):
# load protein hits
Trinotate Trinotate.sqlite LOAD_trembl_blastp uniref90.blastp.outfmt6
# load transcript hits
Trinotate Trinotate.sqlite LOAD_trembl_blastx uniref90.blastx.outfmt6
Trinotate Trinotate.sqlite LOAD_pfam TrinotatePFAM.out
Trinotate Trinotate.sqlite LOAD_tmhmm tmhmm.out
Trinotate Trinotate.sqlite LOAD_signalp signalp.out
Trinotate Trinotate.sqlite report -E 1-10 > trinotate_annotation_report.xls

##########################################################################################################
###### shell script to annotate  using pfamAB domains swiss prot and uniref90	######################################
#######################################################################################################
#
##wait
#