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

module load samtools/1.15
module load bcftools/1.15
module load htslib/1.15

CPU=4

cd PATH/TO/MAPPING/FILES

# create a log file
exec &> convert.log

# convert SAM format to BAM format

parallel -j $CPU samtools view -b -S -h {}.sam ">" {}.temp.bam ::: $(ls -1 *.sam | sed 's/.sam//')
		if [ $? -ne 0 ]
			then 
				printf "There is a problem in the samtools-view step"
				exit 1
		fi
# sort BAM files

parallel -j $CPU samtools sort {}.temp.bam -o {}.sort.bam ::: $(ls -1 *.temp.bam | sed 's/.temp.bam//')
		if [ $? -ne 0 ]
			then 
				printf "There is a problem in the samtools-sort step"
				exit 1
		fi

# indexing of BAM files
parallel -j $CPU samtools index {} ::: $(ls -1 *.sort.bam)
		if [ $? -ne 0 ]
			then 
				printf "There is a problem in the samtools-index step"
				exit 1
		fi

# create a list of BAM files with path

for i in $(ls -1 *.sort.bam)
			do
				printf "$PWD/${i}\n" >> "bamlist"
				if [ $? -ne 0 ]
					then 
					printf "There is a problem in the production of the bam file list"
					exit 1
				fi
			done
