#!/bin/bash
#$ -cwd

#Abort on any error,
set -e

min_len_gene="20"
threads=4
python_directory=$HOME/public_scripts/gene_model_testing

cd path/deNovoTranscriptome/fastq14112016

ulimit -s unlimited
wait

/home/path/path/trinityrnaseq-2.1.1/Trinity --trimmomatic --seqType fq --max_memory 230G --left path/deNovoTranscriptome/fastq14112016/raw/R1.fq.gz --right path/deNovoTranscriptome/fastq14112016/raw/R2.fq.gz --seqType fq --CPU 16 --min_kmer_cov 2 --SS_lib_type FR --output path/deNovoTranscriptome/trinity_Pete_defaultTrimmo_20161124

#cd path/deNovoTranscriptome/fastq14112016/raw/
#gunzip R1.fq.gz 
#gunzip R2.fq.gz 

cd /home/path/scratch/H_sac/H_sac_RNAseq_ass/renamed/CLE_mira_bait/

/home/path/path/mira_4.9.5_2_linux-gnu_x86_64_static/bin/mirabait -I -k 15 -b /home/path/scratch/H_sac/H_sac_RNAseq_ass/renamed/CLE_mira_bait/cle.fasta -p path/deNovoTranscriptome/fastq14112016/raw/R1.fastq path/deNovoTranscriptome/fastq14112016/raw/R2.fastq

#cd path/deNovoTranscriptome/fastq14112016/raw/
#gzip *

cd /home/path/scratch/H_sac/H_sac_RNAseq_ass/renamed/CLE_mira_bait/
echo About to run Trinity!
/home/path/path/trinityrnaseq-2.1.1/Trinity --min_contig_length 100 --seqType fq --max_memory 100G --left bait_match_R1.fastq --right bait_match_R2.fastq --seqType fq --CPU 16 --min_kmer_cov 1 --SS_lib_type FR --output Trinity_cle_denovo_baitk15_minlen100_mincov1
wait
echo trinity is finished...!!!!!!!!!!!!!!!!!!


#blast to xml
makeblastdb -in ./Trinity_cle_denovo_baitk15_minlen100_mincov1/Trinity.fasta -dbtype nucl
echo "step2: blast to xml"
bl_p="tblastn -db ./Trinity_cle_denovo_baitk15_minlen100_mincov1/Trinity.fasta -query cle.aa.fasta
	  -seg no -num_threads ${threads} 
      -outfmt 5 -out Trinity.fasta_vs_CLE_fa.xml"
echo ${bl_p}
eval ${bl_p}
wait



# convert the xml
echo "step3: convert the xml file"
parse_xml="python ${python_directory}/BLAST_parser_return_hits_NAME_only.py 
		  -i Trinity.fasta_vs_CLE_fa.xml 
		  -o Trinity.fasta_vs_CLE_fa.xml.condensed.out"
echo ${parse_xml}
eval ${parse_xml}
wait

