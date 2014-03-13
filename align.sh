#!/bin/bash -x
# Assemble contigs using velvet and generate summary statistics using 
# process_contigs.pl
#$ -S /bin/bash
#$ -cwd
#$ -pe smp 4
#$ -l virtual_free=4G

WORK_DIR=P.cact_assembly
HASH_LENGTH=$1
FORWARD_FILE=$2
REVERSE_FILE=$3
ASSEMBLY_NAME=$4
WORK_DIR=$TMPDIR

echo "Hash length = $HASH_LENGTH"
echo "Forward file = $FORWARD_FILE"
echo "Reverse file = $REVERSE_FILE"
echo "Assembly name = $ASSEMBLY_NAME"

velveth $WORK_DIR $HASH_LENGTH -fastq -shortPaired -separate $FORWARD_FILE $REVERSE_FILE
velvetg $WORK_DIR -long_mult_cutoff 1 -exp_cov 6 -ins_length 700 -cov_cutoff 2 -min_contig_lgth 750
process_contigs.pl -i $WORK_DIR/contigs.fa -o $ASSEMBLY_NAME.$HASH_LENGTH

rm -R $WORK_DIR

