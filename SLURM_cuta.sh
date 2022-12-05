#!/bin/bash

#SBATCH -D PATH/TO/YOUR/WORKING/DIRECTORY
#SBATCH -J cutadapt	
#SBATCH -o cutadapt%j.out
#SBATCH -c 1
#SBATCH -p PARTITION/NAME	
#SBATCH --mail-type=ALL
#SBATCH --mail-user=EMAIL/ADDRESS
#SBATCH --time=1-00:00
#SBATCH --mem=1G


module load cutadapt/3.2

cd PATH/TO/DEMULTIPLEXED/DATA
ADAP=AGATCGGAA
exec &> cutadapt.log
for i in *.fq;
	do
		cutadapt -a $ADAP -o $i.fastq $i
	done

