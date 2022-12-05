#!/bin/bash

#SBATCH -D PATH/TO/WORKING/DIRECTORY
#SBATCH -J sabre	
#SBATCH -o sabre%j.out
#SBATCH -c 1
#SBATCH -p PARTITION/NAME	
#SBATCH --mail-type=ALL
#SBATCH --mail-user=EMAIL/ADDRESS
#SBATCH --time=1-00:00
#SBATCH --mem=1G 

# Load the software with module if applicable:
module load sabre/1.000

DATA=PATH/TO/SEQ/DATA
BARCODE=PATH/TO/BARCODE/FILE


exec &> sabre.log

sabre se -f $DATA -b $BARCODE -u unk.fastq

