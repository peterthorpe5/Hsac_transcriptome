#!/bin/bash
#$ -cwd
#Abort on any error,
#set -e

#echo Running on $HOSTNAME
#echo Current PATH is $PATH
#source $HOME/.bash_profile

#make blastdb
echo "step1: make blastdb"
mkdb="makeblastdb -in ${test_fa} -dbtype prot"
echo ${mkdb}
eval ${mkdb}
wait

#blast to xml
echo "step2: blast to xml"
bl_p="blastp -db ${test_fa} -query ${known_fa} -evalue 0.00001 
	  -seg no -num_threads ${threads} 
      -outfmt 5 -out test_fa_vs_known_fa.xml"
echo ${bl_p}
eval ${bl_p}
wait

mkdir known_fa_all_hits

#blast 2 tab
echo "step2b: blast to tab - top hit only"
bl_p2="blastp -db ${test_fa} -query ${known_fa} -evalue 1e-10 
	  -seg no -max_target_seqs 1 -num_threads ${threads} 
	  -outfmt 7 -out test_fa_vs_known_fa.tab"
echo ${bl_p2}
eval ${bl_p2}
wait

#blast 2 tab
echo "step2b: blast to tab - top hit only"
no_comment="grep -v '#' test_fa_vs_known_fa.tab > test_fa_vs_known_fa2.tab "
echo ${no_comment}
eval ${no_comment}
wait

# graph the blast results
graph="python ${python_directory}/blast_stats.py 
	  -i test_fa_vs_known_fa.tab 
	  -o test_fa_vs_known_fa.graphs"
echo ${graph}
eval ${graph}
wait


# convert the xml
echo "step3: convert the xml file"
parse_xml="python ${python_directory}/BLAST_parser_return_hits_NAME_only.py 
		  -i test_fa_vs_known_fa.xml 
		  -o test_fa_vs_known_fa.xml.condensed.out"
echo ${parse_xml}
eval ${parse_xml}
wait

# get the matches seq for the tab blast to the effectors
echo "step4: get the seqs of the top hit."
get_seq="python ${python_directory}/Get_sequence_from_tab_blast.py 
	    -b test_fa_vs_known_fa.tab 
		--known_fa ${known_fa}
		--folder known_fa_all_hits
		-p ${test_fa} 
		-n ${test_fa}"
echo ${get_seq}
eval ${get_seq}
wait

# change to where the file have been put
cd ./known_fa_all_hits

# delete empty files
delete_empty="find . -size 0 -delete"
echo ${delete_empty}
eval ${delete_empty}
wait

filenames=*.fasta

for f in ${filenames}
do
	echo "Running muscle ${f}"
	cmd="$HOME/path/muscle3.8.31_i86linux64 -in ${f} 
		-out ${f}_aligned.fasta -maxiters 5000 -maxtrees 15" 
	echo ${cmd}
	eval ${cmd}
	wait
done

filenames2=*_aligned.fasta
for file in ${filenames2}
do
	echo "Running muscle ${f}"
	cmd="$HOME/path/muscle3.8.31_i86linux64 
		-in ${file} -out ${file}_refine.fasta 
		-refine" 
	echo ${cmd}
	eval ${cmd}
	wait
done
	
rm *_aligned.fasta

mkdir alignments
mv *_refine.fasta ./alignments

###########################################################################
# diamond blast aginst NR?
cd ${Working_directory}

echo "running diamond-BLAST against NR"
diam_p="/home/path/scratch/path/diamond-master/diamond blastp -p ${threads} --more-sensitive -e 0.00001 
	   -v -q aa.fa
	   -d $HOME/scratch/blast_databases/nr.dmnd 
	   --taxonmap $HOME/scratch/blast_databases/prot.accession2taxid.gz
	   --outfmt 6 
	   --out aa.fasta_vs_nr.tab"
echo ${diam_p}
eval ${diam_p}
wait


echo "adding tx_id and descriptions to diamond-BLAST output"
tax="python $HOME/public_scripts/Diamond_BLAST_add_taxonomic_info/Diamond_blast_to_taxid.py
	-i aa.fasta_vs_nr.tab 
	-p $HOME/scratch/blast_databases 
	-o aa.fasta_vs_nr_tax.tab"
echo ${tax}
eval ${tax}
wait

echo "predicting HGT"
HGT="python $HOME/public_scripts/Lateral_gene_transfer_prediction_tool/Lateral_gene_transfer_predictor.py
		-i *_vs_nr_tax.tab 
		--tax_filter_out ${tax_filter_out} 
		--tax_filter_up_to ${tax_filter_up_to}
		-p $HOME/scratch/blast_databases -o LTG_results.out"

echo ${HGT}
eval ${HGT}
wait
#

#Filter taxomony commands:
echo "filtering blast results"
filter_top_blasts="python $HOME/misc_python/BLAST_output_parsing/top_BLAST_hit_filter_out_tax_id.py 
				  -i *_vs_nr_tax.tab 
				  -t ${tax_filter_out} 
				  -p $HOME/scratch/blast_databases 
				  -o top_not_phylum_${tax_filter_out}.hits"
echo ${filter_top_blasts}
eval ${filter_top_blasts}
wait

filter_species="python $HOME/misc_python/BLAST_output_parsing/top_BLAST_hit_filter_out_tax_id.py 
			   -i *_vs_nr_tax.tab 
			   -t ${species_tx_id}
			   -p $HOME/scratch/blast_databases 
			   -o top_not_species_tx_id_${species_tx_id}.hits"
echo ${filter_species}
eval ${filter_species}
wait


#################################################################################
# change back to the working directory
# Run transrate?
cd ${Working_directory}
echo "Running transrate to get RNAseq mapping and it will tell you 
statistically what genes may be fusions. "
tran="transrate --assembly nt.fa 
	 --left ${left_reads} 
	 --right ${right_reads}"
echo ${tran}
eval ${tran}

echo ................................................................ im done
