#!/bin/bash
#$ -cwd
#Abort on any error,
#set -e

#echo Running on $HOSTNAME
#echo Current PATH is $PATH
#source $HOME/.bash_profile


################################################################
# Variables: FILLL IN DOWN TO THE END OF VARIABLES
#known_fa="/home/path/scratch/nematode/G.rostochiensis/genome_data/nGr.v1.1.augustus.manual.2015_04_02.aa.fa"
# effector ; 
known_fa="non-redundant_effectors.protein"

known_fa_nucl="/home/path/scratch/nematode/G.rostochiensis/genome_data/nGr.v1.1.augustus.manual.2015_04_02.CDS.fa"

genome_test="/home/path/scratch/H_sac/H_sac_RNAseq_ass/renamed/Hsach_QC_RNAseq_Assembly_v1.fasta"
# default name
test_fa="/home/path/scratch/H_sac/H_sac_RNAseq_ass/renamed/Hsach_QC_RNAseq_CDS.AA.fasta"
min_len_gene="20"
threads=4
python_directory=$HOME/public_scripts/gene_model_testing
Working_directory=/home/path/scratch/H_sac/H_sac_RNAseq_ass/renamed/versus_GROS
test_gff="${Working_directory}/${genome_test}_${Aug_species}.gff"
# for the repeat masking and GFF I used a altered gene name version
genome="${P_aust}/P_austrocedri_Canu.fa.masked"
#genome="${Phy_dir}/Phytophthora_infestans.ASM14294v1.31.fa"

# FOR HGT
# tax_filter_out is the phylum your beast lives in, or clade if you want to get a more refined HGT result
# tax_filter_up_to e.g. metazoan = tax_filter_up_to
# for aphid: #tax_filter_out=6656 #tax_filter_up_to=33208 
# for nematodes, #tax_filter_out=6231 ,#tax_filter_up_to=33208 

# for nematoda
species_tx_id=4787
#  Stramenopiles - metazoan
tax_filter_up_to=33208 
# If you want to run transrate to get the RNAseq read mapping to gene 
# fill these out. Else, just let it fail, as it is the last step.

left_reads="${Phy_dir}/RNAseq_reads/R1.fq.gz"
right_reads="${Phy_dir}/RNAseq_reads/R2.fq.gz"

# END OF USER VARIABLES. NOTHING TO FILL IN FROM HERE.
#######################################################################
export Phy_dir
export known_fa
export known_fa_nucl
export prefix
export test_fa
export min_len_gene
export threads
export python_directory
export Working_directory
export test_gff
export genome
export T_30_4
export species_tx_id
export tax_filter_out
export tax_filter_up_to
export left_reads
export right_reads

cd /home/path/scratch/H_sac/H_sac_RNAseq_ass/renamed/versus_GROS


/home/path/scratch/H_sac/shell_scripts/Gene_model_testing_Master.sh


