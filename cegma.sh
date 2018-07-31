#!/bin/bash
#Abort on any error,
set -e

cd path/De_analysis/

cegma -g Trinity.fasta --threads 4

