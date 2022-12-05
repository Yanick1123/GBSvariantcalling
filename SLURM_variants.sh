#!/bin/bash

#SBATCH -D PATH/TO/WORKING/DIRECTORY
#SBATCH -J samtools
#SBATCH -o samtools%j.out
#SBATCH -c 4
#SBATCH -p PARTITION/NAME	
#SBATCH --mail-type=ALL
#SBATCH --mail-user=EMAIL/ADDRESS
#SBATCH --time=1-00:00
#SBATCH --mem=1G

module load samtools/1.8
module load bcftools/1.8
module load htslib/1.8

DATA=PATH/TO/BAMLIST
REF=PATH/TO/REF/GENOME
OUT=variantcalling
CPU=4

cd PATH/TO/BAMFILES

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
