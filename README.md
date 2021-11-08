# CNsim

Simulations of derivative chromosomes for copy number signature validation


Locally, I am using the snakemake environment
```
source activate snakemake-globalDA
```

on HPC
source activate snakemake-CNsim


Conda env:

Created using
```
conda create -n snakemake-cnsigs -c conda-forge bioconda::snakemake bioconda::snakemake-minimal -c bioconda
```


```
module load miniconda3-4.5.4-gcc-5.4.0-hivczbz
source activate snakemake-cnsigs
snakemake --cluster "sbatch -A MARKOWETZ-SL3-CPU -t 0:10:00 -p skylake --cores 1  --output=slurm_out/slurm-%j.out " --jobs 40 --printshellcmds
````

conda install -c conda-forge r-base=4.1.1



