#source activate samtools_env


#/Users/morril01/anaconda3/pkgs/bwa-0.7.17-h2573ce8_7/bin/bwa index output/genome.fa

/Users/morril01/anaconda3/pkgs/bwa-0.7.17-h2573ce8_7/bin/bwa mem -k 5 -a output/genome.fa output/sim_transloc_reads.fa | /Users/morril01/software/samtools-1.13/samtools sort -o output/aligned_sim_transloc_reads.bam -

/Users/morril01/software/samtools-1.13/samtools index output/aligned_sim_transloc_reads.bam


