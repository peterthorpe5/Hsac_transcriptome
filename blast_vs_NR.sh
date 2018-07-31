#!/bin/bash
#$ -cwd
#Abort on any error,
#set -e


# for nematoda
phylum_filter_out=6321
species_tx_id=157861
#  Stramenopiles - metazoan
tax_filter_up_to=33208 

cd /home/path/scratch/H_sac/H_sac_RNAseq_ass/renamed


echo "running diamond-BLAST against NR"
diam_p="/home/path/scratch/path/diamond-master/diamond blastp -p 8 --more-sensitive -e 0.00001 
	   -v -q good.Trinity.fasta.transdecoder.pep
	   -d $HOME/scratch/blast_databases/nr.dmnd 
	   --taxonmap $HOME/scratch/blast_databases/prot.accession2taxid.gz
	   --outfmt 6 
	   --out good.Trinity.fasta.transdecoder.pep_vs_nr.tab"
echo ${diam_p}
eval ${diam_p}
wait


echo "adding tx_id and descriptions to diamond-BLAST output"
tax="python $HOME/public_scripts/Diamond_BLAST_add_taxonomic_info/Diamond_blast_to_taxid.py
	-i good.Trinity.fasta.transdecoder.pep_vs_nr.tab 
	-p $HOME/scratch/blast_databases 
	-o good.Trinity.fasta.transdecoder.pepsta_vs_nr_tax2.tab"
echo ${tax}
eval ${tax}
wait



#Filter taxomony commands:
echo "filtering blast results"
filter_top_blasts="python $HOME/misc_python/BLAST_output_parsing/top_BLAST_hit_filter_out_tax_id.py 
				  -i *_vs_nr_tax.tab 
				  -t 6231 
				  -p $HOME/scratch/blast_databases 
				  -o top_not_phylum_nematoda.hits"
echo ${filter_top_blasts}
eval ${filter_top_blasts}
wait

filter_species="python $HOME/misc_python/BLAST_output_parsing/top_BLAST_hit_filter_out_tax_id.py 
			   -i *_vs_nr_tax.tab 
			   -t 157861
			   -p $HOME/scratch/blast_databases 
			   -o top_not_species_tx_id_Hsacchhari.hits"
echo ${filter_species}
eval ${filter_species}
wait

echo "predicting HGT"
HGT="python $HOME/public_scripts/Lateral_gene_transfer_prediction_tool/Lateral_gene_transfer_predictor.py -i good.Trinity.fasta.transdecoder.pepsta_vs_nr_tax.tab --tax_filter_out 6231 --tax_filter_up_to 33208 -p $HOME/scratch/blast_databases -o LTG_results.out"
echo ${HGT}
eval ${HGT}
wait
#

echo "predicting HGT"
HGT_filter="python $HOME/public_scripts/Lateral_gene_transfer_prediction_tool/check_contaminants_on_contigs.py 
--LTG LTG_LGT_candifates.out --gff good.Trinity.fasta.transdecoder.gff3 
--dna good.Trinity.fasta.transdecoder.cds -g good.Trinity.fasta 
-r ./HGT/old/HGT_filtering/Trinity.fasta_quant.sf 
-o HGT_filtered_20170530.txt"
echo ${HGT_filter}
eval ${HGT_filter}
wait

echo ................................................................ im done
