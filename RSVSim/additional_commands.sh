#conda create --name samtools_env
source activate samtools_env
conda install -c bioconda/label/cf201901 samtools
source deactivate

## index genome file
#/Users/morril01/anaconda3/pkgs/bwa-0.7.17-h2573ce8_7/bin/bwa index output/genome.fa



