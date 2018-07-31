#$ -l hostname="n13*"
#$ -pe smp 8

cd /deNovoTranscriptome/pete_assembly_default_trimmo

# diamond blast vs NR
diamond blastp -p 8 --sensitive -e 0.00001 -v -q good.Trinity.fasta.transdecoder.longest.pep -d /path/blast_databases/nr.dmnd -a good.Trinity.fasta.transdecoder.longest.pep_vs_nr.da
#
diamond view -a good.Trinity.fasta.transdecoder.longest.pep*.daa -f tab -o good.Trinity.fasta.transdecoder.longest.pep_vs_nr.tab
#
## annotate tax with tool
python ~/misc_python/diamond_blast_to_kingdom/Diamond_blast_to_taxid_add_kingdom_add_species_description.py -i good.Trinity.fasta.transdecoder.longest.pep_vs_nr.tab -p /path/blast_databases -o good.Trinity.fasta.transdecoder.longest.pep_vs_nr_tax.tab
#
## HGT prediction tool 
# nematoda = 6231
python /home/path/misc_python/Lateral_gene_transfer_prediction_tool/Lateral_gene_transfer_predictor.py -i *_vs_nr_tax.tab -a 20 --tax_filter_out 6656 --tax_filter_up_to 6231 -p /path/blast_databases -o LTG_results.out
#

## filter HGT results. 
## python ~/misc_python/Lateral_gene_transfer_prediction_tool/check_contaminants_on_contigs.py --gff Mcerasi_Mp.models_RNAseq.v4.20160222.gff --LTG LTG_LGT_candifates_AI.out -s 0 -r ?? -g ../Myzus_cerasi_genome_assembly.v1.fasta --dna ../good.Trinity.fasta.transdecoder.longest.pep -o test | grep -v "expression: 0"
#
#
#################################################################################################################################################################################################
