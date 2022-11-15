#!/bin/bash

#SBATCH -D /project/fbelzile/users/yaass9/homework/results/mapping
#SBATCH -J bwa
#SBATCH -o bwa%j.out
#SBATCH -c 6
#SBATCH -p soyagen	
#SBATCH --mail-type=ALL
#SBATCH --mail-user=yanick.asselin.1@ulaval.ca
#SBATCH --time=1-00:00
#SBATCH --mem=6G

module load bwa/0.7.17

DATA=/project/fbelzile/users/yaass9/homework/results/adapt
REF=/project/fbelzile/users/yaass9/homework/genome/Gmax_275_v2.0.fa
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