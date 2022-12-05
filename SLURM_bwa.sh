#!/bin/bash

#SBATCH -D PATH/TO/YOUR/MAIN/DIRECTORY
#SBATCH -J bwa
#SBATCH -o bwa%j.out
#SBATCH -c 6
#SBATCH -p PARTITION/NAME	
#SBATCH --mail-type=ALL
#SBATCH --mail-user=EMAIL/ADDRESS
#SBATCH --time=1-00:00
#SBATCH --mem=6G

module load bwa/0.7.17

DATA=PATH/TO/DATA
REF=PATH/TO/REF/GENOME
CPU=3
THR=2

exec &> bwa.log

cd $DATA
		parallel -j $CPU bwa mem -t $THR $REF {}.fastq ">" {}.sam ::: $(ls -1 *.fastq | sed 's/.fastq//')
		if [ $? -ne 0 ]
			then 
				printf There is a problem in the alignment step
				exit 1
		fi
