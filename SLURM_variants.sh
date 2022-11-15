#!/bin/bash

#SBATCH -D /project/fbelzile/users/yaass9/homework/results/variants
#SBATCH -J samtools
#SBATCH -o samtools%j.out
#SBATCH -c 4
#SBATCH -p soyagen	
#SBATCH --mail-type=ALL
#SBATCH --mail-user=yanick.asselin.1@ulaval.ca
#SBATCH --time=1-00:00
#SBATCH --mem=1G

module load samtools/1.8
module load bcftools/1.8
module load htslib/1.8

DATA=/project/fbelzile/users/yaass9/homework/results/mapping/bamlist
REF=/project/fbelzile/users/yaass9/homework/genome/Gmax_275_v2.0.fa
OUT=variantcalling
CPU=4

cd /project/fbelzile/users/yaass9/homework/results/variants

exec &> samt_var.log

samtools mpileup -g -f $REF -b $DATA > variants.bcf

	if [ $? -ne 0 ]
                        then
                                printf "There is a problem at the samtools_mpileup step"
                                exit 1
                fi


bcftools call -mv variants.bcf > variants.vcf

	if [ $? -ne 0 ]
                        then
                                printf "There is a problem at the bcf2vcf step"
                                exit 1
                fi