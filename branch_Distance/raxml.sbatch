#!/bin/bash
#SBATCH --job-name=cactus_RAxML
#SBATCH --mail-type=ALL
#SBATCH --mail-user=cactus@ufl.edu
#SBATCH -o job_%j.out
#SBATCH -e error.file
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=1024mb
#SBATCH -t 100:00:00
 
module load raxml
 
raxmlHPC -f e -t input.tre -m GTRGAMMA -s Ordway_site_reconciled_562_OT.algnment -n Ordway_site_reconciled_562_OT_estBr.tre
