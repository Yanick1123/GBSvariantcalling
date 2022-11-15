#!/bin/bash

#SBATCH -D /project/fbelzile/users/yaass9/homework/results/barcodes
#SBATCH -J sabre	
#SBATCH -o sabre%j.out
#SBATCH -c 1
#SBATCH -p soyagen	
#SBATCH --mail-type=ALL
#SBATCH --mail-user=yanick.asselin.1@ulaval.ca
#SBATCH --time=1-00:00
#SBATCH --mem=1G 

# Load the software with module if applicable:
module load sabre/1.000

DATA=/project/fbelzile/users/yaass9/homework/data/FC20150701_1.fq.gz
BARCODE=/project/fbelzile/users/yaass9/homework/data/FC20150701_1.txt
#TOOL=path/to/sabre

exec &> sabre.log

sabre se -f $DATA -b $BARCODE -u unk.fastq

#sabre se -f /project/fbelzile/users/yaass9/homework/data/FC20150701_1.fq.gz -b /project/fbelzile/users/yaass9/homework/data/FC20150701_1.txt -u unk.fastq