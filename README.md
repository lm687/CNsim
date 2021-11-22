# CNsim

Simulations of derivative chromosomes for copy number signature validation

- Locally, I am using the snakemake environment
```
source activate snakemake-globalDA
```

- On HPC
```
source activate snakemake-cnsigs
#source activate snakemake-CNsim ## I don't know what this is
```

This conda env was created using
```
conda create -n snakemake-cnsigs -c conda-forge bioconda::snakemake bioconda::snakemake-minimal -c bioconda
```
and all appropriate R packages were downloaded afterwards


```
module load miniconda3-4.5.4-gcc-5.4.0-hivczbz
source activate snakemake-cnsigs
snakemake --cluster "sbatch -A MARKOWETZ-SL3-CPU -t 0:10:00 -p skylake --cores 1  --output=slurm_out/slurm-%j.out " --jobs 40 --printshellcmds
snakemake --cluster "sbatch -A MARKOWETZ-SL3-CPU -t 0:20:00 -p skylake --cores 1  --job-name CNsim --output=slurm_out/slurm-%j.out " --jobs 40 --printshellcmds
````

conda install -c conda-forge r-base=4.1.1



rsync -a output/output_genome2/outputRSVSim/ lm687@login-cpu.hpc.cam.ac.uk:/home/lm687/CNsim/RSVSim/output/output_genome2/outputRSVSim/


