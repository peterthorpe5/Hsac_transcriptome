#!/bin/bash
#$ -cwd

cd ./pete_assembly_default_trimmo

# transrate command
transrate --assembly Trinity.fasta --left /mnt/shared/scratch/sb42178/deNovoTranscriptome/fastq14112016/raw/R1.fq.gz --right /mnt/shared/scratch/sb42178/deNovoTranscriptome/fastq14112016/raw/R2.fq.gz --threads 12

cd ./transrate_results/Trinity

transrate --assembly good.Trinity.fasta --left /mnt/shared/scratch/sb42178/deNovoTranscriptome/fastq14112016/raw/R1.fq.gz --right /mnt/shared/scratch/sb42178/deNovoTranscriptome/fastq14112016/raw/R2.fq.gz --threads 8
