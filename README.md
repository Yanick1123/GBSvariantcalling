# GBSvariantcalling

This project is for executing variant calling in a genotyping-by-sequencing (GBS) analysis. Starting from NGS sequencing data you will end with a variant (VCF) file suited for downstream analysis.

## 1. Demultiplexing

You can obtain the Sabre tool by the following link: https://github.com/najoshi/sabre

After sending your DNA samples for sequencing you receive a file containing all your reads. Before performing any analysis you need to seperate individual sample into distinct FASTQ files. 
Sabre allow you to demultiplex your sequencing data into your original samples, making one read file per barcode used. Run the scrpit SLURM_sabre.sh after editing it with your personnal information. 

## 2. Adaptor trimming

You can obtain the Cutadapt tool by the following link: https://cutadapt.readthedocs.io/en/stable/installation.html

Now that you have individual fastq files for each of your DNA samples you need to trim the sequencing adaptors. In the process called the "librairies", the sequencing platform added a short DNA oligos called the adaptor. The adaptor is mandatory on every DNA molecule that will be sequenced, it allow the DNA molecule to anneal to the sequencing chip in order to be sequenced.
Edit the script SLURM_cuta.sh with your personnal informations and run it. You will end up with slightly smaller FASTQ files for each of your individual samples. 

## 3. Mapping

You can obtain the BWA tool by the following link: https://github.com/lh3/bwa

To find variants, you need to compare your sequencing data with a reference genome, this process is called a mapping. Each individual read is aligned to its corresponding region in your species genome. After this step you will obtain a mapping file in the SAM format.
Edit the script SLURM_bwa.sh with your personnal informations and run it.

## 4. SAM to BAM

You can obtain the BCFtools, Samtools, and htslib tool by the following link: http://www.htslib.org/download/

Before calling the variants you need to convert your SAM files into BAM files. Both contains the same information but the BAM are in binary format. It allow a reduction in size and also in computing power. Most variant caller perfers the BAM format.
Edit the script SLURM_sam2bam.sh with your personnal informations and run it.

## 5. Variant calling

The final step of the analysis is the variant calling. From the BAM mapping file, all the differences (variants) will be called between your sample and the reference genome provided earlier.
The result of this step will be a VCF file containing all the variants for your samples.
Edit the script SLURM_variants.sh with your personnal informations and run it.
