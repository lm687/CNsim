#!/bin/sh
# properties = {"type": "single", "rule": "create_genome", "local": false, "input": ["exposures/07b96ad4-640b-48fb-8c60-04e63b5239b4"], "output": ["output/output_genome2/reads/sim_transloc_reads07b96ad4-640b-48fb-8c60-04e63b5239b4_nreads800_sizedels1.fa"], "wildcards": {"genome": "genome2", "name": "07b96ad4-640b-48fb-8c60-04e63b5239b4", "nreads": "800", "size_deletion": "1"}, "params": {}, "log": [], "threads": 1, "resources": {"tmpdir": "/tmp"}, "jobid": 240, "cluster": {}}
 cd /rds/user/lm687/hpc-work/CNsim/RSVSim && \
/home/lm687/.conda/envs/snakemake-cnsigs/bin/python3.9 \
-m snakemake output/output_genome2/reads/sim_transloc_reads07b96ad4-640b-48fb-8c60-04e63b5239b4_nreads800_sizedels1.fa --snakefile /rds/user/lm687/hpc-work/CNsim/RSVSim/Snakefile \
--force --cores all --keep-target-files --keep-remote --max-inventory-time 0 \
--wait-for-files /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.k7qfr4s1 exposures/07b96ad4-640b-48fb-8c60-04e63b5239b4 --latency-wait 5 \
 --attempt 1 --force-use-threads --scheduler ilp \
--wrapper-prefix https://github.com/snakemake/snakemake-wrappers/raw/ \
  -p --allowed-rules create_genome --nocolor --notemp --no-hooks --nolock --scheduler-solver-path /home/lm687/.conda/envs/snakemake-cnsigs/bin \
--mode 2  --default-resources "tmpdir=system_tmpdir"  && touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.k7qfr4s1/240.jobfinished || (touch /rds/user/lm687/hpc-work/CNsim/RSVSim/.snakemake/tmp.k7qfr4s1/240.jobfailed; exit 1)

