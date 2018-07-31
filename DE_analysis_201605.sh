#!/bin/bash
#Abort on any error,
set -e

cd path/De_analysis/

# matrix
#path/trinityrnaseq-2.2.0/util/abundance_estimates_to_matrix.pl --est_method kallisto --cross_sample_norm TMM --name_sample_by_basedir ./*_N116_D2A_1/abundance.tsv ./*_N116_D2A_2/abundance.tsv ./*_N116_D2A_3/abundance.tsv ./*_PS01_A17_1/abundance.tsv ./*_PS01_A17_2/abundance.tsv ./*_PS01_D2A_1/abundance.tsv ./*_PS01_D2A_2/abundance.tsv ./*_PS01_D2A_3/abundance.tsv ./*_N116_A17_1/abundance.tsv ./*_N116_A17_2/abundance.tsv ./*_N116_A17_3/abundance.tsv --out_prefix *_GG_2016N116_PS01.matrix

# no biological reps:   $TRINITY_HOME/Analysis/DifferentialExpression/run_DE_analysis.pl --matrix counts.matrix --method edgeR --dispersion 0.1
path/trinityrnaseq-2.2.0/Analysis/DifferentialExpression/run_DE_analysis.pl --matrix *.counts.matrix --method edgeR --dispersion 0.1 --output transcripts_DE_analysis
# with reps - need to make sample_file
path/trinityrnaseq-2.2.0/Analysis/DifferentialExpression/run_DE_analysis.pl --matrix *.counts.matrix --method edgeR --samples_file samples_described.txt --output transcripts_DE_analysis

wait 

##################################################################

#cd ..
cd path/De_analysis/transcripts_DE_analysis

