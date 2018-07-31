#!/bin/bash
#$ -l hostname="n13*"
#$ -cwd

#Abort on any error,
set -e

#echo Running on $HOSTNAME
#echo Current PATH is $PATH
#source ~/.bash_profile

#export PATH=$HOME/bin:$PATH
#echo Revised PATH is $PATH

#This will give an error if bowtie is not on the $PATH
#(and thus quit the script right away)
#which bowtie
cd /home/path/scratch/H_sac/H_sac_RNAseq_ass/renamed/DE_analysis
#echo About to run Trinity!
ulimit -s unlimited
wait



# map the file back to the assembly - get abundance	
#/home/path/path/trinityrnaseq-2.1.1/util/align_and_estimate_abundance.pl --prep_reference --transcripts good.Trinity.fasta --seqType fq --left /home/path/scratch/H_sac/fastq14112016/Rp_art_24h_1_R1.fq.gz --right /home/path/scratch/H_sac/fastq14112016/Rp_art_24h_1_R2.fq.gz --est_method kallisto --SS_lib_type FR --thread_count 16 --trinity_mode --output_dir Rp_art_24h_1

# J2 
/home/path/path/trinityrnaseq-2.1.1/util/align_and_estimate_abundance.pl --prep_reference --transcripts /home/path/scratch/H_sac/H_sac_RNAseq_ass/renamed/good.Trinity.fasta --seqType fq --left /home/path/scratch/H_sac/fastq14112016/out_Juvenile_S1_L001_R1_001_pair.fastq.gz --right /home/path/scratch/H_sac/fastq14112016/out_Juvenile_S1_L001_R2_001_pair.fastq.gz --est_method kallisto --SS_lib_type FR --thread_count 4 --trinity_mode --output_dir J2 --output_prefix J2

# 15dpi
/home/path/path/trinityrnaseq-2.1.1/util/align_and_estimate_abundance.pl --transcripts /home/path/scratch/H_sac/H_sac_RNAseq_ass/renamed/good.Trinity.fasta --seqType fq --left /home/path/scratch/H_sac/fastq14112016/out_Female_S2_L001_R1_001_pair.fastq.gz --right /home/path/scratch/H_sac/fastq14112016/out_Female_S2_L001_R2_001_pair.fastq.gz --est_method kallisto --SS_lib_type FR --thread_count 4 --trinity_mode --output_dir dpi_15 --output_prefix dpi_15
# generate abundance matrix
 /home/path/path/trinityrnaseq-2.1.1/util/abundance_estimates_to_matrix.pl --est_method kallisto --cross_sample_norm TMM --name_sample_by_basedir ./J2/abundance.tsv ./dpi_15/abundance.tsv --out_prefix Hsac_J2_15dpi
 
 