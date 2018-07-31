#!/bin/bash
#$ -cwd
#Abort on any error,
set -e


# for nematoda
phylum_filter_out=6321
species_tx_id=157861
#  Stramenopiles - metazoan
tax_filter_up_to=33208 

cd /home/path/scratch/H_sac/H_sac_RNAseq_ass/renamed

echo "running diamond-BLAST against NR"
diam_p="/home/path/scratch/path/diamond-master/diamond blastp 
		-p 12 --more-sensitive -e 0.00001 
	   -q Hsach_QC_RNAseq_CDS.AA.fasta
	   -d $HOME/scratch/blast_databases/nr.dmnd 
	   --taxonmap $HOME/scratch/blast_databases/prot.accession2taxid.gz	
	   --outfmt 5 --salltitles
	   --out Hsach_QC_RNAseq_CDS.AA.fasta_vs_nr.xml"
echo ${diam_p}
eval ${diam_p}
wait

echo "running diamond-BLAST against NR"
diam_p="/home/path/scratch/path/diamond-master/diamond blastx 
		-p 12 --more-sensitive -e 0.00001 
	   -q Hsach_Full_assembly_contaminants_removed.fasta
	   -d $HOME/scratch/blast_databases/nr.dmnd 
	   --taxonmap $HOME/scratch/blast_databases/prot.accession2taxid.gz	
	   --outfmt 5 --salltitles
	   --out Hsach_Full_assembly_contaminants_removed.fasta_vs_nr.xml"
echo ${diam_p}
eval ${diam_p}
wait


echo "running diamond-BLAST against NR"
diam_p="/home/path/scratch/path/diamond-master/diamond blastx 
		-p 12 --more-sensitive -e 0.00001 
	   -q Hsach_QC_RNAseq_Assembly_v1.fasta
	   -d $HOME/scratch/blast_databases/nr.dmnd
	   --taxonmap $HOME/scratch/blast_databases/prot.accession2taxid.gz	   
	   --outfmt 5 --salltitles
	   --out Hsach_QC_RNAseq_Assembly_v1.fasta_vs_nr.xml"
echo ${diam_p}
eval ${diam_p}
wait




