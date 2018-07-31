#!/bin/bash
#$ -cwd
cd /home/path/scratch/H_sac/shell_scripts
./Hsah_vs_Gpal_effectors.sh
wait
#./Hsah_vs_Gros_effectors.sh
wait
./Hsah_vs_Gpal.sh

