#!/bin/sh
#SBATCH --mail-user=your_email@university.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --time=0:30:00
#SBATCH --mem=2GB
#SBATCH -o RNA_QC_%A_%a.out
#SBATCH --array=1-500%100

module purge
module load GCC/11.3.0
module load SAMtools/1.18

#############################################
## script created by Audrey Arner 		   ## 
#############################################

identifier=`sed -n ${SLURM_ARRAY_TASK_ID}p /filepath/IDs.txt`

barcode=/nobackup/lea_lab/arneram/tmp_OA_PBMC/${identifier}.Log.final.out

head -9 $barcode | tail -1 | echo "$identifier $(cut -f 2)" >> PBMC_unique_mapped_round2.txt

head -6 $barcode | tail -1 | echo "$identifier $(cut -f 2)" >> PBMC_total_reads_round2.txt

head -10 $barcode | tail -1 | echo "$identifier $(cut -f 2)" >> PBMC_unique_percent_round2.txt

head -27 $barcode | tail -1 | echo "$identifier $(cut -f 2)" >> PBMC_multi_percent_round2.txt
