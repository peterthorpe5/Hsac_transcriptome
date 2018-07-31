#!/bin/bash

cd /mnt/shared/scratch/sb42178/deNovoTranscriptome/fastq14112016/raw

java -jar /home/path/path/Trimmomatic-0.32/trimmomatic-0.32.jar PE -threads 16 -phred33 r1.fq r2.fq R1.fq.gz crap_R1_unpaired.fq.gz R2.fq.gz crap_R2_unpaired.fq.gz ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:60  