path/trinityrnaseq-2.2.0/Analysis/DifferentialExpression/analyze_diff_expr.pl --matrix ../*.TMM.EXPR.matrix -P 0.05 -C 2 --max_genes_clust 50000 --samples ../samples_described.txt
wait 

path/trinityrnaseq-2.2.0/Analysis/DifferentialExpression/analyze_diff_expr.pl --matrix ../*.TMM.EXPR.matrix -P 1e-2 -C 2 --max_genes_clust 50000 --samples ../samples_described.txt
wait 

path/trinityrnaseq-2.2.0/Analysis/DifferentialExpression/analyze_diff_expr.pl --matrix ../*.TMM.EXPR.matrix -P 1e-3 -C 2 --max_genes_clust 50000 --samples ../samples_described.txt
wait 

path/trinityrnaseq-2.2.0/Analysis/DifferentialExpression/analyze_diff_expr.pl --matrix ../*.TMM.EXPR.matrix -P 1e-4 -C 2 --max_genes_clust 50000 --samples ../samples_described.txt
wait 

path/trinityrnaseq-2.2.0/Analysis/DifferentialExpression/analyze_diff_expr.pl --matrix ../*.TMM.EXPR.matrix -P 1e-5 -C 2 --max_genes_clust 50000 --samples ../samples_described.txt

####################################

path/trinityrnaseq-2.2.0/Analysis/DifferentialExpression/define_clusters_by_cutting_tree.pl --Ptree 40 -R diffExpr.P0.05_C2.matrix.RData
wait 


mv path/De_analysis/transcripts_DE_analysis/*_P_40.heatmap.heatmap.pdf path/De_analysis/transcripts_DE_analysis/diffExpr.P0.05_C2.matrix.RData.clusters_fixed_P_40
wait 


path/trinityrnaseq-2.2.0/Analysis/DifferentialExpression/define_clusters_by_cutting_tree.pl --Ptree 50 -R diffExpr.P0.05_C2.matrix.RData
wait 


mv path/De_analysis/transcripts_DE_analysis/*_P_50.heatmap.heatmap.pdf path/De_analysis/transcripts_DE_analysis/diffExpr.P0.05_C2.matrix.RData.clusters_fixed_P_50
wait 


path/trinityrnaseq-2.2.0/Analysis/DifferentialExpression/define_clusters_by_cutting_tree.pl --Ptree 60 -R diffExpr.P0.05_C2.matrix.RData
wait 


mv path/De_analysis/transcripts_DE_analysis/*_P_60.heatmap.heatmap.pdf path/De_analysis/transcripts_DE_analysis/diffExpr.P0.05_C2.matrix.RData.clusters_fixed_P_60
wait 


path/trinityrnaseq-2.2.0/Analysis/DifferentialExpression/define_clusters_by_cutting_tree.pl --Ptree 70 -R diffExpr.P0.05_C2.matrix.RData
wait 


mv path/De_analysis/transcripts_DE_analysis/*_P_70.heatmap.heatmap.pdf path/De_analysis/transcripts_DE_analysis/diffExpr.P0.05_C2.matrix.RData.clusters_fixed_P_70

wait 




################################
#########################################################################################

#########################
#####################################################################################
path/trinityrnaseq-2.2.0/Analysis/DifferentialExpression/define_clusters_by_cutting_tree.pl --Ptree 40 -R diffExpr.P1e-2_C2.matrix.RData
wait 


mv path/De_analysis/transcripts_DE_analysis/*_P_40.heatmap.heatmap.pdf path/De_analysis/transcripts_DE_analysis/diffExpr.P1e-2_C2.matrix.RData.clusters_fixed_P_40
wait 


path/trinityrnaseq-2.2.0/Analysis/DifferentialExpression/define_clusters_by_cutting_tree.pl --Ptree 50 -R diffExpr.P1e-2_C2.matrix.RData
wait 


mv path/De_analysis/transcripts_DE_analysis/*_P_50.heatmap.heatmap.pdf path/De_analysis/transcripts_DE_analysis/diffExpr.P1e-2_C2.matrix.RData.clusters_fixed_P_50
wait 


path/trinityrnaseq-2.2.0/Analysis/DifferentialExpression/define_clusters_by_cutting_tree.pl --Ptree 60 -R diffExpr.P1e-2_C2.matrix.RData
wait 


mv path/De_analysis/transcripts_DE_analysis/*_P_60.heatmap.heatmap.pdf path/De_analysis/transcripts_DE_analysis/diffExpr.P1e-2_C2.matrix.RData.clusters_fixed_P_60
wait 


path/trinityrnaseq-2.2.0/Analysis/DifferentialExpression/define_clusters_by_cutting_tree.pl --Ptree 70 -R diffExpr.P1e-2_C2.matrix.RData
wait 


mv path/De_analysis/transcripts_DE_analysis/*_P_70.heatmap.heatmap.pdf path/De_analysis/transcripts_DE_analysis/diffExpr.P1e-2_C2.matrix.RData.clusters_fixed_P_70

wait 




################################
#########################################################################################
path/trinityrnaseq-2.2.0/Analysis/DifferentialExpression/define_clusters_by_cutting_tree.pl --Ptree 40 -R diffExpr.P1e-3_C2.matrix.RData
wait 


mv path/De_analysis/transcripts_DE_analysis/*_P_40.heatmap.heatmap.pdf path/De_analysis/transcripts_DE_analysis/diffExpr.P1e-3_C2.matrix.RData.clusters_fixed_P_40
wait 


path/trinityrnaseq-2.2.0/Analysis/DifferentialExpression/define_clusters_by_cutting_tree.pl --Ptree 50 -R diffExpr.P1e-3_C2.matrix.RData
wait 


mv path/De_analysis/transcripts_DE_analysis/*_P_50.heatmap.heatmap.pdf path/De_analysis/transcripts_DE_analysis/diffExpr.P1e-3_C2.matrix.RData.clusters_fixed_P_50
wait 


path/trinityrnaseq-2.2.0/Analysis/DifferentialExpression/define_clusters_by_cutting_tree.pl --Ptree 60 -R diffExpr.P1e-3_C2.matrix.RData
wait 

# -K <int> define k clusters.

path/trinityrnaseq-2.2.0/Analysis/DifferentialExpression/define_clusters_by_cutting_tree.pl --K 2 -R diffExpr.P1e-3_C2.matrix.RData

path/trinityrnaseq-2.2.0/Analysis/DifferentialExpression/define_clusters_by_cutting_tree.pl --K 5 -R diffExpr.P1e-3_C2.matrix.RData

mv path/De_analysis/transcripts_DE_analysis/*_P_60.heatmap.heatmap.pdf path/De_analysis/transcripts_DE_analysis/diffExpr.P1e-3_C2.matrix.RData.clusters_fixed_P_60
wait 


path/trinityrnaseq-2.2.0/Analysis/DifferentialExpression/define_clusters_by_cutting_tree.pl --Ptree 70 -R diffExpr.P1e-3_C2.matrix.RData
wait 


mv path/De_analysis/transcripts_DE_analysis/*_P_70.heatmap.heatmap.pdf path/De_analysis/transcripts_DE_analysis/diffExpr.P1e-3_C2.matrix.RData.clusters_fixed_P_70
wait 


###########################################################


path/trinityrnaseq-2.2.0/Analysis/DifferentialExpression/define_clusters_by_cutting_tree.pl --Ptree 40 -R diffExpr.P1e-4_C2.matrix.RData
wait 

path/trinityrnaseq-2.2.0/Analysis/DifferentialExpression/define_clusters_by_cutting_tree.pl --K 3 -R diffExpr.P1e-4_C2.matrix.RData

path/trinityrnaseq-2.2.0/Analysis/DifferentialExpression/define_clusters_by_cutting_tree.pl --K 4 -R diffExpr.P1e-4_C2.matrix.RData

path/trinityrnaseq-2.2.0/Analysis/DifferentialExpression/define_clusters_by_cutting_tree.pl --K 5 -R diffExpr.P1e-4_C2.matrix.RData

path/trinityrnaseq-2.2.0/Analysis/DifferentialExpression/define_clusters_by_cutting_tree.pl --K 6 -R diffExpr.P1e-4_C2.matrix.RData



mv path/De_analysis/transcripts_DE_analysis/*_P_40.heatmap.heatmap.pdf path/De_analysis/transcripts_DE_analysis/diffExpr.P1e-4_C2.matrix.RData.clusters_fixed_P_40
wait 


path/trinityrnaseq-2.2.0/Analysis/DifferentialExpression/define_clusters_by_cutting_tree.pl --Ptree 50 -R diffExpr.P1e-4_C2.matrix.RData
wait 


mv path/De_analysis/transcripts_DE_analysis/*_P_50.heatmap.heatmap.pdf path/De_analysis/transcripts_DE_analysis/diffExpr.P1e-4_C2.matrix.RData.clusters_fixed_P_50
wait 


path/trinityrnaseq-2.2.0/Analysis/DifferentialExpression/define_clusters_by_cutting_tree.pl --Ptree 60 -R diffExpr.P1e-4_C2.matrix.RData
wait 


mv path/De_analysis/transcripts_DE_analysis/*_P_60.heatmap.heatmap.pdf path/De_analysis/transcripts_DE_analysis/diffExpr.P1e-4_C2.matrix.RData.clusters_fixed_P_60
wait 


path/trinityrnaseq-2.2.0/Analysis/DifferentialExpression/define_clusters_by_cutting_tree.pl --Ptree 70 -R diffExpr.P1e-4_C2.matrix.RData
wait 


mv path/De_analysis/transcripts_DE_analysis/*_P_70.heatmap.heatmap.pdf path/De_analysis/transcripts_DE_analysis/diffExpr.P1e-4_C2.matrix.RData.clusters_fixed_P_70
wait 


#########################################################

path/trinityrnaseq-2.2.0/Analysis/DifferentialExpression/define_clusters_by_cutting_tree.pl --Ptree 40 -R diffExpr.P1e-5_C2.matrix.RData
wait 


mv path/De_analysis/transcripts_DE_analysis/*_P_40.heatmap.heatmap.pdf path/De_analysis/transcripts_DE_analysis/diffExpr.P1e-5_C2.matrix.RData.clusters_fixed_P_40
wait 


path/trinityrnaseq-2.2.0/Analysis/DifferentialExpression/define_clusters_by_cutting_tree.pl --Ptree 50 -R diffExpr.P1e-5_C2.matrix.RData
wait 


mv path/De_analysis/transcripts_DE_analysis/*_P_50.heatmap.heatmap.pdf path/De_analysis/transcripts_DE_analysis/diffExpr.P1e-5_C2.matrix.RData.clusters_fixed_P_50
wait 


path/trinityrnaseq-2.2.0/Analysis/DifferentialExpression/define_clusters_by_cutting_tree.pl --Ptree 60 -R diffExpr.P1e-5_C2.matrix.RData
wait 


mv path/De_analysis/transcripts_DE_analysis/*_P_60.heatmap.heatmap.pdf path/De_analysis/transcripts_DE_analysis/diffExpr.P1e-5_C2.matrix.RData.clusters_fixed_P_60
wait 


path/trinityrnaseq-2.2.0/Analysis/DifferentialExpression/define_clusters_by_cutting_tree.pl --Ptree 70 -R diffExpr.P1e-5_C2.matrix.RData
wait 


mv path/De_analysis/transcripts_DE_analysis/*_P_70.heatmap.heatmap.pdf path/De_analysis/transcripts_DE_analysis/diffExpr.P1e-5_C2.matrix.RData.clusters_fixed_P_70



