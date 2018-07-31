#$ -l hostname="n13*"
#$ -pe smp 6
cd /home/path/scratch/H_sac/H_sac_RNAseq_ass/renamed/busco

# need to make a symbolic link to LINAGE
mkdir LINEAGE
#~ NOTE the nematode dataset was downloaded and used in place og Metazo models. 
ln -s ~/scratch/Downloads/BUSCO_v1.1b1/Metazoa ./LINEAGE/



python3 path/BUSCO_v1.1b1/BUSCO_v1.1b1.py -in /home/path/scratch/H_sac/H_sac_RNAseq_ass/renamed/good.Trinity.fasta -l ../LINEAGE/Metazoa -o good_trinity_BUSCO_metazoa  -m transcriptome -f -Z 827000000 --long --cpu 4 --species caenorhabditis
wait
python3 path/BUSCO_v1.1b1/BUSCO_v1.1b1.py -in /home/path/scratch/H_sac/H_sac_RNAseq_ass/renamed/Trinity.fasta -l ../LINEAGE/Metazoa -o trinity_BUSCO_metazoa  -m transcriptome -f -Z 827000000 --long --cpu 4 --species caenorhabditis
wait
python3 path/BUSCO_v1.1b1/BUSCO_v1.1b1.py -in /home/path/scratch/H_sac/H_sac_RNAseq_ass/renamed/good.Trinity.fasta.transdecoder.cds -l ../LINEAGE/Metazoa -o cds_BUSCO_metazoa  -m transcriptome -f -Z 827000000 --long --cpu 4 --species caenorhabditis
wait
#############################
python3 path/BUSCO_v1.1b1/BUSCO_v1.1b1.py -in /home/path/scratch/H_sac/H_sac_RNAseq_ass/renamed/Hsach_Full_assembly_contaminants_removed.fasta -l ../LINEAGE/Metazoa -o Hsach_Full_ass_cont_remov.fa_BUSCO_metazoa -m transcriptome -f -Z 827000000 --long --cpu 4 --species caenorhabditis
wait
python3 path/BUSCO_v1.1b1/BUSCO_v1.1b1.py -in /home/path/scratch/H_sac/H_sac_RNAseq_ass/renamed/Hsach_QC_RNAseq_Assembly_v1.fasta -l ../LINEAGE/Metazoa -o Hsach_QC_RNAseq_Ass_v1.fasta_BUSCO_metazoa -m transcriptome -f -Z 827000000 --long --cpu 4 --species caenorhabditis
wait
python3 path/BUSCO_v1.1b1/BUSCO_v1.1b1.py -in /home/path/scratch/H_sac/H_sac_RNAseq_ass/renamed/Hsach_QC_RNAseq_CDS.nt.fasta -l ../LINEAGE/Metazoa -o Hsach_QC_RNAseq_CDS.nt.fasta_BUSCO_metazoa -m transcriptome -f -Z 827000000 --long --cpu 4 --species caenorhabditis
wait
