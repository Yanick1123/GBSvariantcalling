#!/bin/bash

#SBATCH -D /project/fbelzile/users/yaass9/homework/results/adapt
#SBATCH -J cutadapt	
#SBATCH -o cutadapt%j.out
#SBATCH -c 1
#SBATCH -p soyagen	
#SBATCH --mail-type=ALL
#SBATCH --mail-user=yanick.asselin.1@ulaval.ca
#SBATCH --time=1-00:00
#SBATCH --mem=1G


module load cutadapt/3.2

cd /project/fbelzile/users/yaass9/homework/results/barcodes
ADAP=AGATCGGAA
exec &> cutadapt.log
for i in *.fq;
	do
		cutadapt -a $ADAP -o $i.fastq $i
	done

#cutadapt -a AGATCGGAA -o /project/fbelzile/users/yaass9/homework/results/adapt/*.fastq /project/fbelzile/users/yaass9/homework/results/barcodes/*.fq